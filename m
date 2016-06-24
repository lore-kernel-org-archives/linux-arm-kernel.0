From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Jun 2016 12:49:55 +0200
Subject: [PATCH 0/6] kill off cpu_is_mx*()
Message-ID: <20160624105001.3166287-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I noticed that i.MX still uses the traditional cpu_is_* functions to
tell the difference between various SoC families, but every single
user of those can be replaced with a simpler way, so we can just
remove it all.

Please review and apply for 4.8 if it looks good to you.

Arnd Bergmann (6):
  ARM: imx: remove cpu_is_mx1 check
  ARM: imx: deconstruct mxc_rnga initialization
  ARM: imx: deconstruct mx3_idle
  ARM: imx: rework mx27_pm_init() call
  ARM: imx: remove last call to cpu_is_mx5*
  ARM: imx: remove cpu_is_mx*()

 arch/arm/mach-imx/Kconfig                     |   4 -
 arch/arm/mach-imx/Makefile                    |   4 +-
 arch/arm/mach-imx/common.h                    |   2 +
 arch/arm/mach-imx/cpu-imx5.c                  |   8 --
 arch/arm/mach-imx/cpu.c                       |   2 -
 arch/arm/mach-imx/devices/Kconfig             |   4 -
 arch/arm/mach-imx/devices/platform-mxc_rnga.c |  53 --------------
 arch/arm/mach-imx/imx27-dt.c                  |   1 +
 arch/arm/mach-imx/imx31-dt.c                  |  12 +++
 arch/arm/mach-imx/mm-imx1.c                   |   2 +-
 arch/arm/mach-imx/mm-imx27.c                  |   2 +
 arch/arm/mach-imx/mm-imx3.c                   |  32 +++++++-
 arch/arm/mach-imx/mxc.h                       | 101 --------------------------
 arch/arm/mach-imx/pm-imx27.c                  |   8 +-
 arch/arm/mach-imx/pm-imx3.c                   |  38 ----------
 arch/arm/mach-imx/system.c                    |  16 ++--
 16 files changed, 58 insertions(+), 231 deletions(-)
 delete mode 100644 arch/arm/mach-imx/devices/platform-mxc_rnga.c
 delete mode 100644 arch/arm/mach-imx/pm-imx3.c

-- 
2.9.0
