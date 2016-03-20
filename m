From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 20 Mar 2016 22:03 +0100
Subject: [GIT PULL 7/8] ARM: SoC defconfig updates for v4.6
In-Reply-To: <10465240.PKeEEAAbCF@wuerfel>
References: <10465240.PKeEEAAbCF@wuerfel>
Message-ID: <3227428.ZJy4YhVovV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 388f7b1d6e8ca06762e2454d28d6c3c55ad0fe95:

  Linux 4.5-rc3 (2016-02-07 15:38:30 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-defconfig

for you to fetch changes up to fa54ae137a7357310fa47a19fe3ec476b266efea:

  Merge tag 'stm32-defconfig-for-v4.6-1' of git://git.kernel.org/pub/scm/linux/kernel/git/mcoquelin/stm32 into next/defconfig (2016-03-02 23:20:32 +0100)

----------------------------------------------------------------
ARM: SoC defconfig updates for v4.6

As usual, a bunch of commits, mostly adding drivers and other options to
defconfigs.

The realview_smp_defconfig and realview_defconfig got merged into one,
so we are now down to 110 files.

For stm32, we have now added a Kconfig fragment, the first such
file on arch/arm. The purpose here is to have a shared defconfig
file that works for all boards, while the DRAM offset has to be
hardwired on NOMMU machines at compile time.

The Exynos defconfig changes depend on changes in the RTC tree,
so this is pulled in here, but has already been merged into 4.6 now.

----------------------------------------------------------------
Arnd Bergmann (6):
      Merge tag 'arm-soc/for-4.6/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'mvebu-defconfig-4.6-2' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'sunxi-defconfig-for-4.6' of https://git.kernel.org/.../mripard/linux into next/defconfig
      Merge tag 'imx-defconfig-4.6' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'omap-for-v4.6/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'stm32-defconfig-for-v4.6-1' of git://git.kernel.org/.../mcoquelin/stm32 into next/defconfig

Chen-Yu Tsai (6):
      ARM: sunxi_defconfig: Enable sunxi IR driver
      ARM: sunxi_defconfig: Enable A10 audio codec driver
      ARM: sunxi_defconfig: Enable INPUT_EVDEV so axp20x-pek can be used
      ARM: multi_v7_defconfig: Enable MUSB HDRC driver with Allwinner glue
      ARM: multi_v7_defconfig: Enable A10 audio codec driver as module
      ARM: sunxi_defconfig: Enable MUSB HDRC driver with Allwinner glue

Daniel Stone (1):
      ARM: multi_v7_defconfig: Enable BCM283x

Denis Carikli (1):
      ARM: imx_v4_v5_defconfig: Add I.MX25 Touchscreen controller and ADC support.

Dinh Nguyen (1):
      ARM: socfpga_defconfig: enable support for initramfs/initrd support

Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Select CONFIG_NVMEM_IMX_OCOTP
      ARM: mxs_defconfig: Select CONFIG_NVMEM_MXS_OCOTP
      ARM: imx_v6_v7_defconfig: Select CONFIG_CRYPTO_DEV_SAHARA

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2016-02-17' into defconfig/next

Frank Li (1):
      ARM: imx_v6_v7_defconfig: enable psci default

Geert Uytterhoeven (1):
      ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE

Gregory CLEMENT (1):
      ARM: mvebu: Add USB nop xceiv support in mvebu_v7_defconfig

Jan Luebbe (6):
      ARM: multi_v5_defconfig: Cleanup multi_v5_defconfig
      ARM: multi_v5_defconfig: Enable initramfs support
      ARM: mxs_defconfig: Cleanup mxs_defconfig
      ARM: mxs_defconfig: Enable initramfs support
      ARM: imx_v4_v5_defconfig: Cleanup imx_v4_v5_defconfig
      ARM: imx_v4_v5_defconfig: Enable initramfs support

Javier Martinez Canillas (5):
      ARM: exynos_defconfig: Remove MAX77802 RTC Kconfig symbol
      ARM: multi_v7_defconfig: Remove MAX77802 RTC Kconfig symbol
      ARM: omap2plus_defconfig: Enable OMAP IOMMU support
      ARM: omap2plus_defconfig: Enable ISP support and dependencies
      ARM: omap2plus_defconfig: Enable TI TVP5150 video decoder support

Krzysztof Kozlowski (3):
      ARM: exynos_defconfig: Enable NEON, accelerated crypto and cpufreq stats
      ARM: exynos_defconfig: Enable s5p-secss driver
      Merge tag 'rtc-max77686-4.6' of git://git.kernel.org/.../abelloni/linux into next/defconfig

Lars Persson (1):
      ARM: multi_v7_defconfig: add MACH_ARTPEC6

Lee Jones (1):
      ARM: configs: Add new config fragment to change RAM start point

Linus Walleij (3):
      ARM: realview: activate SMP on the default defconfig
      ARM: realview: delete realview-smp_defconfig
      ARM: realview: enable USB storage in the defconfig

Ludovic Desroches (1):
      ARM: at91/defconfig: add sama5d2 adc support in sama5_defconfig

Marcin Wojtas (1):
      ARM: mvebu: enable SRAM support in mvebu_v7_defconfig

Martin Michlmayr (1):
      ARM: mvebu_v5_defconfig: Enable sound module needed for OpenRD

Maxime Coquelin (1):
      ARM: config: Enable GPIO Led driver in stm32_defconfig

Nishanth Menon (1):
      ARM: omap2plus_defconfig: Enable AT24 eeprom

Olof Johansson (6):
      Merge tag 'renesas-defconfig-for-v4.6' of git://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'mvebu-defconfig-4.6-1' of git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'realview-defconfig-redux' of git://git.kernel.org/.../linusw/linux-integrator into next/defconfig
      Merge tag 'samsung-defconfig-4.6' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'at91-ab-4.6-defconfig' of git://git.kernel.org/.../abelloni/linux into next/defconfig
      Merge tag 'socfpga_defconfig_for_v4.6' of git://git.kernel.org/.../dinguyen/linux into next/defconfig

Paul Kocialkowski (2):
      ARM: omap2plus_defconfig: Enable LP872x regulator support
      ARM: multi_v7_defconfig: Enable LP872x regulator support

Simon Horman (2):
      ARM: shmobile: enable XHCI_RCAR in defconfig
      ARM: multi_v7_defconfig: Enable XHCI_RCAR

Stefan Agner (2):
      ARM: imx_v6_v7_defconfig: enable useful configurations for Vybrid
      ARM: multi_v7_defconfig: enable useful configurations for Vybrid

Stefan Wahren (2):
      ARM: bcm2835_defconfig: Enable RPi firmware driver
      ARM: bcm2835_defconfig: Enable RPi power domain driver

Stephen Warren (3):
      ARM: bcm2835_defconfig: rebuild on next-20160205
      ARM: bcm2835_defconfig: disable DEBUG_LL
      ARM: bcm2835_defconfig: enable ARMv7 support

 arch/arm/configs/bcm2835_defconfig      |  11 ++--
 arch/arm/configs/dram_0x00000000.config |   1 +
 arch/arm/configs/exynos_defconfig       |  10 ++-
 arch/arm/configs/imx_v4_v5_defconfig    |  14 ++---
 arch/arm/configs/imx_v6_v7_defconfig    |  23 ++++---
 arch/arm/configs/multi_v5_defconfig     |   3 +-
 arch/arm/configs/multi_v7_defconfig     |  28 ++++++++-
 arch/arm/configs/mvebu_v5_defconfig     |   1 +
 arch/arm/configs/mvebu_v7_defconfig     |   2 +
 arch/arm/configs/mxs_defconfig          |   7 +--
 arch/arm/configs/omap2plus_defconfig    |  13 +++-
 arch/arm/configs/realview-smp_defconfig | 105 --------------------------------
 arch/arm/configs/realview_defconfig     |   5 ++
 arch/arm/configs/sama5_defconfig        |   1 +
 arch/arm/configs/shmobile_defconfig     |   3 +-
 arch/arm/configs/socfpga_defconfig      |   2 +-
 arch/arm/configs/stm32_defconfig        |   1 +
 arch/arm/configs/sunxi_defconfig        |  13 ++++
 18 files changed, 105 insertions(+), 138 deletions(-)
