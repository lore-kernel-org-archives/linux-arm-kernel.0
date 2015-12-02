From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed,  2 Dec 2015 12:22:58 +0000
Subject: [PATCH v3 0/4] drm: Add support for the ARM HDLCD display controller
Message-ID: <1449058982-18595-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM's HDLCD display controller found in Juno
and ARM TC2 Coretile. The HDLCD outputs an RGB stream that feeds into a
single digital encoder (DVI or HDMI).

This series depends on Sudeep Holla's SCPI driver (now in mainline) and on
the tda998x patches that have been queued on Russell's patch system here [1].

Only the Juno functionality has been tested as the TC2 Coretile require
a working SiI9022 driver for VExpress that is not subject of this patchset.

Changelog:
v3: Changed the driver to use the memory-region phandle for bespoke framebuffers.
v2: Added support for atomic modeset [2]
v1: Original DRM submission [3]

[1] http://www.arm.linux.org.uk/developer/patches/search.php?uid=2895
[2] http://lists.freedesktop.org/archives/dri-devel/2015-November/094177.html
[3] http://lists.freedesktop.org/archives/dri-devel/2015-August/087685.html

Best regards,
Liviu

Liviu Dudau (4):
  drm: arm: Add DT bindings documentation for HDLCD driver.
  drm: Add support for ARM's HDLCD controller.
  arm64: Juno: Add HDLCD support to the Juno boards.
  MAINTAINERS: Add Liviu Dudau as maintainer for ARM HDLCD driver.

 .../devicetree/bindings/display/arm,hdlcd.txt      |  79 +++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  46 +-
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/arm/Kconfig                        |  29 ++
 drivers/gpu/drm/arm/Makefile                       |   2 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 334 +++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.c                    | 555 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
 drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
 11 files changed, 1179 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/arm,hdlcd.txt
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

-- 
2.6.2
