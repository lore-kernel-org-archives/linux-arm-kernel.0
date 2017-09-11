From: olof@lixom.net (Olof Johansson)
Date: Sun, 10 Sep 2017 18:18:01 -0700
Subject: [GIT PULL 1/3] ARM/arm64: SoC platform updates for v4.14
In-Reply-To: <1505092683-19362-1-git-send-email-olof@lixom.net>
References: <1505092683-19362-1-git-send-email-olof@lixom.net>
Message-ID: <1505092683-19362-2-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch contains platform updates for 32- and 64-bit ARM,
including defconfig updates to enable new options, drivers and
platforms. There are also a few fixes and cleanups for some existing vendors.

Some of the things worth highlighting here are:

- Enabling new crypt drivers on arm64 defconfig
- QCOM IPQ8074 clocks and pinctrl drivers on arm64 defconfig
- Debug support enabled for Renesas r8a7743
- Various config updates for Renesas platforms (sound, USB, other drivers)
- Platform support (including SMP) for TI dra762
- OMAP cleanups: Move to use generic 8250 debug_ll, removal of stale DMA code

Conflicts:
imx_v6_v7_defconfig: Add/change: Keep everything but CONFIG_MEDIA_RC_SUPPORT.

----------------------------------------------------------------

The following changes since commit d719518d9ce9132bad8a06e8029aeead328f66a3:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-next

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-platforms

for you to fetch changes up to e9e3969fe2d84e56b3ee5cd4f7e00f4516a885cb:

  Merge branch 'next/defconfig' into next/soc

----------------------------------------------------------------

Abhishek Sahu (1):
      arm64: defconfig: Enable QCOM IPQ8074 clock and pinctrl

Alexander Sverdlin (3):
      ARM: ep93xx: Add ADC clock
      ARM: ep93xx: Add ADC platform device support to core
      ARM: edb93xx: Add ADC platform device

Ard Biesheuvel (1):
      arm64: defconfig: add recently added crypto drivers as modules

Arnd Bergmann (34):
      ARM: s3c24xx: make H1940BT depend on RFKILL
      Merge tag 'samsung-defconfig-4.14' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'samsung-defconfig-arm-cleanups-4.14' of git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'renesas-defconfig-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'renesas-arm64-defconfig-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/arm64
      Merge tag 'mvebu-arm64-4.14-1' of git://git.infradead.org/linux-mvebu into next/arm64
      Merge tag 'hisi-defconfig-for-4.14' of git://github.com/hisilicon/linux-hisi into next/arm64
      Merge tag 'sunxi-defconfig-for-4.14' of https://git.kernel.org/.../sunxi/linux into next/defconfig
      Merge tag 'samsung-soc-4.14' of git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'arm-ep93xx-adc' of https://github.com/sverdlin/linux into next/soc
      Merge tag 'hisi-fixes-for-4.14' of git://github.com/hisilicon/linux-hisi into next/cleanup
      Merge tag 'omap-for-v4.14/fixes-not-urgent-dt-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'renesas-soc-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/soc
      Merge tag 'omap-for-v4.14/soc-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'omap-for-v4.14/debug-ll-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/soc
      Merge tag 'mvebu-soc-4.14-1' of git://git.infradead.org/linux-mvebu into next/soc
      Merge tag 'gemini-for-arm-soc-1' of git://git.kernel.org/.../linusw/linux-nomadik into next/soc
      Merge tag 'omap-for-v4.14/defconfig-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/defconfig
      Merge tag 'v4.14-rockchip-soc32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc
      Merge tag 'keystone_config_4.14' of git://git.kernel.org/.../ssantosh/linux-keystone into next/defconfig
      Merge tag 'renesas-defconfig2-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/defconfig
      Merge tag 'arm-soc/for-4.14/defconfig' of http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'imx-defconfig-4.14' of git://git.kernel.org/.../shawnguo/linux into next/defconfig
      Merge tag 'tegra-for-4.14-arm-defconfig' of git://git.kernel.org/.../tegra/linux into next/defconfig
      Merge tag 'tegra-for-4.14-arm-core' of git://git.kernel.org/.../tegra/linux into next/soc
      Merge tag 'arm-soc/for-4.14/defconfig-arm64' of http://github.com/Broadcom/stblinux into next/arm64
      Merge tag 'zte-soc-4.14' of git://git.kernel.org/.../shawnguo/linux into next/arm64
      Merge tag 'qcom-arm64-defconfig-for-4.14' of git://git.kernel.org/.../agross/linux into next/arm64
      Merge tag 'omap-for-v4.14/fixes-not-urgent-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/cleanup
      Merge tag 'sunxi-config64-for-4.14' of https://git.kernel.org/.../sunxi/linux into next/arm64
      Merge tag 'davinci-for-v4.14/defconfig' of git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'samsung-soc-4.14-2' of git://git.kernel.org/.../krzk/linux into next/soc
      Merge tag 'aspeed-4.14-defconfig' of git://git.kernel.org/.../joel/aspeed into next/defconfig
      Merge tag 'v4.14-rockchip-soc32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/soc

Biju Das (2):
      ARM: shmobile: defconfig: Enable Ethernet AVB
      ARM: shmobile: Enable BQ32000 rtc in shmobile_defconfig

Chris Paterson (1):
      ARM: debug-ll: Add support for r8a7743

C?dric Le Goater (1):
      ARM: configs: aspeed: Update Aspeed G4 with VMSPLIT_2G

David Lechner (1):
      ARM: davinci_all_defconfig: enable tinydrm and ST7586

Dmitry Osipenko (1):
      ARM: defconfig: tegra: Enable ChipIdea UDC driver

Fabio Estevam (3):
      ARM: imx_v6_v7_defconfig: Enable SPI_GPIO
      ARM: imx_v6_v7_defconfig: Enable GPIO_74X164
      ARM: imx_v6_v7_defconfig: Select the coda driver as module

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2017-08-07' into defconfig/next

Franklin S Cooper Jr (1):
      ARM: configs: keystone: Enable D_CAN driver

Geert Uytterhoeven (13):
      ARM: shmobile: defconfig: Enable missing PCIE_RCAR dependency
      ARM: shmobile: defconfig: Replace USB_XHCI_RCAR by USB_XHCI_PLATFORM
      ARM: shmobile: defconfig: Replace SND_SOC_RSRC_CARD by SND_SIMPLE_SCU_CARD
      ARM: shmobile: defconfig: Replace DRM_RCAR_HDMI by generic bridge options
      ARM: shmobile: defconfig: Enable DMA for serial ports
      ARM: shmobile: defconfig: Refresh
      ARM: multi_v7_defconfig: Replace SND_SOC_RSRC_CARD by SND_SIMPLE_SCU_CARD
      ARM: multi_v7_defconfig: Replace DRM_RCAR_HDMI by generic bridge options
      ARM: multi_v7_defconfig: Enable DMA for Renesas serial ports
      ARM: shmobile: rcar-gen2: Obtain jump stub region from DT
      ARM: shmobile: rcar-gen2: Add support for CPG/MSSR bindings
      ARM: shmobile: rcar-gen2: Correct arch timer frequency on RZ/G1E
      ARM: shmobile: Remove ARCH_SHMOBILE_MULTI

Guodong Xu (3):
      arm64: defconfig: enable support hi6421v530 PMIC
      arm64: defconfig: enable CONFIG_SYSCON_REBOOT_MODE
      arm64: defconfig: enable support for serial port connected device

Gustavo A. R. Silva (1):
      soc: versatile: remove unnecessary static in realview_soc_probe()

Heiko Stuebner (1):
      arm64: defconfig: enable rockchip graphics

Jagan Teki (2):
      arm64: defconfig: Enable MFD_AXP20X_RSB
      arm64: defconfig: Enable REGULATOR_AXP20X

Joel Stanley (1):
      ARM: config: aspeed: Add I2C, VUART, LPC Snoop

Johan Hovold (1):
      ARM: OMAP2+: omap_device: drop broken RPM status update from suspend_noirq

John Garry (1):
      arm64: defconfig: enable SCSI_HISI_SAS_PCI

Keiji Hayashibara (1):
      arm64: defconfig: enable CONFIG_UNIPHIER_WATCHDOG

Kishon Vijay Abraham I (2):
      bus: omap-ocp2scp: Fix error handling in omap_ocp2scp_probe
      ARM: OMAP2+: Select PINCTRL_TI_IODELAY for SOC_DRA7XX

Krzysztof Kozlowski (11):
      ARM: multi_v7_defconfig: Cleanup from non-existing options
      ARM: ixp4xx_defconfig: Cleanup from non-existing options
      ARM: vexpress_defconfig: Cleanup from non-existing options
      ARM: ezx_defconfig: Cleanup from non-existing options
      ARM: qcom_defconfig: Cleanup from non-existing options
      ARM: exynos_defconfig: Enable Bluetooth, mac80211, NFC and more USB drivers
      ARM: exynos_defconfig: Enable NLS_UTF8 and some crypto algorithms
      ARM: exynos_defconfig: Enable locking test options
      ARM: s3c24xx: Remove non-existing CONFIG_CPU_S3C2413
      ARM: s3c24xx: Remove non-existing SND_SOC_SMDK2443_WM9710
      ARM: s3c24xx: Do not confuse local define with Kconfig

Kuninori Morimoto (1):
      arm64: defconfig: compile ak4613 and renesas sound as modules

Linus Walleij (4):
      ARM: gemini: tag the arch as having reset controller
      ARM: gemini: select the clock controller
      ARM: gemini: select ARM_AMBA
      ARM: gemini: select pin controller

Lokesh Vutla (7):
      ARM: configs: keystone: Enable MMC and regulators
      ARM: OMAP2+: board-generic: add support for dra762 family
      ARM: dra762: Add support for device identification
      ARM: dra7: hwmod: Register dra76x specific hwmod
      ARM: dra762: Enable SMP for dra762
      ARM: OMAP: dra7: powerdomain data: Register SoC specific powerdomains
      ARM: omap2plus_defconfig: Enable LP87565

Marcin Wojtas (2):
      arm64: defconfig: enable fine-grained task level IRQ time accounting
      ARM: mvebu: enable ARM_GLOBAL_TIMER compilation Armada 38x platforms

Markus Mayer (2):
      arm64: defconfig: add CONFIG_BRCMSTB_THERMAL
      ARM: multi_v7_defconfig: add CONFIG_BRCMSTB_THERMAL

Maxime Ripard (3):
      arm: sunxi: refresh the defconfig
      arm: sunxi: Add additional power supplies
      arm: sunxi: Add AXP20X_ADC

Nishanth Menon (2):
      ARM: configs: keystone: Enable Message Manager
      ARM: configs: keystone: Enable TI-SCI protocol and genpd driver

Olof Johansson (3):
      Merge branch 'next/cleanup' into next/soc
      Merge branch 'next/arm64' into next/soc
      Merge branch 'next/defconfig' into next/soc

Paul Kocialkowski (3):
      ARM: tegra: Select appropriate DMA options for LPAE
      ARM: tegra: Add Tegra I2S interfaces to defconfig
      ARM: configs: Add Tegra I2S interfaces to multi_v7_defconfig

Philipp Zabel (1):
      ARM: rockchip: explicitly request exclusive reset control in smp code

Rob Herring (1):
      ARM: Convert to using %pOF instead of full_name

Robert Richter (1):
      MAINTAINERS: Update Cavium ThunderX2 entry

Sekhar Nori (4):
      ARM: OMAP2+: Add pdata-quirks for MMC/SD on DRA74x EVM
      ARM: dts: dra71-evm: workaround incorrect DP83867 RX_CTRL pin strap
      ARM: dts: dra72-evm-revc: workaround incorrect DP83867 RX_CTRL pin strap
      ARM: omap2plus_defconfig: enable DP83867 phy driver

Sergei Shtylyov (2):
      ARM: OMAP3+: PRM: fix of_irq_get() result check
      ARM: OMAP4+: PRM: fix of_irq_get() result checks

Shawn Guo (2):
      arm64: select PINCTRL for ZTE platform
      MAINTAINERS: update ARM/ZTE entry

Stefan Wahren (3):
      ARM: bcm2835_defconfig: Enable Mini UART console support
      ARM: bcm2835_defconfig: Increase CMA for VC4
      ARM: bcm2835_defconfig: Enable wifi driver for RPi Zero W

Steve Longerbeam (1):
      ARM: imx_v6_v7_defconfig: Enable staging video4linux drivers

Suman Anna (1):
      ARM: configs: keystone: Enable reset drivers

Sylwester Nawrocki (1):
      ARM: s3c24xx: Fix NAND ECC mode for mini2440 board

Tao Huang (2):
      ARM: rockchip: enable ZONE_DMA for non 64-bit capable peripherals
      ARM: rockchip: select ARCH_DMA_ADDR_T_64BIT for LPAE

Thierry Reding (1):
      ARM: tegra: Update default configuration for v4.13-rc1

Thomas Petazzoni (1):
      arm64: defconfig: enable nop-xceiv PHY driver

Tony Lindgren (5):
      ARM: debug: Use generic 8250 debug_ll for omap2 and omap3/4/5 common uarts
      ARM: debug: Use generic 8250 debug_ll for omap3/4/5
      ARM: debug: Use generic 8250 debug_ll for ti81xx
      ARM: debug: Use generic 8250 debug_ll for am3517 and am335x
      ARM: OMAP2+: Remove unused legacy code for DMA

Victor Chong (1):
      arm64: defconfig: enable OP-TEE

Viresh Kumar (1):
      arm64: defconfig: Enable CONFIG_WQ_POWER_EFFICIENT_DEFAULT

Wang Ruyi (1):
      arm64: defconfig: enable DMA driver for hi3660

Xiaowei Song (1):
      arm64: defconfig: enable Kirin PCIe

Yangbo Lu (1):
      ARM: multi_v7_defconfig: make eSDHC driver built-in

Yunzhi Li (1):
      ARM: hisi: Fix typo in comment


 .../devicetree/bindings/arm/omap/omap.txt       |   3 +
 MAINTAINERS                                     |  26 +++-
 arch/arm/Kconfig.debug                          |  53 +++++--
 arch/arm/boot/dts/dra71-evm.dts                 |   2 +
 arch/arm/boot/dts/dra72-evm-revc.dts            |   2 +
 arch/arm/configs/aspeed_g4_defconfig            |   5 +-
 arch/arm/configs/aspeed_g5_defconfig            |   4 +-
 arch/arm/configs/bcm2835_defconfig              |   7 +
 arch/arm/configs/davinci_all_defconfig          |   2 +
 arch/arm/configs/exynos_defconfig               |  79 +++++++++-
 arch/arm/configs/ezx_defconfig                  |   1 -
 arch/arm/configs/imx_v6_v7_defconfig            |  15 +-
 arch/arm/configs/ixp4xx_defconfig               |   4 -
 arch/arm/configs/keystone_defconfig             |  13 ++
 arch/arm/configs/multi_v7_defconfig             |  17 +--
 arch/arm/configs/omap2plus_defconfig            |   4 +
 arch/arm/configs/qcom_defconfig                 |   1 -
 arch/arm/configs/shmobile_defconfig             |  18 ++-
 arch/arm/configs/sunxi_defconfig                |  15 +-
 arch/arm/configs/tegra_defconfig                |  12 +-
 arch/arm/configs/vexpress_defconfig             |   1 -
 arch/arm/include/debug/omap2plus.S              | 108 --------------
 arch/arm/kernel/cpuidle.c                       |   4 +-
 arch/arm/kernel/devtree.c                       |   5 +-
 arch/arm/kernel/topology.c                      |   3 +-
 arch/arm/mach-ep93xx/clock.c                    |   8 +
 arch/arm/mach-ep93xx/core.c                     |  24 +++
 arch/arm/mach-ep93xx/edb93xx.c                  |   1 +
 arch/arm/mach-ep93xx/include/mach/platform.h    |   1 +
 arch/arm/mach-ep93xx/soc.h                      |   1 +
 arch/arm/mach-exynos/suspend.c                  |   7 +-
 arch/arm/mach-gemini/Kconfig                    |   5 +
 arch/arm/mach-hisi/platsmp.c                    |   2 +-
 arch/arm/mach-imx/gpc.c                         |   4 +-
 arch/arm/mach-mvebu/Kconfig                     |   2 +
 arch/arm/mach-mvebu/kirkwood.c                  |   3 +-
 arch/arm/mach-omap2/Kconfig                     |   1 +
 arch/arm/mach-omap2/board-generic.c             |   1 +
 arch/arm/mach-omap2/dma.c                       | 148 +------------------
 arch/arm/mach-omap2/id.c                        |   9 ++
 arch/arm/mach-omap2/omap-smp.c                  |   4 +-
 arch/arm/mach-omap2/omap-wakeupgen.c            |   4 +-
 arch/arm/mach-omap2/omap_device.c               |  10 --
 arch/arm/mach-omap2/omap_hwmod.c                |   4 +-
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c       |  11 +-
 arch/arm/mach-omap2/pdata-quirks.c              |  31 ++++
 arch/arm/mach-omap2/powerdomains7xx_data.c      |  33 ++++-
 arch/arm/mach-omap2/prm3xxx.c                   |   2 +-
 arch/arm/mach-omap2/prm44xx.c                   |   4 +-
 arch/arm/mach-omap2/soc.h                       |   5 +
 arch/arm/mach-rockchip/Kconfig                  |   2 +
 arch/arm/mach-rockchip/platsmp.c                |   6 +-
 arch/arm/mach-s3c24xx/Kconfig                   |   2 +-
 arch/arm/mach-s3c24xx/common.c                  |   2 +-
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h |   4 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c           |   2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c           |   8 -
 arch/arm/mach-s3c24xx/sleep.S                   |  11 +-
 arch/arm/mach-shmobile/Kconfig                  |   4 -
 arch/arm/mach-shmobile/pm-rcar-gen2.c           |  33 ++++-
 arch/arm/mach-shmobile/pm-rmobile.c             |   7 +-
 arch/arm/mach-shmobile/setup-rcar-gen2.c        |  21 ++-
 arch/arm/mach-tegra/Kconfig                     |   2 +
 arch/arm/plat-samsung/include/plat/map-s3c.h    |   2 +-
 arch/arm64/Kconfig.platforms                    |   1 +
 arch/arm64/configs/defconfig                    |  40 ++++-
 drivers/bus/omap-ocp2scp.c                      |   9 +-
 drivers/soc/versatile/soc-realview.c            |   2 +-
 include/linux/platform_data/hsmmc-omap.h        |   3 +
 69 files changed, 494 insertions(+), 396 deletions(-)
