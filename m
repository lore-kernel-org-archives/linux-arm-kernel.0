From: eric@anholt.net (Eric Anholt)
Date: Mon, 17 Oct 2016 12:44:01 -0700
Subject: [PATCH 0/5] staging/vchi: Start on 64-bit cleanup, TODO file.
Message-ID: <20161017194406.1080-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a little cleanup of VCHI this morning, working toward building
on aarch64 (not there yet) and adding some notes on what I think we
need to do with the driver.

Eric Anholt (5):
  staging/vchi: Fix build error in debugfs ops on aarch64.
  staging/vchi: Fix build warnings when formatting pointers on aarch64.
  staging/vchi: Fix some pointer math for 64-bit.
  staging/vchi: Add a TODO file of things I know we need to deal with.
  MAINTAINERS: Add the staging vchiq driver as a bcm2835 responsibility.

 MAINTAINERS                                        |   1 +
 drivers/staging/vc04_services/interface/vchi/TODO  |  50 ++++++
 .../interface/vchiq_arm/vchiq_2835_arm.c           |  15 +-
 .../vc04_services/interface/vchiq_arm/vchiq_arm.c  |  32 ++--
 .../vc04_services/interface/vchiq_arm/vchiq_core.c | 183 +++++++++++----------
 .../interface/vchiq_arm/vchiq_debugfs.c            |   4 +-
 6 files changed, 168 insertions(+), 117 deletions(-)
 create mode 100644 drivers/staging/vc04_services/interface/vchi/TODO

-- 
2.9.3
