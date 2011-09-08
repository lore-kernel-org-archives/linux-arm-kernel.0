From: deepthy.ravi@ti.com (Deepthy Ravi)
Date: Thu, 8 Sep 2011 19:03:12 +0530
Subject: [PATCH 0/8] OMAP3EVM: Add tvp514x video decoder support
Message-ID: <1315488792-15949-1-git-send-email-deepthy.ravi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset
        -add support for tvp514x video decoder on omap3evm and also migrate the
         decoder driver to media controller framework.
        -add support for BT656 interface.
        -enable multimedia driver and tvp514x decoder support in omap2plus_defconfig.

It is dependent on the following patch
https://patchwork.kernel.org/patch/1062042/ which moves
platform data definitions from isp.h to media/omap3isp.h

Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---

Deepthy Ravi (1):
  omap2plus_defconfig: Enable tvp514x video decoder support

Vaibhav Hiremath (7):
  omap3evm: Enable regulators for camera interface
  omap3evm: Add Camera board init/hookup file
  tvp514x: Migrate to media-controller framework
  ispvideo: Add support for G/S/ENUM_STD ioctl
  ispccdc: Configure CCDC registers
  ispccdc: Add support for BT656 interface
  omap3evm: camera: Configure BT656 interface

 arch/arm/configs/omap2plus_defconfig        |   10 +
 arch/arm/mach-omap2/Makefile                |    5 +
 arch/arm/mach-omap2/board-omap3evm-camera.c |  258 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3evm.c        |   44 +++++
 drivers/media/video/omap3isp/ispccdc.c      |  185 +++++++++++++++-----
 drivers/media/video/omap3isp/ispreg.h       |    1 +
 drivers/media/video/omap3isp/ispvideo.c     |  106 +++++++++++-
 drivers/media/video/omap3isp/ispvideo.h     |    5 +-
 drivers/media/video/tvp514x.c               |  241 ++++++++++++++++++++++---
 include/media/omap3isp.h                    |    7 +
 include/media/tvp514x.h                     |    3 +
 include/media/v4l2-subdev.h                 |    7 +-
 12 files changed, 797 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap3evm-camera.c
