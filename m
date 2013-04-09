From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 9 Apr 2013 23:19:33 +0800
Subject: [GIT PULL 2/4] ARM: imx: cleanup for 3.10
In-Reply-To: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
References: <1365520775-28478-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1365520775-28478-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07961ac7c0ee8b546658717034fe692fd12eefa9:

  Linux 3.9-rc5 (2013-03-31 15:12:43 -0700)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/imx-cleanup-3.10

for you to fetch changes up to 3442a7b51d1cfae144f3289ab0be44e27c236f53:

  ARM: i.MX: remove unused ARCH_* configs (2013-04-09 21:07:36 +0800)

----------------------------------------------------------------
The imx cleanup for 3.10:

* Clean up a couple of unneeded function declarations
* Remove imx specific cpufreq driver as generic cpufreq-cpu0 works well
  as the replacement
* Remove platform ahci support
* Clean up unused ARCH/MACH Kconfig symbols
* Remove a couple of unused files

----------------------------------------------------------------
Fabio Estevam (2):
      ARM: imx: avic: Move avic_saved_mask_reg under CONFIG_PM
      ARM: imx: clk-imx27: Do not register peripheral clock for SSI

Markus Pargmann (1):
      ARM: imx: Remove cpufreq driver

Paul Bolle (1):
      ARM: i.MX: remove unused ARCH_* configs

Sascha Hauer (1):
      ARM i.MX53: remove platform ahci support

Shawn Guo (4):
      ARM: imx: remove duplicated function declaration
      ARM: imx: remove pl310_get_save_ptr() declaration
      ARM: imx: remove Makefile.boot
      ARM: imx: remove mx6q.h

 arch/arm/Kconfig                              |    7 -
 arch/arm/mach-imx/Kconfig                     |   18 ---
 arch/arm/mach-imx/Makefile                    |    3 +-
 arch/arm/mach-imx/Makefile.boot               |   35 -----
 arch/arm/mach-imx/avic.c                      |    4 +-
 arch/arm/mach-imx/clk-imx27.c                 |    2 -
 arch/arm/mach-imx/common.h                    |    3 -
 arch/arm/mach-imx/cpu_op-mx51.c               |   31 ----
 arch/arm/mach-imx/cpu_op-mx51.h               |   14 --
 arch/arm/mach-imx/cpufreq.c                   |  206 -------------------------
 arch/arm/mach-imx/devices/Kconfig             |    4 -
 arch/arm/mach-imx/devices/Makefile            |    1 -
 arch/arm/mach-imx/devices/devices-common.h    |   10 --
 arch/arm/mach-imx/devices/platform-ahci-imx.c |  157 -------------------
 arch/arm/mach-imx/hardware.h                  |    1 -
 arch/arm/mach-imx/mach-cpuimx51sd.c           |    5 -
 arch/arm/mach-imx/mach-mx51_babbage.c         |    4 -
 arch/arm/mach-imx/mx6q.h                      |   31 ----
 18 files changed, 3 insertions(+), 533 deletions(-)
 delete mode 100644 arch/arm/mach-imx/Makefile.boot
 delete mode 100644 arch/arm/mach-imx/cpu_op-mx51.c
 delete mode 100644 arch/arm/mach-imx/cpu_op-mx51.h
 delete mode 100644 arch/arm/mach-imx/cpufreq.c
 delete mode 100644 arch/arm/mach-imx/devices/platform-ahci-imx.c
 delete mode 100644 arch/arm/mach-imx/mx6q.h
