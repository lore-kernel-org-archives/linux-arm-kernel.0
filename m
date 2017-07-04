From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:23:54 +0200
Subject: [GIT PULL 4/7] ARM: SoC defconfig updates
Message-ID: <CAK8P3a0z-Z+5N=PvY105-B+8=JY4eeR_=s3PJMQcffTZzcBhRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/armsoc-defconfig

for you to fetch changes up to a3cc999959fc9b492f3ddb48add2be6d872c16c7:

  multi_v7_defconfig: Enable OMAP MTD and DM816 AHCI (2017-06-29 17:22:18 +0200)

----------------------------------------------------------------
ARM: SoC defconfig updates

The main changes this time are from a cleanup series that Krzysztof
Koz?owski did, looking for config options in the defconfig files that
got removed or renamed. He tracked them down to make sure we don't
lose information unintentionally after an update.

Aside from that, there is the usual driver enablement, this time for
davinci, samsung, stm?2, bcm2835, qualcomm, at91, imx, mvebu, and omap.

----------------------------------------------------------------
Abhishek Sahu (1):
      ARM: qcom_defconfig: Enable IPQ4019 clock and pinctrl

Alexandre Bailon (1):
      ARM: davinci_all_defconfig: Enable CPPI 4.1 USB OTG DMA

Andrew Lunn (1):
      ARM: mvebu: Enable SENSORS_PWM_FAN in defconfig

Andy Gross (1):
      Merge tag 'qcom-defconfig-for-4.13' into defconfig-for-4.13-2

Arnd Bergmann (2):
      Merge tag 'samsung-defconfig-4.13-2' of
git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'qcom-defconfig-for-4.13-2' of
git://git.kernel.org/.../agross/linux into next/defconfig

Bhushan Shah (1):
      ARM: qcom_defconfig: enable RPMSG_QCOM_SMD

David Lechner (1):
      ARM: davinci_all_defconfig: enable LEGO MINDSTORMS EV3 battery module

Fabio Estevam (1):
      ARM: imx_v6_v7_defconfig: Select CONFIG_IMX7D_ADC

Florian Fainelli (1):
      Merge tag 'bcm2835-defconfig-next-2017-06-12' into defconfig/next

Hugues Fruchet (1):
      ARM: configs: stm32: STMPE1600 GPIO expander

Krzysztof Kozlowski (15):
      ARM: exynos_defconfig: Enable Exynos RNG and user-space crypto API
      ARM: multi_v7_defconfig: Enable Exynos RNG and user-space crypto API
      ARM: defconfig: Cleanup from old Kconfig options
      ARM: defconfig: samsung: Re-order entries to match savedefconfig
      ARM: mini2440_defconfig: Bring back lost (but wanted) options
      ARM: tct_hammer_defconfig: Bring back lost (but wanted) options
      ARM: s3c2410_defconfig: Bring back lost (but wanted) options
      ARM: s3c6400_defconfig: Bring back lost (but wanted) options
      ARM: s5pv210_defconfig: Bring back lost (but wanted) options
      ARM: exynos_defconfig: Save defconfig
      ARM: s3c2410_defconfig: Save defconfig
      ARM: mini2440_defconfig: Save defconfig
      ARM: s3c6400_defconfig: Save defconfig
      ARM: s5pv210_defconfig: Save defconfig
      ARM: tct_hammer_defconfig: Save defconfig

Leonard Crestez (3):
      ARM: imx_v6_v7_defconfig: Enable cpufreq governors
      ARM: imx_v6_v7_defconfig: Explicitly restore CONFIG_DEBUG_FS
      ARM: imx_v6_v7_defconfig: Set THERMAL_WRITABLE_TRIPS=y for testing

Olof Johansson (9):
      Merge tag 'davinci-for-v4.13/defconfig' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'samsung-defconfig-4.13' of
git://git.kernel.org/.../krzk/linux into next/defconfig
      Merge tag 'stm32-defconfig-for-v4.13-1' of
git://git.kernel.org/.../atorgue/stm32 into next/defconfig
      Merge tag 'arm-soc/for-4.13/defconfig' of
http://github.com/Broadcom/stblinux into next/defconfig
      Merge tag 'davinci-for-v4.13/defconfig-2' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/defconfig
      Merge tag 'qcom-defconfig-for-4.13' of
git://git.kernel.org/.../agross/linux into next/defconfig
      Merge tag 'at91-ab-4.13-defconfig' of
git://git.kernel.org/.../abelloni/linux into next/defconfig
      Merge tag 'mvebu-defconfig-4.13-1' of
git://git.infradead.org/linux-mvebu into next/defconfig
      Merge tag 'imx-defconfig-4.13' of
git://git.kernel.org/.../shawnguo/linux into next/defconfig

Quentin Schulz (2):
      ARM: configs: at91: make system tickless when idle
      ARM: configs: at91: enable HIGH_RES_TIMERS

Sekhar Nori (4):
      ARM: davinci_all_defconfig: cleanup with savedefconfig
      ARM: davinci_all_defconfig: enable USB audio/video device support
      ARM: davinci_all_defconfig: enable mtdtests
      ARM: davinci_all_defconfig: enable USB CDC NCM gadget

Stefan Wahren (3):
      ARM: mxs_defconfig: Enable CONFIG_CGROUPS
      ARM: mxs_defconfig: Re-enable MXS LRADC
      ARM: bcm2835_defconfig: Enable serial & ethernet USB gadget support

Tom Rini (1):
      multi_v7_defconfig: Enable OMAP MTD and DM816 AHCI

Wenyou Yang (1):
      ARM: configs: at91: add MCAN driver to sama5_defconfig

Yannick Fertre (1):
      ARM: configs: stm32: Add watchdog support in STM32 defconfig

 arch/arm/configs/acs5k_defconfig          |  8 ---
 arch/arm/configs/acs5k_tiny_defconfig     | 10 ----
 arch/arm/configs/am200epdkit_defconfig    |  7 ---
 arch/arm/configs/assabet_defconfig        |  3 -
 arch/arm/configs/axm55xx_defconfig        |  1 -
 arch/arm/configs/badge4_defconfig         |  5 --
 arch/arm/configs/bcm2835_defconfig        |  8 +++
 arch/arm/configs/cerfcube_defconfig       |  4 --
 arch/arm/configs/cm_x2xx_defconfig        | 13 -----
 arch/arm/configs/cm_x300_defconfig        | 10 ----
 arch/arm/configs/cns3420vb_defconfig      |  7 ---
 arch/arm/configs/colibri_pxa270_defconfig | 13 -----
 arch/arm/configs/colibri_pxa300_defconfig |  9 ---
 arch/arm/configs/collie_defconfig         |  4 --
 arch/arm/configs/corgi_defconfig          | 13 -----
 arch/arm/configs/davinci_all_defconfig    | 12 ++--
 arch/arm/configs/dove_defconfig           |  1 -
 arch/arm/configs/ebsa110_defconfig        |  1 -
 arch/arm/configs/efm32_defconfig          |  1 -
 arch/arm/configs/em_x270_defconfig        | 13 -----
 arch/arm/configs/ep93xx_defconfig         |  1 -
 arch/arm/configs/eseries_pxa_defconfig    |  8 ---
 arch/arm/configs/exynos_defconfig         | 12 ++--
 arch/arm/configs/ezx_defconfig            | 18 ------
 arch/arm/configs/footbridge_defconfig     |  1 -
 arch/arm/configs/h5000_defconfig          |  6 --
 arch/arm/configs/hackkit_defconfig        |  3 -
 arch/arm/configs/imote2_defconfig         | 16 ------
 arch/arm/configs/imx_v4_v5_defconfig      |  1 -
 arch/arm/configs/imx_v6_v7_defconfig      |  6 ++
 arch/arm/configs/iop13xx_defconfig        |  4 --
 arch/arm/configs/iop32x_defconfig         |  5 --
 arch/arm/configs/iop33x_defconfig         |  6 --
 arch/arm/configs/ixp4xx_defconfig         |  9 ---
 arch/arm/configs/jornada720_defconfig     |  8 ---
 arch/arm/configs/ks8695_defconfig         |  7 ---
 arch/arm/configs/lart_defconfig           |  3 -
 arch/arm/configs/lpc18xx_defconfig        |  1 -
 arch/arm/configs/lpd270_defconfig         |  5 --
 arch/arm/configs/lubbock_defconfig        |  4 --
 arch/arm/configs/magician_defconfig       | 15 -----
 arch/arm/configs/mainstone_defconfig      |  4 --
 arch/arm/configs/mini2440_defconfig       | 91 +++++++++----------------------
 arch/arm/configs/mmp2_defconfig           |  9 ---
 arch/arm/configs/moxart_defconfig         |  1 -
 arch/arm/configs/mps2_defconfig           |  1 -
 arch/arm/configs/multi_v7_defconfig       |  9 +++
 arch/arm/configs/mv78xx0_defconfig        |  8 ---
 arch/arm/configs/mvebu_v7_defconfig       |  2 +
 arch/arm/configs/mxs_defconfig            |  7 ++-
 arch/arm/configs/neponset_defconfig       |  4 --
 arch/arm/configs/netwinder_defconfig      |  3 -
 arch/arm/configs/netx_defconfig           |  6 --
 arch/arm/configs/nhk8815_defconfig        |  1 -
 arch/arm/configs/nuc910_defconfig         |  7 ---
 arch/arm/configs/nuc950_defconfig         |  7 ---
 arch/arm/configs/nuc960_defconfig         |  7 ---
 arch/arm/configs/omap1_defconfig          |  2 -
 arch/arm/configs/orion5x_defconfig        |  2 -
 arch/arm/configs/palmz72_defconfig        |  6 --
 arch/arm/configs/pcm027_defconfig         |  8 ---
 arch/arm/configs/pleb_defconfig           |  3 -
 arch/arm/configs/pxa168_defconfig         |  9 ---
 arch/arm/configs/pxa255-idp_defconfig     |  4 --
 arch/arm/configs/pxa3xx_defconfig         |  9 ---
 arch/arm/configs/pxa910_defconfig         |  9 ---
 arch/arm/configs/pxa_defconfig            |  2 -
 arch/arm/configs/qcom_defconfig           |  4 +-
 arch/arm/configs/raumfeld_defconfig       | 11 ----
 arch/arm/configs/realview_defconfig       |  1 -
 arch/arm/configs/rpc_defconfig            |  6 --
 arch/arm/configs/s3c2410_defconfig        | 38 +++----------
 arch/arm/configs/s3c6400_defconfig        | 18 ++----
 arch/arm/configs/s5pv210_defconfig        | 28 +++-------
 arch/arm/configs/sama5_defconfig          |  4 +-
 arch/arm/configs/shannon_defconfig        |  3 -
 arch/arm/configs/simpad_defconfig         |  7 ---
 arch/arm/configs/spear13xx_defconfig      |  4 --
 arch/arm/configs/spear3xx_defconfig       |  4 --
 arch/arm/configs/spear6xx_defconfig       |  3 -
 arch/arm/configs/spitz_defconfig          | 13 -----
 arch/arm/configs/stm32_defconfig          |  3 +
 arch/arm/configs/sunxi_defconfig          |  1 -
 arch/arm/configs/tct_hammer_defconfig     | 15 +----
 arch/arm/configs/trizeps4_defconfig       |  8 ---
 arch/arm/configs/u300_defconfig           |  1 -
 arch/arm/configs/vexpress_defconfig       |  1 -
 arch/arm/configs/viper_defconfig          |  9 ---
 arch/arm/configs/xcep_defconfig           |  8 ---
 arch/arm/configs/zeus_defconfig           | 10 ----
 arch/arm/configs/zx_defconfig             |  2 -
 91 files changed, 104 insertions(+), 601 deletions(-)
