From: eric@anholt.net (Eric Anholt)
Date: Mon,  3 Oct 2016 11:52:05 -0700
Subject: [PATCH 0/4] staging: Fix build of VCHIQ driver.
Message-ID: <20161003185209.27733-1-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a series of fixes for the vchiq driver that Greg recently
added to his staging-testing branch.

A full tree with nasty patches to add the other drivers necessary to
do "vcdbg log msg" is available at:

https://github.com/anholt/linux/tree/vchiq

Eric Anholt (4):
  staging/vchi: Convert to current get_user_pages() arguments.
  staging/vchi: Update for rename of page_cache_release() to put_page().
  ARM: bcm2835: Add #define for VCHIQ property message.
  drivers/vchi: Remove dependency on CONFIG_BROKEN.

 drivers/staging/vc04_services/Kconfig                              | 2 +-
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c | 6 +++---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c      | 5 ++---
 include/soc/bcm2835/raspberrypi-firmware.h                         | 2 ++
 4 files changed, 8 insertions(+), 7 deletions(-)

-- 
2.9.3
