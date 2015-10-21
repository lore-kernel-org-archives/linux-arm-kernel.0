From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 21 Oct 2015 11:09:57 +0100
Subject: [PATCH 00/19] devicetree: standardize/consolidate on "wakeup-source"
 property
Message-ID: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series attempts to consolidate the various existing bindings and
standardize on the widely accepted "wakeup-source" property.

Regards,
Sudeep

Sudeep Holla (19):
  Documentation: devicetree: standardize/consolidate on "wakeup-source"
    property
  Documentation: devicetree: fix reference to legacy wakeup properties
  rtc: opal: enable support for the stardard "wakeup-source" property
  rtc: isl12057: enable support for the standard "wakeup-source"
    property
  mmc: core/host: enable support for the standard "wakeup-source"
    property
  input: tegra-kbc: enable support for the standard "wakeup-source"
    property
  ARM: dts: rockchip: replace gpio-key,wakeup with wakeup-source
    property
  ARM: dts: spear: replace gpio-key,wakeup with wakeup-source property
  ARM: dts: am335x: replace gpio-key,wakeup with wakeup-source property
  ARM: dts: at91: replace gpio-key,wakeup with wakeup-source property
  ARM: dts: imx: replace legacy *,wakeup property with wakeup-source
  ARM: dts: exynos: replace legacy *,wakeup property with wakeup-source
  ARM: dts: tegra: replace legacy *,wakeup property with wakeup-source
  ARM: dts: shmobile/r8a7xxx: replace gpio-key,wakeup with wakeup-source
    property
  ARM: dts: omap: replace legacy *,wakeup property with wakeup-source
  ARM: dts: s5pv210: replace legacy *,wakeup property with wakeup-source
  ARM: dts: armada: replace isil,irq2-can-wakeup-machine with
    wakeup-source property
  ARM: dts: ste: replace legacy *,wakeup property with wakeup-source
  ARM: dts: zynq: replace gpio-key,wakeup with wakeup-source property

 .../devicetree/bindings/crypto/fsl-sec4.txt        |  4 +-
 .../devicetree/bindings/input/ads7846.txt          |  3 +-
 .../devicetree/bindings/input/gpio-keys-polled.txt |  1 +
 .../devicetree/bindings/input/gpio-keys.txt        |  1 +
 .../bindings/input/gpio-matrix-keypad.txt          |  1 +
 .../bindings/input/nvidia,tegra20-kbc.txt          |  3 +-
 .../bindings/input/qcom,pm8xxx-keypad.txt          |  1 +
 .../devicetree/bindings/input/samsung-keypad.txt   |  3 +-
 Documentation/devicetree/bindings/mfd/tc3589x.txt  |  1 +
 Documentation/devicetree/bindings/mmc/mmc.txt      |  5 +-
 .../devicetree/bindings/power/wakeup-source.txt    | 71 ++++++++++++++++++++++
 .../devicetree/bindings/rtc/isil,isl12057.txt      | 10 +--
 Documentation/devicetree/bindings/rtc/rtc-opal.txt |  5 +-
 arch/arm/boot/dts/am335x-evm.dts                   |  4 +-
 arch/arm/boot/dts/am335x-evmsk.dts                 |  2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |  6 +-
 arch/arm/boot/dts/animeo_ip.dts                    |  6 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     |  2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts     |  2 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts     |  2 +-
 arch/arm/boot/dts/at91-foxg20.dts                  |  2 +-
 arch/arm/boot/dts/at91-kizbox.dts                  |  4 +-
 arch/arm/boot/dts/at91-kizbox2.dts                 |  6 +-
 arch/arm/boot/dts/at91-kizboxmini.dts              |  4 +-
 arch/arm/boot/dts/at91-qil_a9260.dts               |  2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  2 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  2 +-
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  2 +-
 arch/arm/boot/dts/at91sam9261ek.dts                | 10 +--
 arch/arm/boot/dts/at91sam9263ek.dts                |  4 +-
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        |  4 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |  4 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |  2 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |  4 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |  6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  6 +-
 arch/arm/boot/dts/exynos4210-origen.dts            | 10 +--
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |  2 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |  2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts    |  4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  2 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |  2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts          |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  4 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           | 12 ++--
 arch/arm/boot/dts/exynos5250-snow.dts              |  4 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |  4 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  2 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  4 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  4 +-
 .../boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts  |  2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts               |  2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx28lc.dtsi       |  4 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |  2 +-
 .../boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts  |  2 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  2 +-
 arch/arm/boot/dts/imx51-digi-connectcore-som.dtsi  |  2 +-
 .../boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts  |  2 +-
 arch/arm/boot/dts/imx53-ard.dts                    |  6 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |  4 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |  2 +-
 arch/arm/boot/dts/imx53-tx53-x13x.dts              |  4 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |  2 +-
 arch/arm/boot/dts/imx6dl-tx6u-811x.dts             |  2 +-
 arch/arm/boot/dts/imx6q-gk802.dts                  |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1110.dts              |  2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |  2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |  2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |  2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  6 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |  6 +-
 arch/arm/boot/dts/imx6sl-warp.dts                  |  2 +-
 arch/arm/boot/dts/imx6sx-sabreauto.dts             |  2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi                  |  4 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts             |  4 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    |  2 +-
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  8 +--
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    | 18 +++---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                   | 10 +--
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |  2 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |  4 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |  4 +-
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |  4 +-
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |  4 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi        | 34 +++++------
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  2 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |  2 +-
 arch/arm/boot/dts/r8a7790-lager.dts                |  8 +--
 arch/arm/boot/dts/r8a7791-koelsch.dts              | 22 +++----
 arch/arm/boot/dts/rk3066a-bqcurie2.dts             |  3 +-
 arch/arm/boot/dts/rk3066a-rayeager.dts             |  2 +-
 arch/arm/boot/dts/rk3188-radxarock.dts             |  2 +-
 arch/arm/boot/dts/rk3288-evb.dtsi                  |  2 +-
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  2 +-
 arch/arm/boot/dts/rk3288-popmetal.dts              |  2 +-
 arch/arm/boot/dts/rk3288-r89.dts                   |  2 +-
 arch/arm/boot/dts/rk3288-veyron-chromebook.dtsi    |  2 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |  2 +-
 arch/arm/boot/dts/s5pv210-aquila.dts               |  4 +-
 arch/arm/boot/dts/s5pv210-goni.dts                 |  4 +-
 arch/arm/boot/dts/s5pv210-smdkv210.dts             |  2 +-
 arch/arm/boot/dts/sama5d35ek.dts                   |  2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |  2 +-
 arch/arm/boot/dts/spear1310-evb.dts                |  2 +-
 arch/arm/boot/dts/spear1340-evb.dts                |  2 +-
 arch/arm/boot/dts/spear320-hmi.dts                 |  4 +-
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi         |  2 +-
 arch/arm/boot/dts/ste-nomadik-s8815.dts            |  2 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |  2 +-
 arch/arm/boot/dts/tegra114-roth.dts                |  2 +-
 arch/arm/boot/dts/tegra114-tn7.dts                 |  2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi               |  4 +-
 arch/arm/boot/dts/tegra124-venice2.dts             |  2 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |  2 +-
 arch/arm/boot/dts/tegra20-paz00.dts                |  2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts             |  4 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |  2 +-
 arch/arm/boot/dts/tegra20-ventana.dts              |  2 +-
 arch/arm/boot/dts/tegra20-whistler.dts             |  2 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |  2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |  2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts      |  2 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi            |  2 +-
 arch/arm/boot/dts/usb_a9263.dts                    |  2 +-
 arch/arm/boot/dts/zynq-zc702.dts                   |  4 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |  2 +-
 drivers/input/keyboard/tegra-kbc.c                 |  3 +-
 drivers/mmc/core/host.c                            |  3 +-
 drivers/mmc/host/sdhci-pltfm.c                     |  3 +-
 drivers/rtc/rtc-isl12057.c                         | 10 +--
 drivers/rtc/rtc-opal.c                             |  5 +-
 146 files changed, 338 insertions(+), 254 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/wakeup-source.txt

-- 
1.9.1
