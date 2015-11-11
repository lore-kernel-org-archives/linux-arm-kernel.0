From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Wed, 11 Nov 2015 16:06:46 +0000
Subject: [PATCH v2 0/4] drm: Add support for the ARM HDLCD display controller
Message-ID: <1447258010-2234-1-git-send-email-Liviu.Dudau@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for ARM's HDLCD display controller found in Juno
and ARM TC2 Coretile. The HDLCD outputs an RGB stream that feeds into a
single digital encoder (DVI or HDMI).

This series depends on Sudeep Holla's series that introduces support for
SCPI on Juno. This is now queued for v4.4-rc1 hence this patchset has been
produced on top of linux-next as of 11th of November 2015. I have pushed
the tested branch here for people that want to use it:

  git://git://linux-arm.org/linux-ld testing/hdlcd

It also needs the tda998x patches that I have recently published [1].

Only the Juno functionality has been tested as the TC2 Coretile require
a working SiI9022 driver for VExpress that is not subject of this patchset.

This is my first driver for the DRM subsystem and as such probably contains
misuses of the APIs that I will be glad to correct if pointed out.

Changelog:
v2: Added support for atomic modeset
v1: Original DRM submission can be found here [2]

[1] http://lists.freedesktop.org/archives/dri-devel/2015-November/094172.html
[2] http://lists.freedesktop.org/archives/dri-devel/2015-August/087685.html

Best regards,
Liviu

Liviu Dudau (4):
  drm: arm: Add DT bindings documentation for HDLCD driver.
  drm: Add support for ARM's HDLCD controller.
  arm64: Juno: Add HDLCD support to the Juno boards.
  MAINTAINERS: Add Liviu Dudau as maintainer for ARM HDLCD driver.

 .../devicetree/bindings/drm/arm/arm,hdlcd.txt      |  74 +++
 MAINTAINERS                                        |   6 +
 arch/arm64/boot/dts/arm/juno-base.dtsi             |  74 ++-
 drivers/gpu/drm/Kconfig                            |   2 +
 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/arm/Kconfig                        |  29 ++
 drivers/gpu/drm/arm/Makefile                       |   2 +
 drivers/gpu/drm/arm/hdlcd_crtc.c                   | 334 ++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.c                    | 563 +++++++++++++++++++++
 drivers/gpu/drm/arm/hdlcd_drv.h                    |  42 ++
 drivers/gpu/drm/arm/hdlcd_regs.h                   |  87 ++++
 11 files changed, 1210 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/drm/arm/arm,hdlcd.txt
 create mode 100644 drivers/gpu/drm/arm/Kconfig
 create mode 100644 drivers/gpu/drm/arm/Makefile
 create mode 100644 drivers/gpu/drm/arm/hdlcd_crtc.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.c
 create mode 100644 drivers/gpu/drm/arm/hdlcd_drv.h
 create mode 100644 drivers/gpu/drm/arm/hdlcd_regs.h

-- 
2.6.0
