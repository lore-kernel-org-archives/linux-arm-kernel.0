From: bryan.wu@canonical.com (Bryan Wu)
Date: Wed, 17 Nov 2010 10:23:57 +0800
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver (try
	#7)
Message-ID: <1289960640-8782-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 4 duplicated DPI panel drivers in DSS2 display driver. They are
similar and a generic DPI panel driver can support all them with specific
panel configuration. And new DPI panel driver can be easily supported
by adding panel configurations into generic panel DPI driver.

This patchset introduces a generic panel DPI driver, remove 3 panel drivers and enable
generic panel DPI driver in board files. And it is based on 2.6.37-rc2.

Building with omap2plus_defconfig is successful.

Keep sharp_ls_panel, since it contains blacklight control code which will be
moved out later.

Bryan Wu (3):
  OMAP: DSS2: Add generic DPI panel display driver
  OMAP: use generic DPI panel driver in board files
  OMAP: DSS2: remove generic DPI panel driver duplicated panel drivers

 arch/arm/mach-omap2/board-3430sdp.c                |   12 +-
 arch/arm/mach-omap2/board-am3517evm.c              |   23 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |   23 +-
 arch/arm/mach-omap2/board-devkit8000.c             |   26 +-
 arch/arm/mach-omap2/board-igep0020.c               |   12 +-
 arch/arm/mach-omap2/board-omap3beagle.c            |   12 +-
 arch/arm/mach-omap2/board-omap3evm.c               |   12 +-
 arch/arm/mach-omap2/board-omap3stalker.c           |   23 +-
 .../arm/plat-omap/include/plat/panel-generic-dpi.h |   37 ++
 drivers/video/omap2/displays/Kconfig               |   22 +-
 drivers/video/omap2/displays/Makefile              |    4 +-
 drivers/video/omap2/displays/panel-generic-dpi.c   |  348 ++++++++++++++++++++
 drivers/video/omap2/displays/panel-generic.c       |  174 ----------
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 ---------
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 ---------
 15 files changed, 497 insertions(+), 560 deletions(-)
 create mode 100644 arch/arm/plat-omap/include/plat/panel-generic-dpi.h
 create mode 100644 drivers/video/omap2/displays/panel-generic-dpi.c
 delete mode 100644 drivers/video/omap2/displays/panel-generic.c
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c
