From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 21:24 +0100
Subject: [GIT PULL 1/8] ARM: SoC non-urgent fixes for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <3545535.dbKYgCDdAj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes-nc

for you to fetch changes up to 88e9da9a2a70b6f1a171fbf30a681d6bc4031c4d:

  CNS3xxx: Fix PCI cns3xxx_write_config() (2016-03-12 17:02:06 -0800)

----------------------------------------------------------------
ARM: SoC non-urgent fixes for v4.6

As usual, we queue up a few fixes that don't seem urgent enough to go in
through -rc.

 - a number of randconfig warning fixes from Arnd
 - various small fixes for OMAP
 - one somewhat larger patch to restore the OMAP3 cpuidle
   tuning that was lost in a cleanup
 - a small regression fix for cns3xxx PCI

----------------------------------------------------------------
Arnd Bergmann (19):
      ARM: s3c24xx: don't select EEPROM_AT24
      ARM: s3c24xx: allow selecting S3C2440_XTAL_16934400 for s3c2442
      ARM: s3c24xx: fix unused gta02_configure_pmu_for_charger warning
      ARM: s3c64xx: mark regulator init data as unused
      ARM: EXYNOS: select THERMAL_OF
      ARM: davinci: limit DT support to DA850
      ARM: davinci: avoid unused mityomapl138_pn_info variable
      ARM: davinci: DA8xx+DMx combined kernels need PATCH_PHYS_VIRT
      ARM: davinci: make I2C support optional
      ARM: orion: only select I2C_BOARDINFO when using I2C
      ARM: mv78xx0: avoid unused function warning
      ARM: mvebu: mark mvebu_hwcc_pci_nb as __maybe_unused
      ARM: ks8695: fix __initdata annotation
      ARM: socfpga: hide unused functions
      ARM: prima2: always enable reset controller
      Merge tag 'davinci-for-v4.6/fixes' of git://git.kernel.org/.../nsekhar/linux-davinci into next/fixes-non-critical
      soc: TI knav_qmss: fix dma_addr_t printing
      Merge tag 'mvebu-soc-4.6-1' of git://git.infradead.org/linux-mvebu into next/fixes-non-critical
      Merge tag 'omap-for-v4.6/fixes-not-urgent-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/fixes-non-critical

Kevin Hilman (1):
      MAINTAINERS: unify email addrs for Kevin Hilman

Kishon Vijay Abraham I (2):
      ARM: DRA7: hwmod: Fix OCP2SCP sysconfig
      ARM: DRA7: hwmod: Add reset data for PCIe

Krzysztof Halasa (1):
      CNS3xxx: Fix PCI cns3xxx_write_config()

Krzysztof Ha?asa (1):
      CNS3xxx: remove unused *_VIRT definitions

Linus Walleij (1):
      ARM: ux500: fix ureachable iounmap()

Olof Johansson (1):
      Merge tag 'samsung-fixes-non-critical-4.6' of git://git.kernel.org/.../krzk/linux into next/fixes-non-critical

Pali Roh?r (1):
      ARM: OMAP3: Add cpuidle parameters table for omap3430

Sebastian Reichel (1):
      ARM: OMAP2+: hwmod data: Add SSI data for omap36xx

Tony Lindgren (3):
      Merge tag 'for-v4.6/omap-hwmod-a' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v4.6/fixes-not-urgent
      ARM: OMAP2+: Fix out of range register access with syscon_config.max_register
      ARM: OMAP2+: Fix hwmod clock for l4_ls

 MAINTAINERS                                |  6 +--
 arch/arm/Kconfig                           |  1 +
 arch/arm/configs/mini2440_defconfig        |  1 +
 arch/arm/configs/s3c2410_defconfig         |  1 +
 arch/arm/mach-cns3xxx/cns3xxx.h            |  6 ---
 arch/arm/mach-cns3xxx/pcie.c               |  6 +--
 arch/arm/mach-davinci/Kconfig              | 22 ++--------
 arch/arm/mach-davinci/board-dm644x-evm.c   |  8 +++-
 arch/arm/mach-davinci/board-dm646x-evm.c   |  7 +++
 arch/arm/mach-davinci/board-mityomapl138.c |  2 +-
 arch/arm/mach-dove/Kconfig                 |  2 +-
 arch/arm/mach-exynos/Kconfig               |  1 +
 arch/arm/mach-ks8695/board-og.c            |  2 +-
 arch/arm/mach-ks8695/cpu.c                 |  2 +-
 arch/arm/mach-mv78xx0/common.c             |  5 +--
 arch/arm/mach-mvebu/coherency.c            |  2 +-
 arch/arm/mach-omap2/control.c              | 21 +--------
 arch/arm/mach-omap2/cpuidle34xx.c          | 69 +++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c | 13 +++---
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 18 +++++++-
 arch/arm/mach-omap2/omap_hwmod_81xx_data.c |  9 +++-
 arch/arm/mach-omap2/prm7xx.h               |  1 +
 arch/arm/mach-orion5x/Kconfig              | 18 ++++----
 arch/arm/mach-prima2/Kconfig               |  1 +
 arch/arm/mach-s3c24xx/Kconfig              |  6 ++-
 arch/arm/mach-s3c24xx/mach-gta02.c         |  2 +
 arch/arm/mach-s3c64xx/mach-smdk6410.c      | 38 ++++++++--------
 arch/arm/mach-socfpga/platsmp.c            |  2 +
 arch/arm/mach-ux500/cpu-db8500.c           |  4 +-
 drivers/soc/ti/knav_qmss.h                 |  4 +-
 drivers/soc/ti/knav_qmss_acc.c             | 14 +++---
 drivers/soc/ti/knav_qmss_queue.c           | 22 +++++-----
 32 files changed, 195 insertions(+), 121 deletions(-)
