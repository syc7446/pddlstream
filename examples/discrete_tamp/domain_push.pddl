(define (domain pick-and-place)
  (:requirements :strips :equality)
  (:predicates
    (Conf ?q)
    (Block ?b)
    (Pose ?p)
    (AtPose ?p ?q)
    (AtConf ?q)
    (HandEmpty)
    (CFree ?p1 ?p2)
    (Push ?p1 ?q1 ?p2 ?q2)
    ;(Push ?p1 ?q1 ?p2 ?q2 ?t)
    (Unsafe ?p)
    (CanMove)
  )
  (:functions
    (Distance ?q1 ?q2)
  )
  (:action move
    :parameters (?q1 ?q2)
    :precondition (and (Conf ?q1) (Conf ?q2)
                       (AtConf ?q1)) ; (CanMove))
    :effect (and (AtConf ?q2)
                 (not (AtConf ?q1)) (not (CanMove))
                 (increase (total-cost) 1))
                 ;(increase (total-cost) (Distance ?q1 ?q2)))
  )
  (:action push
    :parameters (?b ?p1 ?q1 ?p2 ?q2)
    :precondition (and (Block ?b) (Push ?p1 ?q1 ?p2 ?q2)
                       (AtPose ?b ?p1) (AtConf ?q1)) ; (HandEmpty))
    :effect (and (AtPose ?b ?p2) (AtConf ?q2) (CanMove)
                 (not (AtPose ?b ?p1)) (not (AtConf ?q1))
                 (increase (total-cost) 1))
  )
  ;(:derived (Unsafe ?p1)
  ;  (exists (?b ?p2) (and (Pose ?p1) (not (CFree ?p1 ?p2))
  ;                        (AtPose ?b ?p2)))
  ;)
)