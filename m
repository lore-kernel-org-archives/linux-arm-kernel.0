From: bryan.wu@canonical.com (Bryan Wu)
Date: Tue,  2 Nov 2010 16:39:49 -0400
Subject: [PATCH 0/3] OMAP: DSS2: introduce generic panel display driver
Message-ID: <1288730392-11223-1-git-send-email-bryan.wu@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 4 duplicated panel drivers in DSS2 display driver. They are similar
and generic panel driver can support all them with specific panel configuration.
And new panel driver can be easily supported by adding panel configurations
into generic panel driver.

This patchset introduces generic panel driver, remove 3 panel drivers and enable
generic panel driver in board files. And it is based on 2.6.37-rc1.

Building with omap2plus_defconfig is successful.

Keep sharp_ls_panel, since it contains blacklight control code which will be
moved out later.

Bryan Wu (3):
  OMAP: DSS2: Add generic panel display driver
  OMAP: DSS2: remove generic panel driver duplicated panel drivers
  OMAP: use generic panel driver in board files

 arch/arm/mach-omap2/board-3430sdp.c                |    1 +
 arch/arm/mach-omap2/board-am3517evm.c              |    4 +-
 arch/arm/mach-omap2/board-cm-t35.c                 |    4 +-
 arch/arm/mach-omap2/board-devkit8000.c             |    2 +
 arch/arm/mach-omap2/board-igep0020.c               |    1 +
 arch/arm/mach-omap2/board-omap3beagle.c            |    1 +
 arch/arm/mach-omap2/board-omap3evm.c               |    1 +
 arch/arm/mach-omap2/board-omap3stalker.c           |    2 +
 arch/arm/plat-omap/include/plat/display.h          |   28 +++-
 drivers/video/omap2/displays/Kconfig               |   16 +--
 drivers/video/omap2/displays/Makefile              |    2 -
 drivers/video/omap2/displays/panel-generic.c       |  153 ++++++++++++++++--
 .../video/omap2/displays/panel-sharp-lq043t1dg01.c |  165 --------------------
 .../video/omap2/displays/panel-toppoly-tdo35s.c    |  164 -------------------
 14 files changed, 175 insertions(+), 369 deletions(-)
 delete mode 100644 drivers/video/omap2/displays/panel-sharp-lq043t1dg01.c
 delete mode 100644 drivers/video/omap2/displays/panel-toppoly-tdo35s.c
