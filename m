From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 18 May 2012 14:27:10 +0200
Subject: No subject
Message-ID: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

The following adds a drm/kms driver for the Freescale i.MX LCDC
controller. Most notable change to the last SDRM based version is that
the SDRM layer has been removed and the driver now is purely i.MX
specific. I hope that this is more acceptable now.

Another change is that the probe is now devicetree based. For now I
took the easy way out and only put an edid blob into the devicetree.
I haven't documented the binding yet, I would add that when the rest
is considered ok.

Comments very welcome.

Thanks
 Sascha

----------------------------------------------------------------
Sascha Hauer (2):
      DRM: add Freescale i.MX LCDC driver
      pcm038 lcdc support

 arch/arm/boot/dts/imx27-phytec-phycore.dts |   39 ++
 arch/arm/boot/dts/imx27.dtsi               |    7 +
 arch/arm/mach-imx/clock-imx27.c            |    1 +
 drivers/gpu/drm/Kconfig                    |    2 +
 drivers/gpu/drm/Makefile                   |    1 +
 drivers/gpu/drm/imx/Kconfig                |   18 +
 drivers/gpu/drm/imx/Makefile               |    8 +
 drivers/gpu/drm/imx/imx-drm-core.c         |  745 ++++++++++++++++++++++++++++
 drivers/gpu/drm/imx/imx-fb.c               |  179 +++++++
 drivers/gpu/drm/imx/imx-fbdev.c            |  275 ++++++++++
 drivers/gpu/drm/imx/imx-gem.c              |  343 +++++++++++++
 drivers/gpu/drm/imx/imx-lcdc-crtc.c        |  517 +++++++++++++++++++
 drivers/gpu/drm/imx/imx-parallel-display.c |  228 +++++++++
 13 files changed, 2363 insertions(+)
 create mode 100644 drivers/gpu/drm/imx/Kconfig
 create mode 100644 drivers/gpu/drm/imx/Makefile
 create mode 100644 drivers/gpu/drm/imx/imx-drm-core.c
 create mode 100644 drivers/gpu/drm/imx/imx-fb.c
 create mode 100644 drivers/gpu/drm/imx/imx-fbdev.c
 create mode 100644 drivers/gpu/drm/imx/imx-gem.c
 create mode 100644 drivers/gpu/drm/imx/imx-lcdc-crtc.c
 create mode 100644 drivers/gpu/drm/imx/imx-parallel-display.c
