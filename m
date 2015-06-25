From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Jun 2015 15:31:00 -0700
Subject: [GIT PULL 1/5] ARM: SoC: cleanups for v4.2
In-Reply-To: <1435271464-11455-1-git-send-email-khilman@kernel.org>
References: <1435271464-11455-1-git-send-email-khilman@kernel.org>
Message-ID: <1435271464-11455-2-git-send-email-khilman@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A relatively small setup of cleanups this time around, and similar to last time
the bulk of it is removal of legacy board support:

- OMAP: removal of legacy (non-DT) booting for several platforms
- i.MX: remove some legacy board files

Conflicts: None

----------------------------------------------------------------

The following changes since commit b953c0d234bc72e8489d3bf51a276c5c4ec85345:

  Linux 4.1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-cleanup

for you to fetch changes up to e75ea4569d6d1d10935d74ff80bad52dc09bd062:

  Merge branch 'for-arm-soc' of http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm into next/cleanup

----------------------------------------------------------------

Alexander Kuleshov (1):
      ARM: OMAP2+: use symbolic defines for console loglevels instead of numbers

Alexandre Belloni (8):
      ata: at91: use syscon to configure the smc
      ARM: at91: drop sam9_smc.c
      ARM: at91: declare the at91rm9200 memory controller as a syscon
      pcmcia: at91_cf: Use syscon to configure the MC/smc
      ARM: at91/pm: use the atmel-mc syscon defines
      ARM: at91: remove mach/at91_ramc.h and mach/at91rm9200_mc.h
      ARM: at91: remove at91rm9200_sdramc.h
      ARM: at91: remove useless Makefile.boot

Arnd Bergmann (6):
      Merge tag 'tegra-for-4.2-cleanup' of git://git.kernel.org/.../tegra/linux into next/cleanup
      Merge tag 'ux500-cleanup-v4.2' of git://git.kernel.org/.../linusw/linux-stericsson into next/cleanup
      Merge tag 'omap-for-v4.2/clean' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'at91-cleanup' of git://git.kernel.org/.../abelloni/linux into next/cleanup
      Merge branch 'for-arm-soc' of git://ftp.arm.linux.org.uk/~rmk/linux-arm into next/cleanup
      Merge tag 'imx-cleanup-4.2' of git://git.kernel.org/.../shawnguo/linux into next/cleanup

Boris Brezillon (1):
      mfd: syscon: Add Atmel MC (Memory Controller) registers definition

Fabio Estevam (2):
      ARM: imx: Remove eukrea_mbimxsd35 non-dt support
      ARM: imx: gpc: Remove .owner field

Kevin Hilman (1):
      Merge branch 'for-arm-soc' of http://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/linux-2.6-arm into next/cleanup

Krzysztof Kozlowski (1):
      ARM: OMAP2+: Constify irq_domain_ops

Linus Walleij (11):
      ARM: ux500: get rid of static maps
      ARM: ux500: delete UART static map
      ARM: ux500: remove static maps from platsmp
      ARM: ux500: remap BB offset dynamically
      ARM: ux500: get SCU base from device tree
      ARM: ux500: get rid of static GIC dist base
      ARM: ux500: get rid of SCU and backupram static maps
      ARM: ux500: kill off L2CC static map
      ARM: ux500: look up PRCMU resource from DT
      ARM: ux500: rename ux500_map_io
      ARM: ux500: delete static resource defines

Mark Rutland (1):
      arm64: dts: kill skeleton.dtsi

Nicholas Krause (2):
      ARM: OMAP2+: Remove calls to deprecacted marco,PTR_RET in the files,fb.c and pmu.c
      mach-omap2: Remove use of deprecated marco, PTR_RET in devices.c

Russell King (3):
      ARM: Show proper respect for Heinrich Hertz by using the correct unit for frequency
      ARM: v7 setup function should invalidate L1 cache
      ARM: fix EFM32 build breakage caused by cpu_resume_arm

Stephen Boyd (1):
      ARM: 8389/1: Add cpu_resume_arm() for firmwares that resume in ARM state

Thierry Reding (2):
      ARM: tegra: Use lower-case hexadecimal digits
      ARM: tegra: Fix typo (reset -> rest) in comment

Tony Lindgren (4):
      ARM: OMAP2+: Remove legacy booting support for cm-t35
      ARM: OMAP2+: Remove legacy booting support for Overo
      ARM: OMAP2+: Remove legacy booting support for Beagleboards
      Merge branch 'omap-for-v4.2/legacy' into omap-for-v4.2/cleanup


 .../devicetree/bindings/arm/atmel-at91.txt      |   2 +-
 .../bindings/fuse/nvidia,tegra20-fuse.txt       |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi               |   2 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts      |   2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts            |   2 +-
 arch/arm/boot/dts/tegra124.dtsi                 |   2 +-
 arch/arm/boot/dts/tegra20.dtsi                  |   2 +-
 arch/arm/include/asm/suspend.h                  |   1 +
 arch/arm/kernel/sleep.S                         |  14 +
 arch/arm/mach-at91/Makefile                     |   5 -
 arch/arm/mach-at91/Makefile.boot                |   8 -
 arch/arm/mach-at91/include/mach/at91_ramc.h     |  28 -
 arch/arm/mach-at91/include/mach/at91rm9200_mc.h | 116 ---
 arch/arm/mach-at91/include/mach/at91sam9_smc.h  |  98 ---
 arch/arm/mach-at91/pm.c                         |   8 +-
 arch/arm/mach-at91/pm.h                         |  14 +-
 arch/arm/mach-at91/pm_suspend.S                 |   3 +-
 arch/arm/mach-at91/sam9_smc.c                   | 136 ----
 arch/arm/mach-at91/sam9_smc.h                   |  11 -
 arch/arm/mach-bcm/Makefile                      |   2 +-
 arch/arm/mach-bcm/brcmstb.h                     |  19 -
 arch/arm/mach-bcm/headsmp-brcmstb.S             |  33 -
 arch/arm/mach-bcm/platsmp-brcmstb.c             |   4 +-
 arch/arm/mach-berlin/headsmp.S                  |   6 -
 arch/arm/mach-berlin/platsmp.c                  |   3 +-
 arch/arm/mach-davinci/include/mach/da8xx.h      |   2 +-
 arch/arm/mach-hisi/Makefile                     |   2 +-
 arch/arm/mach-hisi/core.h                       |   1 -
 arch/arm/mach-hisi/headsmp.S                    |  16 -
 arch/arm/mach-hisi/platsmp.c                    |   4 +-
 arch/arm/mach-imx/Kconfig                       |  34 -
 arch/arm/mach-imx/Makefile                      |   2 -
 arch/arm/mach-imx/clk-imx6sx.c                  |   4 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c  | 318 --------
 arch/arm/mach-imx/gpc.c                         |   1 -
 arch/arm/mach-imx/headsmp.S                     |   1 -
 arch/arm/mach-imx/mach-cpuimx35.c               | 206 -----
 arch/arm/mach-iop13xx/include/mach/time.h       |   2 +-
 arch/arm/mach-ixp4xx/include/mach/platform.h    |   2 +-
 arch/arm/mach-ks8695/include/mach/hardware.h    |   2 +-
 arch/arm/mach-mvebu/headsmp-a9.S                |   1 -
 arch/arm/mach-omap2/Kconfig                     |  22 -
 arch/arm/mach-omap2/Makefile                    |   3 -
 arch/arm/mach-omap2/board-cm-t35.c              | 769 -------------------
 arch/arm/mach-omap2/board-omap3beagle.c         | 595 --------------
 arch/arm/mach-omap2/board-overo.c               | 571 --------------
 arch/arm/mach-omap2/devices.c                   |   4 +-
 arch/arm/mach-omap2/fb.c                        |   2 +-
 arch/arm/mach-omap2/gpmc-onenand.c              |   4 +-
 arch/arm/mach-omap2/hsmmc.c                     |   2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c            |   2 +-
 arch/arm/mach-omap2/opp2430_data.c              |   4 +-
 arch/arm/mach-omap2/pmu.c                       |   2 +-
 arch/arm/mach-omap2/sdrc2xxx.c                  |   2 +-
 arch/arm/mach-omap2/serial.c                    |   2 +-
 arch/arm/mach-omap2/sram242x.S                  |   2 +-
 arch/arm/mach-omap2/sram243x.S                  |   2 +-
 arch/arm/mach-prima2/headsmp.S                  |   1 -
 arch/arm/mach-pxa/mp900.c                       |   2 +-
 arch/arm/mach-rockchip/core.h                   |   1 -
 arch/arm/mach-rockchip/headsmp.S                |   8 -
 arch/arm/mach-rockchip/platsmp.c                |   5 +-
 arch/arm/mach-shmobile/common.h                 |   1 -
 arch/arm/mach-shmobile/headsmp-scu.S            |   4 +-
 arch/arm/mach-shmobile/headsmp.S                |   7 -
 arch/arm/mach-shmobile/platsmp-apmu.c           |   2 +-
 arch/arm/mach-socfpga/core.h                    |   1 -
 arch/arm/mach-socfpga/headsmp.S                 |   5 -
 arch/arm/mach-socfpga/platsmp.c                 |   2 +-
 arch/arm/mach-tegra/Makefile                    |   2 +-
 arch/arm/mach-tegra/headsmp.S                   |  12 -
 arch/arm/mach-tegra/reset.c                     |   2 +-
 arch/arm/mach-tegra/reset.h                     |   1 -
 arch/arm/mach-tegra/sleep-tegra30.S             |   2 +-
 arch/arm/mach-ux500/cache-l2x0.c                |  11 +-
 arch/arm/mach-ux500/cpu-db8500.c                |  60 +-
 arch/arm/mach-ux500/cpu.c                       |  20 +-
 arch/arm/mach-ux500/id.c                        |   2 +-
 arch/arm/mach-ux500/platsmp.c                   |  35 +-
 arch/arm/mach-ux500/pm.c                        |  15 +-
 arch/arm/mach-ux500/setup.h                     |  16 +-
 arch/arm/mach-zynq/common.h                     |   2 -
 arch/arm/mach-zynq/headsmp.S                    |   5 -
 arch/arm/mach-zynq/platsmp.c                    |   5 +-
 arch/arm/mm/proc-v7.S                           |   2 +-
 arch/arm64/boot/dts/skeleton.dtsi               |  13 -
 drivers/ata/Kconfig                             |   1 -
 drivers/ata/pata_at91.c                         |  92 ++-
 drivers/pcmcia/Kconfig                          |   1 -
 drivers/pcmcia/at91_cf.c                        |  25 +-
 include/linux/mfd/syscon/atmel-mc.h             | 144 ++++
 include/soc/at91/at91rm9200_sdramc.h            |  63 --
 92 files changed, 367 insertions(+), 3312 deletions(-)
 delete mode 100644 arch/arm/mach-at91/Makefile.boot
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_ramc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91rm9200_mc.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9_smc.h
 delete mode 100644 arch/arm/mach-at91/sam9_smc.c
 delete mode 100644 arch/arm/mach-at91/sam9_smc.h
 delete mode 100644 arch/arm/mach-bcm/brcmstb.h
 delete mode 100644 arch/arm/mach-bcm/headsmp-brcmstb.S
 delete mode 100644 arch/arm/mach-hisi/headsmp.S
 delete mode 100644 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c
 delete mode 100644 arch/arm/mach-imx/mach-cpuimx35.c
 delete mode 100644 arch/arm/mach-omap2/board-cm-t35.c
 delete mode 100644 arch/arm/mach-omap2/board-omap3beagle.c
 delete mode 100644 arch/arm/mach-omap2/board-overo.c
 delete mode 100644 arch/arm/mach-tegra/headsmp.S
 delete mode 100644 arch/arm64/boot/dts/skeleton.dtsi
 create mode 100644 include/linux/mfd/syscon/atmel-mc.h
 delete mode 100644 include/soc/at91/at91rm9200_sdramc.h
