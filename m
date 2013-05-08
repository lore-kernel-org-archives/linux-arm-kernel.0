From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 8 May 2013 21:05:52 +0800
Subject: [PATCH 0/3] ARM: imx/mxs: fixes for 3.10-rc1
Message-ID: <1368018355-26014-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

It seems that you will have a few other fixes to send mainline for
3.10-rc1 inclusion before merge window closes.  In that case, can you
please include the following 3 which fix imx/mxs compile errors that
are currently seen on mainline?

Shawn

Fabio Estevam (2):
  ARM: imx: Select GENERIC_ALLOCATOR
  video: mxsfb: Adapt to new videomode API

Shawn Guo (1):
  ARM: imx: compile fix for hotplug.c

 arch/arm/mach-imx/Kconfig              |    5 +--
 arch/arm/mach-imx/Makefile             |    1 -
 arch/arm/mach-imx/common.h             |    1 +
 arch/arm/mach-imx/hotplug.c            |    2 +
 arch/arm/mach-imx/iram_alloc.c         |   73 --------------------------------
 drivers/video/Kconfig                  |    2 +-
 drivers/video/mxsfb.c                  |    8 ++--
 include/linux/platform_data/imx-iram.h |   41 ------------------
 8 files changed, 9 insertions(+), 124 deletions(-)
 delete mode 100644 arch/arm/mach-imx/iram_alloc.c
 delete mode 100644 include/linux/platform_data/imx-iram.h

-- 
1.7.9.5
