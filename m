From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue, 30 Nov 2010 20:07:37 +0800
Subject: [PATCH 0/3] OMAP: Introduce Backlight driver for Sharp LS037V7DW01
	LCD panel
Message-ID: <1291118860-10325-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After instroducing generic DPI panel driver for OMAP DSS2 system, we need to
split out backlight driver from Sharp LS037V7DW01 panel driver before we move
to the generic DPI panel driver.

This patchset introcuded backlight driver and cleanup the old Sharp LS037V7DW01
panel driver related code.

It's built on mainline 2.6.37-rc4

Bryan Wu (3):
  Backlight: driver for Sharp LS037V7DW01 panel on OMAP machine
  OMAP: move Sharp LS LCD panel device to generic DPI panel driver and new backlight driver
  OMAP: DSS2: remove Sharp LS037V7DW01 panel driver

 arch/arm/mach-omap2/board-3430sdp.c                |   18 ++-
 arch/arm/mach-omap2/board-omap3evm.c               |   20 ++-
 drivers/video/backlight/Kconfig                    |   10 +
 drivers/video/backlight/Makefile                   |    1 +
 drivers/video/backlight/sharp_ls037v7dw01.c        |  144 ++++++++++++
 drivers/video/omap2/displays/Kconfig               |    7 -
 drivers/video/omap2/displays/Makefile              |    1 -
 .../video/omap2/displays/panel-sharp-ls037v7dw01.c |  232 --------------------
 8 files changed, 187 insertions(+), 246 deletions(-)
 create mode 100644 drivers/video/backlight/sharp_ls037v7dw01.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-ls037v7dw01.c
