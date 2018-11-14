From: nsaenzjulienne@suse.de (Nicolas Saenz Julienne)
Date: Wed, 14 Nov 2018 13:59:26 +0100
Subject: [PATCH 00/16] staging: vchiq: dead code removal & misc fixes
Message-ID: <20181114125942.25163-1-nsaenzjulienne@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This series was written in parallel with reading and understanding the
vchiq code. So excuse me for the lack of logic in the sequence of
patches.

The main focus was to delete as much code as possible, I've counted
around 550 lines, which is not bad. Apart from that there are some
patches enforcing proper kernel APIs usage.

The only patch that really changes code is the
vchiq_ioc_copy_element_data() rewrite.

The last commit updates the TODO list with some of my observations, I
realise some of the might be a little opinionated. If anything it's
going to force a discussion on the topic, which is nice.

It was developed on top of the latest linux-next, and was tested on a
RPIv3B+ with audio, video and running vchiq_test.

Regards,
Nicolas

===

Nicolas Saenz Julienne (16):
  staging: vchiq_core: rework vchiq_get_config
  staging: vchiq_arm: rework close/remove_service IOCTLS
  staging: vchiq_shim: delete vchi_service_create
  staging: vchiq_arm: use list_for_each_entry when accessing
    bulk_waiter_list
  staging: vchiq_arm: get rid of vchi_mh.h
  staging: vchiq_arm: rework vchiq_ioc_copy_element_data
  staging: vchiq-core: get rid of is_master distinction
  staging: vchiq_core: remove unnecessary safety checks in
    vchiq_init_state
  staging: vchiq_core: do not initialize semaphores twice
  staging: vchiq_core: don't add a wmb() before remote_event_signal()
  staging: vchiq: use completions instead of semaphores
  staging: vchiq_util: get rid of unneeded memory barriers
  staging: vchiq_core: fix logic redundancy in parse_open
  staging: vchiq_arm: rework probe and init functions
  staging: vchiq_arm: fix open/release cdev functions
  staging: vchiq: add more tasks to the TODO list

 .../staging/vc04_services/interface/vchi/TODO |  42 ++
 .../vc04_services/interface/vchi/vchi.h       |   8 -
 .../vc04_services/interface/vchi/vchi_mh.h    |  42 --
 .../interface/vchiq_arm/vchiq_2835_arm.c      |  18 +-
 .../interface/vchiq_arm/vchiq_arm.c           | 598 ++++++++----------
 .../interface/vchiq_arm/vchiq_core.c          | 523 ++++-----------
 .../interface/vchiq_arm/vchiq_core.h          |  47 +-
 .../interface/vchiq_arm/vchiq_if.h            |  11 +-
 .../interface/vchiq_arm/vchiq_shim.c          |  32 -
 .../interface/vchiq_arm/vchiq_util.c          |  48 +-
 .../interface/vchiq_arm/vchiq_util.h          |   6 +-
 11 files changed, 435 insertions(+), 940 deletions(-)
 delete mode 100644 drivers/staging/vc04_services/interface/vchi/vchi_mh.h

-- 
2.19.1
