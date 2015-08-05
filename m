From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed,  5 Aug 2015 15:28:08 +0100
Subject: [PATCH 0/4] drm: Add support for the ARM HDLCD display controller
Message-ID: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM's HDLCD display controller found in Juno
and ARM TC2 Coretile. The HDLCD outputs an RGB stream that feeds into a
single digital encoder (DVI or HDMI).

This series depends on Sudeep Holla's series that introduces support for
SCPI[1] on Juno.

Only the Juno functionality has been tested as the TC2 Coretile require
a working SiI9022 driver for VExpress that is not subject of this patchset.

This is my first driver for the DRM subsystem and as such probably contains
misuses of the APIs that I will be glad to correct if pointed out.

Best regards,
Liviu


[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/362219.html

Liviu Dudau (4):
  drm: arm: Add DT bindings documentation for HDLCD driver.
  drm: Add support for ARM's HDLCD controller.
  arm64: Juno: Add HDLCD support to the Juno boards.
  MAINTAINERS: Add Liviu Dudau as maintainer for ARM HDLCD driver.

 .../devicetree/bindings/drm/arm/arm,hdlcd.txt      |  74 ++++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  70 ++-
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/arm/Kconfig                        |  20 +
 drivers/gpu/drm/arm/Makefile                       |   2 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 265 +++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.c                    | 490 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h                    |  51 +++
 drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
 11 files changed, 1066 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/arm/arm,hdlcd.txt
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

-- 
2.4.6
