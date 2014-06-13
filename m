From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:02 +0200
Subject: [PATCH 00/14] arm-soc fixes for 3.16 review
Message-ID: <1402675276-538682-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

here are the fixes I've picked up so far as the last pull request
for the merge window. I'm sure there will be a lot more in the
future, but let us know if I missed something or if any of the
patches (in particular mine, some of which I have not posted
before) are not ok.

Arnd Bergmann (6):
  ARM: mvebu: fix randconfig builds for pmsu driver
  ARM: omap2: fix am43xx dependency on l2x0 cache
  ARM: keystone requires ARM_PATCH_PHYS_VIRT
  bus/arm-cci: add dependency on OF && CPU_V7
  remoteproc: da8xx: don't select CMA on no-MMU
  ARM: samsung: make SAMSUNG_DMADEV optional

Dan Carpenter (1):
  misc: vexpress: fix error handling vexpress_syscfg_regmap_init()

Jason Cooper (1):
  ARM: mvebu: DT: fix OpenBlocks AX3-4 RAM size

Linus Walleij (1):
  ARM: integrator: fix section mismatch problem

Olof Johansson (1):
  ARM: exynos: move sysram info to exynos.c

Rob Herring (2):
  ARM: exynos: cleanup kconfig option display
  ARM: use menuconfig for sub-arch menus

Sachin Kamat (1):
  ARM: EXYNOS: Fix compilation warning

Stephen Boyd (1):
  ARM: Remove ARCH_HAS_CPUFREQ config option

 arch/arm/Kconfig                                 | 20 +--------------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  2 +-
 arch/arm/configs/omap2plus_defconfig             |  1 +
 arch/arm/mach-bcm/Kconfig                        |  7 +++---
 arch/arm/mach-berlin/Kconfig                     |  6 +----
 arch/arm/mach-cns3xxx/Kconfig                    |  7 +++---
 arch/arm/mach-davinci/Kconfig                    |  1 -
 arch/arm/mach-exynos/Kconfig                     |  7 +-----
 arch/arm/mach-exynos/common.h                    |  1 +
 arch/arm/mach-exynos/exynos.c                    | 31 +++++++++++++++++++++++-
 arch/arm/mach-exynos/platsmp.c                   | 26 ++------------------
 arch/arm/mach-highbank/Kconfig                   |  1 -
 arch/arm/mach-imx/Kconfig                        | 10 +++-----
 arch/arm/mach-integrator/Kconfig                 |  2 +-
 arch/arm/mach-integrator/impd1.c                 | 12 ++++++++-
 arch/arm/mach-keystone/Kconfig                   |  1 +
 arch/arm/mach-moxart/Kconfig                     |  2 +-
 arch/arm/mach-mvebu/Kconfig                      |  8 ++----
 arch/arm/mach-mvebu/pmsu.c                       |  9 ++++++-
 arch/arm/mach-nomadik/Kconfig                    |  4 +--
 arch/arm/mach-omap2/Kconfig                      | 11 +++++----
 arch/arm/mach-omap2/common.h                     |  7 ++++++
 arch/arm/mach-prima2/Kconfig                     |  6 ++---
 arch/arm/mach-qcom/Kconfig                       |  6 +----
 arch/arm/mach-s3c24xx/Kconfig                    |  2 +-
 arch/arm/mach-s3c64xx/Kconfig                    |  4 +--
 arch/arm/mach-s5p64x0/Kconfig                    |  6 +++--
 arch/arm/mach-s5pc100/Kconfig                    |  3 ++-
 arch/arm/mach-s5pv210/Kconfig                    |  3 ++-
 arch/arm/mach-shmobile/Kconfig                   |  6 ++---
 arch/arm/mach-spear/Kconfig                      |  1 -
 arch/arm/mach-tegra/Kconfig                      |  8 +++---
 arch/arm/mach-u300/Kconfig                       |  6 +----
 arch/arm/mach-ux500/Kconfig                      |  7 +-----
 arch/arm/mach-vexpress/Kconfig                   |  8 +++---
 arch/arm/mach-vt8500/Kconfig                     |  1 -
 arch/arm/mach-zynq/Kconfig                       |  1 -
 arch/arm/plat-samsung/Kconfig                    | 28 ++++++---------------
 drivers/bus/Kconfig                              |  2 +-
 drivers/misc/vexpress-syscfg.c                   | 12 ++++++---
 drivers/remoteproc/Kconfig                       |  2 +-
 41 files changed, 127 insertions(+), 161 deletions(-)

-- 
1.8.3.2

Cc: andrew at lunn.ch
Cc: arnd at arndb.de
Cc: ben-linux at fluff.org
Cc: dan.carpenter at oracle.com
Cc: daniel.lezcano at linaro.org
Cc: gregory.clement at free-electrons.com
Cc: jason at lakedaemon.net
Cc: khilman at linaro.org
Cc: kgene.kim at samsung.com
Cc: linus.walleij at linaro.org
Cc: lorenzo.pieralisi at arm.com
Cc: ohad at wizery.com
Cc: olof at lixom.net
Cc: pawel.moll at arm.com
Cc: robh at kernel.org
Cc: rtivy at ti.com
Cc: linux at arm.linux.org.uk
Cc: sachin.kamat at linaro.org
Cc: santosh.shilimkar at ti.com
Cc: sebastian.hesselbarth at gmail.com
Cc: shawn.guo at linaro.org
Cc: sboyd at codeaurora.org
Cc: t.figa at samsung.com
Cc: tony at atomide.com
Cc: tushar.behera at linaro.org
Cc: viresh.kumar at linaro.org
Cc:  linux-omap at vger.kernel.org
Cc:  linux-samsung-soc at vger.kernel.org
