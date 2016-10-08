From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 08 Oct 2016 02:30:27 +0200
Subject: [GIT PULL 2/8] ARM: SoC platform updates for v4.9
In-Reply-To: <3637015.LRn5VyhPVM@wuerfel>
References: <3637015.LRn5VyhPVM@wuerfel>
Message-ID: <2989237.kUCxXKV2uh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:

  Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-soc

for you to fetch changes up to e40454d3f444ba7f8cc78dd985a1414a5945757c:

  Merge tag 'mvebu-soc-4.9-1' of git://git.infradead.org/linux-mvebu into next/soc (2016-09-21 22:35:56 +0200)

----------------------------------------------------------------
ARM: SoC platform updates for v4.9

These are updates for platform specific code on 32-bit ARM machines,
essentially anything that can not (yet) be expressed using DT files.

Noteworthy changes include:

- We get support for running in big-endian mode on two platforms:
  sunxi (Allwinner) and s3c24xx (old Samsung).

- The recently added Uniphier platform now uses standard PSCI
  methods for SMP booting and we remove support for old bootloader
  versions that did not support it yet.

- In sunxi, we gain support for the "Nextthing GR8" SoC, which
  is a close relative of the Allwinner A13 and R8 chips.

- PXA completes its move over to the generic dmaengine framework
  and removes its old private API

- mach-bcm gains support for BCM47189/BCM53573, their first ARM
  SoC with integrated 802.11ac wireless networking.

----------------------------------------------------------------
Andy Gross (1):
      ARM: qcom: Cleanup/Remove unnecessary board file

Anson Huang (3):
      ARM: imx: rename imx6q_set_int_mem_clk_lpm() function
      ARM: imx: enable WAIT mode hardware workaround for imx6sx
      ARM: imx: add cpuidle support for i.mx6ul

Arnd Bergmann (16):
      Merge tag 'davinci-for-v4.9/soc' of git://git.kernel.org/.../nsekhar/linux-davinci into next/soc
      Merge tag 'samsung-soc-4.9' of git://git.kernel.org/.../krzk/linux into next/soc
      ARM: imx: build cpuidle-imx6sx.o for imx6ul
      ARM: mv78xx0: simplify ethernet device creation
      ARM: mvebu/orion: remove NO_IRQ check from device init
      ARM: orion: simplify orion_ge00_switch_init
      ARM: orion5x: remove extraneous NO_IRQ
      Merge tag 'qcom-soc-for-4.9' of git://git.kernel.org/.../agross/linux into next/soc
      Merge tag 'arm-soc/for-4.9/soc' of http://github.com/Broadcom/stblinux into next/soc
      Merge tag 'renesas-soc-for-v4.9' of git://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'pxa-for-4.9' of https://github.com/rjarzmik/linux into next/soc
      Merge tag 'sunxi-core-for-4.9' of https://git.kernel.org/.../mripard/linux into next/soc
      Merge tag 'imx-soc-4.9' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'uniphier-soc-v4.9' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/soc
      Merge tag 'imx-legacy-4.9' of git://git.kernel.org/.../shawnguo/linux into next/soc
      Merge tag 'mvebu-soc-4.9-1' of git://git.infradead.org/linux-mvebu into next/soc

Bartlomiej Zolnierkiewicz (4):
      arm: colibri_pxa270_defconfig: disable IDE subsystem
      arm: lpda270_defconfig: disable IDE subsystem
      arm: pxa255-idp_defconfig: disable IDE subsystem
      arm: trizeps4_defconfig: disable IDE subsystem

Ben Dooks (1):
      ARM: EXYNOS: Enable ARCH_SUPPORTS_BIG_ENDIAN explicitly

Florian Fainelli (1):
      ARM: brcmstb: Add earlyprintk support using run-time checks

Geert Uytterhoeven (1):
      ARM: debug-ll: Add support for r8a7992

Karl Beldan (1):
      ARM: davinci: da850: Add ti-aemif lookup for clock matching

Markus Elfring (2):
      ARM: s3c64xx: Delete unnecessary assignment for the field "owner"
      ARM: pxa: Use kmalloc_array() in pxa_pm_init()

Masahiro Yamada (1):
      ARM: uniphier: remove SoC-specific SMP code

Maxime Ripard (1):
      ARM: sunxi: Support the Nextthing GR8

Michael Weiser (1):
      ARM: sunxi: enable big-endian

Neil Armstrong (1):
      MAINTAINERS: update list of Oxnas maintainers

Pankaj Dubey (1):
      ARM: EXYNOS: Remove unused DMC and CMU offsets and their mappings

Petr Cvek (1):
      ARM: pxa: magician: Remove duplicated I2C pins declaration

Rafa? Mi?ecki (1):
      ARM: BCM53573: Initial support for Broadcom BCM53573 SoCs

Robert Jarzmik (7):
      ARM: pxa: remove devicetree boards from pxa_defconfig
      ARM: pxa: remove platform dma code
      ARM: pxa: prepare pxa25x interrupts for device-tree platforms
      ARM: pxa: add pxa25x device-tree support
      ARM: pxa: fix GPIO double shifts
      ARM: pxa: remove irq init from dt machines
      ARM: pxa: pxa_cplds: fix interrupt handling

Sylwester Nawrocki (2):
      ARM: S3C24XX: Add dma_mask assignments for DMA devices
      ARM: S3C24XX: Add missing DMA device for Mini2440 board

Vladimir Zapolskiy (17):
      ARM: imx legacy: kzm: move peripheral initialization to .init_late
      ARM: imx legacy: mx31lite: move peripheral initialization to .init_late
      ARM: imx legacy: mx31ads: move peripheral initialization to .init_late
      ARM: imx legacy: mx31lilly: move peripheral initialization to .init_late
      ARM: imx legacy: pcm037: move peripheral initialization to .init_late
      ARM: imx legacy: mx31-3ds: move peripheral initialization to .init_late
      ARM: imx legacy: qong: move peripheral initialization to .init_late
      ARM: imx legacy: armadillo5x0: move peripheral initialization to .init_late
      ARM: imx legacy: mx31moboard: move peripheral initialization to .init_late
      ARM: imx legacy: vpr200: move peripheral initialization to .init_late
      ARM: imx legacy: imx27-visstrim-m10: move peripheral initialization to .init_late
      ARM: imx legacy: mx27-3ds: move peripheral initialization to .init_late
      ARM: imx legacy: mx35-3ds: move peripheral initialization to .init_late
      ARM: imx legacy: pcm043: move peripheral initialization to .init_late
      ARM: imx legacy: mx21ads: move peripheral initialization to .init_late
      ARM: imx legacy: mx27ads: move peripheral initialization to .init_late
      ARM: imx legacy: pca100: move peripheral initialization to .init_late

Wolfram Sang (2):
      ARM: shmobile: r8a7790: only use smp_init when SMP is selected
      ARM: shmobile: r8a7791: only use smp_init when SMP is selected

 Documentation/arm/sunxi/README                  |   2 +
 Documentation/devicetree/bindings/arm/sunxi.txt |   1 +
 MAINTAINERS                                     |   9 +
 arch/arm/Kconfig.debug                          |  22 +-
 arch/arm/configs/colibri_pxa270_defconfig       |   1 -
 arch/arm/configs/lpd270_defconfig               |   1 -
 arch/arm/configs/pxa255-idp_defconfig           |   1 -
 arch/arm/configs/pxa_defconfig                  |   2 -
 arch/arm/configs/trizeps4_defconfig             |   2 -
 arch/arm/include/asm/hardware/cache-uniphier.h  |  20 +-
 arch/arm/include/debug/brcmstb.S                | 145 +++++++++
 arch/arm/mach-bcm/Kconfig                       |  14 +
 arch/arm/mach-bcm/brcmstb.c                     |  16 +
 arch/arm/mach-davinci/da850.c                   |   1 +
 arch/arm/mach-davinci/da8xx-dt.c                |   1 +
 arch/arm/mach-exynos/Kconfig                    |   1 +
 arch/arm/mach-exynos/exynos.c                   |  15 -
 arch/arm/mach-exynos/include/mach/map.h         |   5 -
 arch/arm/mach-imx/Makefile                      |   1 +
 arch/arm/mach-imx/common.h                      |   2 +-
 arch/arm/mach-imx/cpuidle-imx6q.c               |   2 +-
 arch/arm/mach-imx/cpuidle-imx6sx.c              |  11 +
 arch/arm/mach-imx/mach-armadillo5x0.c           |  39 ++-
 arch/arm/mach-imx/mach-imx27_visstrim_m10.c     |  24 +-
 arch/arm/mach-imx/mach-imx6ul.c                 |   3 +
 arch/arm/mach-imx/mach-kzm_arm11_01.c           |   9 +-
 arch/arm/mach-imx/mach-mx21ads.c                |  13 +-
 arch/arm/mach-imx/mach-mx27_3ds.c               |  30 +-
 arch/arm/mach-imx/mach-mx27ads.c                |  13 +-
 arch/arm/mach-imx/mach-mx31_3ds.c               |  39 ++-
 arch/arm/mach-imx/mach-mx31ads.c                |  18 +-
 arch/arm/mach-imx/mach-mx31lilly.c              |  50 ++-
 arch/arm/mach-imx/mach-mx31lite.c               |  68 +++--
 arch/arm/mach-imx/mach-mx31moboard.c            |  23 +-
 arch/arm/mach-imx/mach-mx35_3ds.c               |  15 +-
 arch/arm/mach-imx/mach-pca100.c                 |  26 +-
 arch/arm/mach-imx/mach-pcm037.c                 |  67 ++--
 arch/arm/mach-imx/mach-pcm043.c                 |  10 +-
 arch/arm/mach-imx/mach-qong.c                   |   2 +-
 arch/arm/mach-imx/mach-vpr200.c                 |  29 +-
 arch/arm/mach-imx/mx31lilly-db.c                |  20 --
 arch/arm/mach-imx/mx31lite-db.c                 |  33 --
 arch/arm/mach-imx/pm-imx6.c                     |   8 +-
 arch/arm/mach-mv78xx0/common.c                  |   9 +-
 arch/arm/mach-orion5x/common.c                  |   4 +-
 arch/arm/mach-orion5x/common.h                  |   2 +-
 arch/arm/mach-orion5x/rd88f5181l-fxo-setup.c    |   4 +-
 arch/arm/mach-orion5x/rd88f5181l-ge-setup.c     |   5 +-
 arch/arm/mach-orion5x/rd88f6183ap-ge-setup.c    |   6 +-
 arch/arm/mach-orion5x/wnr854t-setup.c           |   4 +-
 arch/arm/mach-orion5x/wrt350n-v2-setup.c        |   4 +-
 arch/arm/mach-pxa/Kconfig                       |  11 +
 arch/arm/mach-pxa/Makefile                      |   3 +-
 arch/arm/mach-pxa/corgi_pm.c                    |  13 +-
 arch/arm/mach-pxa/devices.h                     |   1 +
 arch/arm/mach-pxa/generic.h                     |   2 -
 arch/arm/mach-pxa/include/mach/dma.h            |   1 -
 arch/arm/mach-pxa/magician.c                    |   4 -
 arch/arm/mach-pxa/pm.c                          |   5 +-
 arch/arm/mach-pxa/pxa-dt.c                      |  35 ++-
 arch/arm/mach-pxa/pxa25x.c                      |  26 +-
 arch/arm/mach-pxa/pxa27x.c                      |  14 +-
 arch/arm/mach-pxa/pxa3xx.c                      |  11 +-
 arch/arm/mach-pxa/pxa_cplds_irqs.c              |  24 +-
 arch/arm/mach-pxa/sharpsl_pm.c                  |   2 +-
 arch/arm/mach-pxa/sharpsl_pm.h                  |   2 +-
 arch/arm/mach-pxa/spitz_pm.c                    |   9 +-
 arch/arm/mach-qcom/Makefile                     |   1 -
 arch/arm/mach-qcom/board.c                      |  31 --
 arch/arm/mach-s3c24xx/common.c                  |  20 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           |   1 +
 arch/arm/mach-s3c64xx/mach-crag6410-module.c    |   3 +-
 arch/arm/mach-shmobile/setup-r8a7790.c          |   2 +-
 arch/arm/mach-shmobile/setup-r8a7791.c          |   2 +-
 arch/arm/mach-sunxi/Kconfig                     |   1 +
 arch/arm/mach-sunxi/sunxi.c                     |   1 +
 arch/arm/mach-uniphier/Makefile                 |   2 +-
 arch/arm/mach-uniphier/headsmp.S                |  43 ---
 arch/arm/mach-uniphier/platsmp.c                | 209 -------------
 arch/arm/mm/cache-uniphier.c                    |  63 +---
 arch/arm/plat-orion/common.c                    |  85 ++----
 arch/arm/plat-orion/include/plat/common.h       |  10 +-
 arch/arm/plat-pxa/Makefile                      |   2 -
 arch/arm/plat-pxa/dma.c                         | 386 ------------------------
 arch/arm/plat-pxa/include/plat/dma.h            | 100 ------
 arch/arm/plat-samsung/include/plat/map-s5p.h    |   4 -
 86 files changed, 696 insertions(+), 1285 deletions(-)
 create mode 100644 arch/arm/include/debug/brcmstb.S
 delete mode 100644 arch/arm/mach-qcom/board.c
 delete mode 100644 arch/arm/mach-uniphier/headsmp.S
 delete mode 100644 arch/arm/mach-uniphier/platsmp.c
 delete mode 100644 arch/arm/plat-pxa/dma.c
 delete mode 100644 arch/arm/plat-pxa/include/plat/dma.h
