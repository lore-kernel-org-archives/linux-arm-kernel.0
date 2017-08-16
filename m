From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 16 Aug 2017 10:45:22 -0700
Subject: [PATCH 0/3] Add Support for Broadcom D1W controller
Message-ID: <1502905525-5646-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Broadcom Dallas One wire (D1W) bus master controller.

This patch series adds a callback for the ds1wm read/write functions
to the common DS1W driver code and the Broadcom specific DS1W controller.

Shreesha Rajashekar (3):
  dt-bindings: mfd: d1w: iproc: Documentation for d1w driver
  w1: d1w: Provide callback for ds1wm read/write
  mfd: d1w: iproc: Add d1w driver

 .../devicetree/bindings/mfd/brcm,iproc-d1w.txt     |  27 +++
 drivers/mfd/Kconfig                                |  11 ++
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bcm-iproc-d1w.c                        | 202 +++++++++++++++++++++
 drivers/w1/masters/ds1wm.c                         |  18 +-
 include/linux/mfd/ds1wm.h                          |   2 +
 6 files changed, 259 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/brcm,iproc-d1w.txt
 create mode 100644 drivers/mfd/bcm-iproc-d1w.c

-- 
2.5.0
