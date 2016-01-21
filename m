From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Jan 2016 17:14:38 -0800
Subject: [GIT PULL 5/9] ARM: DT updates for v4.5
In-Reply-To: <1453338882-31300-1-git-send-email-olof@lixom.net>
References: <1453338882-31300-1-git-send-email-olof@lixom.net>
Message-ID: <1453338882-31300-6-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, the bulk of this release is again DT file contents.

There's a huge number of changes here, and it's challenging to give a crisp
overview of just what is in here. To start with:

New boards:

- TI-based DM3730 from LogicPD (Torpedo)
- Cosmic+ M4 (nommu) initial support (Freescale Vybrid)
- Raspberry Pi 2 DT files
- Watchdog on Meson8b
- Veyron-mickey (ASUS Chromebit) DTS
- Rockchip rk3228 SoC and eval board
- Sigma Designs Tango4

Improvements:

- Improved support for Qualcomm APQ8084, including Sony Xperia Z DT files
- Misc new devices for Rockchip rk3036 and rk3288
- Allwinner updates for misc SoCs and systems

... and a _large_ number of other changes across the field. Devices
added to SoC DTSI and board DTS files for a number of SoC vendors, new
product boards on already-supported SoCs, cleanups and refactorings of
existing DTS/DTSI files and a bunch of other changes.


Conflicts:

Documentation/devicetree/bindings/arm/cpus.txt: Add/add. Keep both.
Documentation/devicetree/bindings/vendor-prefixes.txt: Add/add. Keep both.

----------------------------------------------------------------

The following changes since commit 893cace3c8e907059e95f1dcfa2ea7d9838f39bd:

  Merge branch 'next/soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 4dd041b6f68ad942b843038e4ff6932c6571ccad:

  Merge tag 'renesas-dt-fixes-for-v4.5' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into next/dt

----------------------------------------------------------------

Adam Ford (10):
      ARM: dts: Add audio support for LogicPD Torpedo DM3730 devkit
      ARM: dts: Change I2C2 and I2C3 to 400KHz for LogicPD Torpedo DM3730 devkit
      ARM: dts: Set VAUX1 and VAUX4 to 3.0V and 1.8V respectively
      ARM: dts: Enable UART2 pinctrl on LogicPD Torpedo + Wireless module
      ARM: dts: Change I2C2 and I2C3 to 400KHz for LogicPD Torpedo DM3730 devkit
      ARM: dts: Set VAUX1 and VAUX4 on Logic PD Torpedo
      ARM: OMAP2+: LogicPD Torpedo: Add LCD Type 15 Support
      ARM: OMAP2+: LogicPD Torpedo + Wireless: Add Bluetooth
      ARM: OMAP2+: LogicPD Torpedo: Revert Duplicative Entries
      ARM: OMAP2+: LogicPD Torpedo: Add Touchscreen Support

Adam Sampson (1):
      ARM: sun7i: dt: Enable audio codec on pcDuino V3 Nano

Afzal Mohammed (1):
      ARM: dts: vf6xx: Cosmic+: M4(nommu) initial support

Aleksei Mamlin (5):
      ARM: dts: sun7i: Enable audio codec on Wexler TAB7200 tablet.
      ARM: dts: sun7i: Enable PWM controller on Wexler TAB7200 tablet
      ARM: dts: sun7i: Enable touchscreen on Wexler TAB7200 tablet
      ARM: dts: sun7i: Add backlight node to Wexler TAB7200 tablet
      ARM: dts: sun7i: Add PA gpio pin to Wexler TAB7200 tablet

Alexandre Belloni (1):
      ARM: mxs: dt: cfa10057: fix backlight PWM

Andrew F. Davis (1):
      ARM: dts: am335x-boneblack: Use pinctrl constants and AM33XX_IOPAD macro

Andrzej Hajda (1):
      dt-bindings: remove deprecated compatible string from exynos-hdmi

Andy Gross (3):
      arm: dts: Add APQ8084 SMEM nodes
      arm: dts: Add RPM/SMD support on APQ8084
      arm: dts: Add support for PMA8084 on APQ8084

Ariel D'Alessandro (3):
      ARM: dts: lpc18xx: add EEPROM memory node
      ARM: dts: lpc4337-ciaa: enable SCT-PWM
      ARM: dts: lpc4337-ciaa: add i2c0 and devices

Arnd Bergmann (17):
      Merge branch 'lpc32xx-dts' of https://github.com/vzapolskiy/linux into next/dt
      Merge tag 'renesas-dt-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt2-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'ux500-dt-for-arm-soc' of git://git.kernel.org/.../linusw/linux-stericsson into next/dt
      Merge tag 'v4.5-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'berlin-dt-for-4.5-1' of git://git.infradead.org/users/hesselba/linux-berlin into next/dt
      Merge tag 'mvebu-dt-4.5-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'mvebu-dt-4.5-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'omap-for-v4.5/dt-pt1' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'arm-soc/for-4.5/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'realview-base-armsoc-2-tag' of git://git.kernel.org/.../linusw/linux-integrator into next/dt
      Merge tag 'socfpga_dts_for_v4.5' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'omap-for-v4.5/81xx-dts-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'davinci-for-v4.5/dts' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'samsung-dt-4.5-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'meson-for-4.5/dts' of https://github.com/carlocaione/linux-meson into next/dt
      Merge tag 'renesas-dt-fixes-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt

Bai Ping (1):
      ARM: dts: imx: modify the clocks used by cpufreq driver

Bjorn Andersson (14):
      ARM: dts: qcom: msm8974-honami: Define pinctrl state for blsp_uart2
      ARM: dts: qcom: msm8974-honami: Add regulator nodes for Honami
      ARM: dts: qcom: msm8974-honami: Introduce gpio-keys
      ARM: dts: qcom: msm8974-honami: Add sdhci1 node
      ARM: dts: qcom: msm8974-honami: Add uSD slot nodes
      ARM: dts: qcom: msm8974-honami: Specify charging parameters
      dt-binding: soc: qcom: Add Qualcomm SMSM device tree documentation
      dt-binding: soc: qcom: Introduce qcom, smp2p binding documentation
      ARM: dts: qcom: apq8064: Add hwmutex and SMEM nodes
      ARM: dts: qcom: apq8064: Declare all pm8921 regulators
      ARM: dts: qcom: apq8064: Introduce gsbi5 and gsbi5 serial node
      ARM: dts: qcom: apq8064: Introduce Sony Xperia Z dts
      ARM: dts: qcom: msm8974: Disable wled and move it to honami
      ARM: dts: qcom: msm8974: Add i2c8 node

Caesar Wang (6):
      ARM: dts: rockchip: update the thermal management on rk3288
      ARM: dts: rockchip: fix voltage ranges for rk3288-evb-act8846 board
      ARM: dts: rockchip: add eFuse node for rk3066a SoCs
      ARM: dts: rockchip: add eFuse node for rk3188 SoCs
      ARM: dts: rockchip: add the sdio/sdmmc node for rk3036
      ARM: dts: rockchip: add the kylin board for rk3036

Carlo Caione (2):
      Documentation: watchdog: Add new bindings for meson8b
      ARM: dts: meson8b: Add watchdog node

Chen-Yu Tsai (17):
      ARM: dts: sun8i: Add simplefb node labels to reference at board level
      ARM: dts: sun9i: Add A80 PRCM clocks and reset control nodes
      ARM: dts: sun9i: Add TODO comments for the main and low power clocks
      ARM: dts: sun9i: Add A80 R_PIO pin controller device node
      ARM: dts: sun9i: optimus: Enable LED3
      ARM: dts: sun9i: Add consumer IR receiver device node and pinmux settings
      ARM: dts: sun9i: optimus: Enable consumer IR receiver
      ARM: dts: sun9i: Add Reduced Serial Bus controller device node to A80 dtsi
      ARM: dts: sun9i: optimus: Enable Reduced Serial Bus controller
      ARM: dts: sun9i: Add NMI controller device node
      ARM: dts: sun4i: Add DRAM gates
      ARM: dts: sun7i: Add DRAM gates
      ARM: dts: sun4i: Add VE (Video Engine) module clock node
      ARM: dts: sun7i: Add VE (Video Engine) module clock node
      ARM: dts: sun9i: cubieboard4: Enable LEDs
      ARM: dts: sun9i: cubieboard4: Enable consumer IR receiver
      ARM: dts: sun9i: cubieboard4: Enable Reduced Serial Bus controller

Chris Zhong (4):
      ARM: dts: rockchip: add veyron-mickey board
      ARM: dts: rockchip: correct the name of REG8 for rk3288-evb-act8846
      ARM: dts: rockchip: add 2 regulators for rk3288-evb-act8846
      ARM: dts: rockchip: move the public part to rk3288-evb common

Cory Tusar (1):
      ARM: dts: vfxxx: Include support for dspi[23] functionality.

Damien Riegel (7):
      of: add vendor prefix for Technologic Systems
      of: documentation: add bindings documentation for TS-4800
      ARM: dts: TS-4800: add basic device tree
      ARM: dts: TS-4800: drop uart rts/cts pin reservations
      ARM: dts: TS-4800: use weim IP to map the FPGA
      ARM: dts: ts-4800: Add LCD support
      ARM: dts: TS-4800: add touchscreen support

Dmitry Lifshitz (19):
      ARM: dts: am57xx: cl-som-am57x: add basic module support
      ARM: dts: am57xx: cl-som-am57x: dts: add RTC support
      ARM: dts: am57xx: cl-som-am57x: add I2C3 support
      ARM: dts: am57xx: cl-som-am57x: add EEPROM support
      ARM: dts: am57xx: cl-som-am57x: add eMMC support
      ARM: dts: am57xx: cl-som-am57x: add spi-flash support
      ARM: dts: am57xx: cl-som-am57x: add dual EMAC support
      ARM: dts: am57xx: cl-som-am57x: add USB support
      ARM: dts: am57xx: cl-som-am57x: add touchscreen support
      ARM: dts: am57xx: cl-som-am57x: add analog audio support
      ARM: dts: am57xx: sbc-am57x: add basic board support
      ARM: dts: am57xx: cl-som-am57x: add MMC1 support
      ARM: dts: am57xx: sbc-am57x: add usb vbus pinmux
      ARM: dts: am57xx: sbc-am57x: add EEPROM support
      ARM: dts: am57xx: sbc-am57x: add GPIO expander support
      ARM: dts: am57xx: sbc-am57x: add LCD support
      ARM: dts: am57xx: compulab-sb-som: add HDMI connector
      ARM: dts: am57xx: sbc-am57x: add HDMI support
      ARM: dts: am57xx: cl-som-am57x: skip resetting ETH PHYs

Edward Cragg (1):
      ARM: meson: Add status LED for Odroid-C1

Eric Anholt (4):
      ARM: bcm2835: Split the DT for peripherals from the DT for the CPU
      ARM: bcm2835: Move the CPU/peripheral include out of common RPi DT.
      ARM: bcm2835: Add devicetree for bcm2836 and Raspberry Pi 2 B
      ARM: bcm2835: Add the auxiliary clocks to the device tree.

Erin Lo (2):
      Document: DT: Add bindings for mediatek MT2701 SoC Platform
      ARM: dts: mediatek: add MT2701 basic support

Fabio Estevam (2):
      ARM: dts: imx6sx: Pass the 'adck-max-frequency' property
      ARM: dts: imx6ul: Add ADC support

Florian Fainelli (3):
      clk: iproc: Extend binding to cover BCM63138
      clk: bcm: Add BCM63138 clock support
      ARM: dts: BCM63xx: Add ARMPLL device tree nodes

Franklin S Cooper Jr (2):
      ARM: dts: am437x/am33xx/omap/dm816x: Add gpmc dma channel
      ARM: dts: omap4: Add elm node

Geert Uytterhoeven (26):
      ARM: shmobile: r8a7794 dtsi: Remove bogus imp_clk node
      ARM: shmobile: r8a7791 dtsi: Remove bogus imp_clk node
      ARM: shmobile: koelsch: Move SPI FLASH partitions to subnode
      ARM: shmobile: bockw: Move SPI FLASH partition to subnode
      ARM: shmobile: porter: Move SPI FLASH partitions to subnode
      ARM: shmobile: lager: Move SPI FLASH partitions to subnode
      ARM: shmobile: silk: Move SPI FLASH partitions to subnode
      ARM: shmobile: r8a7740 dtsi: Add L2 cache-controller node
      ARM: shmobile: sh73a0 dtsi: Add L2 cache-controller node
      ARM: shmobile: sh73a0: Add MSIOF clocks
      ARM: shmobile: sh73a0: Add MSIOF device nodes
      ARM: shmobile: bockw dts: Override #sound-dai-cells to zero
      ARM: shmobile: koelsch dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: alt dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: ape6evm dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: bockw dts: Update console parameters
      ARM: shmobile: gose dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: silk dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: porter dts: Add serial port config to chosen/stdout-path
      ARM: shmobile: lager dts: Add serial port config to chosen/stdout-path
      ARM: dts: bockw: Add compatible property to "partitions" node
      ARM: dts: lager: Add compatible property to "partitions" node
      ARM: dts: koelsch: Add compatible property to "partitions" node
      ARM: dts: porter: Add compatible property to "partitions" node
      ARM: dts: gose: Add compatible property to "partitions" node
      ARM: dts: silk: Add compatible property to "partitions" node

Georgi Djakov (1):
      arm: dts: qcom: apq8064: Add fixed rate on-board oscillators

Gregory CLEMENT (1):
      ARM: at91/dt: Add Support for the L+G VInCo platform

Haibo Chen (2):
      ARM: dts: imx7d.dtsi: add ADC support
      ARM: dts: imx7d-sdb: add ADC support

Hans Ulli Kroll (1):
      ARM: dts: kirkwood: Add DTS for Zyxel NSA325

Hans de Goede (11):
      ARM: dts: sun4i: inet9f-rev03: Add support for game buttons / joysticks
      ARM: dts: sun4i: Enable onboard codec used on the iNet1 tablet
      ARM: dts: sun4i: Add backlight node to iNet1 tablet
      ARM: dts: sun5i: Add backlight node to UTOO P66 tablet
      ARM: dts: sun4i: Add backlight node to pov protab2 ips9 tablet
      ARM: dts: sun4i: Add touchscreen node to iNet1 tablet
      ARM: dts: sun4i: Add touchscreen node to pov protab2-ips9 tablet
      ARM: dts: sun5i: Enable onboard codec used on the UTOO P66 tablet
      ARM: dts: sun4i: Enable onboard codec used on the pov protab2-ips9 tablet
      ARM: dts: sun7i: Enable gmac on Wits Pro A20 DKT
      ARM: dts: sun5i: Add dts file for the Empire Electronix D709 tablet

Heiko Schocher (2):
      regulator: tps65217: remove tps65217.dtsi file
      arm, am335x: add support for the bosch shc board

Heiko Stuebner (8):
      ARM: dts: rockchip: Setup rk3066/rk3188 ethernet0 alias for u-boot
      Merge branch 'v4.5-clk/clkids' into v4.5-armsoc/dts32
      ARM: dts: rockchip: override thermal settings on veyron-speedy
      ARM: dts: rockchip: make sure edp_24m is associated to xin24m on veyron
      ARM: dts: rockchip: add veyron-brain board
      ARM: dts: rockchip: add touchscreen node to veyron minnie
      ARM: dts: rockchip: add gpio-ir-receiver to the R89 board
      Merge branch 'v4.5-clk/clkids' into v4.5-armsoc/dts32

Ilya Ledvich (10):
      ARM: dts: cm-t335: add initial support
      ARM: dts: cm-t335: add basic support for I2C
      ARM: dts: cm-t335: add support for NAND flash
      ARM: dts: cm-t335: add support for MMC
      ARM: dts: cm-t335: add support for network device
      ARM: dts: cm-t335: add support for PWM backlight
      ARM: dts: cm-t335: add support for USB0
      ARM: dts: imx7d: cl-som-imx7: add basic module support
      ARM: dts: imx7d: sbc-imx7: add basic board support
      ARM: dts: compulab: add new board description

Ivan T. Ivanov (1):
      ARM: dts: qcom: apq8064-ifc6410 Use hardware flow control for GSBI6

Javier Martinez Canillas (50):
      ARM: ux500: remove regulator-compatible usage
      ARM: u300: remove regulator-compatible usage
      pinctrl: Move am4372 and dra7 macros to the the SoC header files
      ARM: dts: am335x-baltos-ir5221: Remove leftover pinctrl lines
      ARM: dts: am335x-baltos-ir5221: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-bone-common: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-bonegreen: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-chiliboard: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-chilisom: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-evm: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-evmsk: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-lxm: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-nano: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-pepper: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-phycore-som: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am335x-wega: Use AM33XX_IOPAD pinmux macro
      ARM: dts: am3517-craneboard: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: am437x-gp-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am437x-idk-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am437x-sk-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am43x-epos-evm: Use AM4372_IOPAD pinmux macro
      ARM: dts: am57xx-beagle-x15: Use DRA7XX_CORE_IOPAD pinmux macro
      ARM: dts: dra7-evm: Use DRA7XX_CORE_IOPAD pinmux macro
      ARM: dts: dra72-evm: Use DRA7XX_CORE_IOPAD pinmux macro
      ARM: dts: omap3-beagle: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: omap3-beagle-xm: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: omap3-evm-37xx: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: omap3-ldp: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap3-n900: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap3-n9: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap3-zoom3: Use OMAP3_*_IOPAD pinmux macros
      ARM: dts: twl4030: Use OMAP3_CORE1_IOPAD pinmux macro
      ARM: dts: omap4-panda-a4: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-panda-common: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-panda-es: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-sdp: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap4-sdp-es23plus: Use OMAP4_IOPAD pinmux macro
      ARM: dts: twl6030: Use OMAP4_IOPAD pinmux macro
      ARM: dts: omap5-board-common: Use OMAP5_IOPAD pinmux macro
      ARM: dts: omap5-cm-t54: Use OMAP5_IOPAD pinmux macro
      ARM: dts: omap5-uevm.dts: Use OMAP5_IOPAD pinmux macro
      ARM: dts: omap3-igep0020: Use MMC pwrseq to init SDIO WiFi
      ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi
      ARM: dts: Mark SDIO as non-removable in exynos5800-peach-pi
      ARM: dts: Mark SDIO as non-removable in exynos5420-peach-pit
      ARM: dts: Mark SDIO as non-removable in exynos5250-snow-common
      ARM: dts: Remove broken-cd from eMMC node in exynos5800-peach-pi
      ARM: dts: Remove broken-cd from eMMC node in exynos5420-peach-pi
      ARM: dts: Mark eMMC as non-removable in exynos5250-snow-common
      ARM: dts: Remove unneeded GPIO include in exynos4412-odroidu3

Jeffy Chen (2):
      ARM: dts: rockchip: add core rk3228 dtsi
      ARM: dts: rockchip: add rk3228-evb board

Jelle van der Waa (1):
      ARM: dts: sun7i: Enable audio codec on pcDuino

Jens Kuske (2):
      ARM: dts: sunxi: Add Allwinner H3 DTSI
      ARM: dts: sun8i: Add Orange Pi Plus support

Jisheng Zhang (6):
      arm: dts: berlin2q-marvell-dmp: remove broken-cd from eMMC node
      arm: dts: berlin2q: remove duplicated interrupt-parent
      arm: dts: berlin2q: add watchdog nodes
      arm: dts: berlin2cd: add watchdog nodes
      arm: dts: berlin2: add watchdog nodes
      arm: dts: berlin2q-marvell-dmp: add sdhci1 fully functionality

Joachim Eastwood (2):
      ARM: dts: lpc4357: enable EEPROM memory
      ARM: dts: lpc4357-ea4357: add mma7455 i2c accelerometer

John Keeping (1):
      ARM: dts: rockchip: set system-power-controller property on rk3288-rock2

John Stultz (1):
      devicetree: Add hardware rng entry to qcom-apq8064.dtsi

Jon Mason (9):
      ARM: dts: NSP: Add PCI support
      ARM: dts: NSP: Add NAND Support to DT
      ARM: dts: NSP: Add TWD Support to DT
      dt-bindings: Add new SoCs to bcm4708 DT bindings
      ARM: dts: bcm5301x: Add BCM SVK DT files
      ARM: dts: NSP: Device Tree clean-ups
      ARM: dts: NSP: Add I2C support to the DT
      ARM: dts: enable clock support for BCM5301X
      ARM: dts: enable clock support for Broadcom NSP

Kapil Hali (2):
      dt-bindings: add SMP enable-method for Broadcom NSP
      ARM: dts: Add SMP support for Broadcom NSP

Karsten Merker (2):
      ARM: dts: sun7i: Olimex A20-SOM-EVB: Add LRADC keys
      ARM: dts: sun7i: Olimex A20-SOM-EVB: Enable mmc3 (baseboard SD socket)

Keerthy (2):
      ARM: dts: DRA72-EVM: Add regulator-allow-bypass property for ldo1 and ldo2
      ARM: dts: DRA7-EVM: Add regulator-allow-bypass property for ldo9

Krzysztof Kozlowski (4):
      clk: samsung: exynos4: Add SSS gate clock
      Merge tag 'samsung-clk-exynos4-4.5' into next/dt
      ARM: dts: Add PRNG module for exynos4
      ARM: dts: Enable PRNG module on exynos4412-trats2

Kuninori Morimoto (1):
      ARM: shmobile: r8a7778: tidyup #sound-dai-cells settings

Laurent Pinchart (4):
      ARM: shmobile: r8a7794: Add DU0 clock
      ARM: shmobile: r8a7794: Add DU node to device tree
      ARM: shmobile: r8a7793: Add DU node to device tree
      ARM: shmobile: r8a7791: koelsch: Fix pinmux for HDMI

Lawrence Yu (1):
      dts: sun6i: yones toptech bs1078 v2: Add AXP221 support to dts

Linus Walleij (10):
      ARM: ux500: push down Rohm TS to STUIB
      ARM: ux500: Assign proper sensor IRQs for Snowball
      ARM: ux500: configure the sensors on the TVK board correctly
      ARM: add DT bindings for the ARM11MPCore CPU cluster
      clk: add ARM syscon ICST device tree bindings
      ARM: realview: add device tree for PB11MPCore
      ARM: mvebu: add kirkwood compatibles for cloudengine boards
      ARM: mvebu: kirkwood: add PogoPlug series 4 device tree
      ARM: realview: set up cache correctly on the PB11MPCore
      ARM: versatile: add the syscon LEDs to the DT

Lucas Stach (3):
      ARM: dts: imx6: remove config space from PCIe controller ranges property
      ARM: dts: imx6qdl: move GIC to right location in DT
      ARM: dts: imx6: add Vivante GPU nodes

Ludovic Desroches (2):
      ARM: at91/dt: sama5d4: update i2c compatible string
      ARM: at91/dt: sama5d2 Xplained: pmic needs a specific sda hold time

Magnus Damm (9):
      ARM: shmobile: r8a7794: Disable all IPMMU nodes by default
      ARM: shmobile: r8a7793: Add IPMMU nodes
      ARM: shmobile: r8a7794: alt: Enable VGA port
      ARM: shmobile: r8a7793: Add GPIO nodes to device tree
      ARM: shmobile: r8a7794: alt: Enable PFC DU for the VGA port
      ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
      ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
      ARM: shmobile: r8a7793: IPMMU compat string SoC part number update
      ARM: shmobile: r8a7794: IPMMU compat string SoC part number update

Mans Rullgard (1):
      ARM: dts: imx28: add alternate auart4 pinmux

Marc Gonzalez (1):
      ARM: dts: tango4: Initial device trees

Marc Kleine-Budde (1):
      ARM: dts: imx25: add alias for pwm nodes

Marcus Cooper (2):
      ARM: sunxi: dt: enable audio codec on mk802
      ARM: dt: sun7i: Enable audio codec on MK808C

Marcus Weseloh (1):
      ARM: dts: sun4i: Enable audio codec on Olimex A20-SOM-EVB

Marek Szyprowski (10):
      ARM: dts: Remove fimd node from exynos5422-odroidxu3-common
      ARM: dts: Add rotator nodes on exynos4
      ARM: dts: Fix power domain for sysmmu-rotator device on exynos4
      ARM: dts: Add rotator node on exynos5250
      ARM: dts: Add rotator node on exynos5420
      ARM: dts: Use peripheral mode for dwc3_1 on exynos5422-odroidxu3
      ARM: dts: exynos4210-universal_c210: Disable DMA for UARTs
      ARM: dts: MDMA1 device belongs to LCD0 power domain on exynos4210
      ARM: dts: Add power domain to G2D device on exynos4210
      ARM: dts: Unify G2D device node with other devices on exynos4

Marek Vasut (6):
      ARM: socfpga: Add support for DENX MCV SoM and MCVEVK baseboard
      ARM: at91/dt: sama5d4: Fix mmc0 pinmux comments
      ARM: at91/dt: sama5d4: Add pinmux for 8-bit MMC0 bus
      ARM: at91/dt: sama5d4: Add support for DENX MA5D4 SoM and EVK
      ARM: socfpga: Repair incorrectly applied MCV patch
      ARM: socfpga: dts: Enable MMC support at correct place in the DT

Markus Pargmann (1):
      ARM: dts: imx6dl: Fix gpt compatibles, remove imx6q-gpt

Masahiro Yamada (4):
      ARM: dts: uniphier: change IRQ number of UART3 of PH1-Pro4 SoC
      ARM: dts: uniphier: factor out common nodes to uniphier-common32.dtsi
      ARM: dts: zynq: describe SLCR as simple-mfd rather than simple-bus
      ARM: dts: uniphier: fix a typo in comment block

Matthias Brugger (1):
      ARM: dts: rockchip: Fix typo in rk3288 sdmmc card detect pin name

Meng Yi (2):
      ARM: dts: ls1021a: Add DCU dts node.
      ARM: dts: ls1021a: Add a TFT LCD panel.

Michael van Slingerland (1):
      ARM: dts: sun5i: Add i2c axp152 pmic support for Auxtek T004 boards

Moritz Fischer (1):
      ARM: dt: zynq: Add labels to cpu nodes to allow overriding OPPs.

Mugunthan V N (2):
      ARM: dts: dra7: add spi alias for qspi
      ARM: dts: am4372: add spi alias for qspi

Neil Armstrong (3):
      ARM: dts: add dm816x pwm property to timers
      ARM: dts: remove dm816x invalid DT l3_main hwmod
      ARM: dts: Add omap4-hwspinlock support in dm816x

Nicolas Ferre (1):
      ARM: at91/dt: sama5d4 master clock can run at 200MHz now

Nikita Kiryanov (14):
      ARM: dts: am437x: cm-t43: add basic support for sbc-t43
      ARM: dts: am437x: cm-t43: add support for module eeprom
      ARM: dts: am437x: cm-t43: add PMIC support.
      ARM: dts: am437x: cm-t43: add spi-flash support
      ARM: dts: am437x: cm-t43: add NAND support
      ARM: dts: am437x: cm-t43: add dual emac support
      ARM: dts: am437x: cm-t43: add USB support
      ARM: dts: am437x: cm-t43: add eMMC support
      ARM: dts: am437x: cm-t43: add touchscreen support
      ARM: dts: am437x: cm-t43: add pca9555 support
      ARM: dts: am437x: cm-t43: add support for baseboard eeprom
      ARM: dts: sb-som: introduce SB-SOM baseboard
      ARM: dts: am437x: cm-t43: add support for mmc1
      ARM: dts: am437x: cm-t43: add lcd support

Olof Johansson (15):
      Merge tag 'samsung-dt-syscon-restart-4.5' of https://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'zynq-dt-for-4.5' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'sunxi-dt-for-4.5' of https://git.kernel.org/.../mripard/linux into next/dt
      Merge tag 'at91-dt' of git://git.kernel.org/.../nferre/linux-at91 into next/dt
      Merge tag 'qcom-dt-for-4.5' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'renesas-dt3-for-v4.5' of git://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'mvebu-dt-4.5-3' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'v4.4-next-dts' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'lpc18xx_dts_for_4.5' of https://github.com/manabian/linux-lpc into next/dt
      Merge tag 'v4.5-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'socfpga_dts_for_v4.5_part_2' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'omap-for-v4.5/dt-pt2' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'imx-dt-4.5' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'at91-4.5-dt2' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'sunxi-dt-for-4.5-2' of https://git.kernel.org/.../mripard/linux into next/dt

Peter Chen (2):
      ARM: dts: imx6: set ahb-burst-config as 0 for USB
      ARM: dts: imx6: change default burst size for USB

Peter Ujfalusi (8):
      ARM: DTS: am33xx: Use the new DT bindings for the eDMA3
      ARM: DTS: am437x: Use the new DT bindings for the eDMA3
      ARM: DTS: da850: fix edma0 reg space
      ARM: DTS: da850: Use the new DT bindings for the eDMA3
      ARM: DTS: da850: Enable eDMA1
      ARM: DTS: da850: Enable DMA use for MMC0
      ARM: DTS: da850: Add node for mmc1
      ARM: DTS: da850: Enable DMA for SPI1

Philipp Zabel (2):
      ARM: mediatek: DT: Move reset controller constants into common location
      ARM: dts: imx6qdl: add IPU aliases

Pramod Kumar (2):
      dts: pinctrl: Add GPIO to Pinctrl pin mapping in DT
      ARM: dts: Cygnus: define ngpios property in gpio controller's node

Priit Laes (4):
      ARM: dts: sun4i: gemei-g9: Convert to use axp209 regulator nodes
      ARM: dts: sun4i: gemei-g9: Use reg_ldo2 instead of reg_vcc3v0
      ARM: dts: sun4i: gemei-g9: Enable sun4i audio codec support
      ARM: dts: sun4i: gemei-g9: Enable PA GPIO pin configuration

Rafa? Mi?ecki (1):
      ARM: BCM5301X: Add missing Netgear R8000 LEDs

Ray Jui (2):
      ARM: dts: enable PCIe PHY support for Cygnus
      ARM: dts: Enable MSI support for Broadcom Cygnus

Roman Volkov (1):
      dts: vt8500: Fix errors in SDHC node for WM8505

Russell King (6):
      dt-bindings: add Marvell core PLL and clock divider PMU documentation
      ARM: dts: dove: add Dove divider clocks
      dt-bindings: add Marvell PMU documentation
      ARM: dts: Add SolidRun Armada 388 Clearfog A1 DT file
      ARM: dts: dove: add DT GPU support
      ARM: dts: enable GPU for SolidRun's Cubox

Sascha Hauer (1):
      dt-bindings: soc: Add supplies for Mediatek SCPSYS unit

Sean Cross (2):
      devicetree: bindings: Add vendor prefix for Kosagi
      ARM: dts: imx6q: add Novena board

Sebastian Hesselbarth (3):
      ARM: dt: mvebu: ix4-300d: remove whole flash partition
      ARM: dt: mvebu: ix4-300d: move partitions to partition sub-node
      ARM: dt: mvebu: ix4-300d: Cleanup NAND partition ranges

Sergei Shtylyov (8):
      ARM: shmobile: porter: add HS-USB DT support
      ARM: shmobile: silk: add SDHI1 DT support
      ARM: shmobile: r8a7790: fix "gpio-ranges" props
      ARM: shmobile: r8a7791: fix "gpio-ranges" props
      ARM: shmobile: porter: add CAN0 DT support
      ARM: shmobile: henninger: remove board DT
      ARM: shmobile: r8a7791: add EtherAVB clock
      ARM: shmobile: r8a7791: add EtherAVB DT support

Shawn Guo (2):
      Merge branch 'imx/clk' into imx/dt
      ARM: dts: imx6q: clean up unused ipu2grp

Shengjiu Wang (1):
      ARM: dts: imx6: Change the clock name for spba clock

Simon Horman (18):
      ARM: shmobile: r8a7793: Add thermal device to DT
      ARM: shmobile: r8a7793: Add PFC to DT
      ARM: shmobile: gose: Configure PFC in DT
      ARM: shmobile: r8a7793: Add DMAC devices to DT
      ARM: shmobile: r8a7793: Add QSPI device to DT
      ARM: shmobile: gose: Add QSPI device to DT
      ARM: shmobile: r8a7790: Use SoC specific binding for rcar-dmac nodes
      ARM: shmobile: r8a7791: Use SoC specific binding for rcar-dmac nodes
      ARM: shmobile: r8a7793: Use SoC specific binding for rcar-dmac nodes
      ARM: shmobile: r8a7794: Use SoC specific binding for rcar-dmac nodes
      ARM: shmobile: alt: Add pfc pins to DT
      Merge tag 'v4.4-rc1' into HEAD
      ARM: shmobile: alt: Correct scif2 pfc
      ARM: shmobile: alt: Correct ether pfc
      ARM: shmobile: r8a7793: remove deprecated #gpio-range-cells
      ARM: shmobile: r8a7793: Add missing serial devices to DT
      ARM: shmobile: r8a7793: Describe DMA for the serial ports
      ARM: shmobile: r8a779x: use SoC-specific usb-dmac compatibility strings

Sjoerd Simons (2):
      ARM: dts: rockchip: Setup rk3288 ethernet0 alias for u-boot
      ARM: dts: rockchip: Add IR receiver to RK3288 Radxa Rock 2 Square

Songjun Wu (2):
      ARM: at91/dt: sama5d2: add pdmic node
      ARM: at91/dt: sama5d2 Xplained: add pdmic node

Soren Brinkmann (1):
      ARM: zynq: DT: Add interrupt-controller property to GPIO

Stefan Agner (1):
      ARM: dts: vf-colibri: add CAN support

Stefan Monnier (2):
      ARM: dts: sun7i: Enable audio codec on OrangePi Mini
      ARM: dts: sun7i: Enable audio codec on BananaPi

Stefan Roese (1):
      arm: sun7i: Add sun7i-a20-icnova-swac.dts

Stephen Boyd (4):
      arm: dts: qcom: Add board clocks
      arm: dts: qcom: Update ifc6540 compat for qcom boot format
      arm: dts: qcom: Add aliases for PMICs
      arm: dts: qcom: Add generic PMIC gpio/MPP compat strings

Sudeep Holla (6):
      ARM: dts: shmobile/r8a7xxx: replace gpio-key, wakeup with wakeup-source property
      ARM: ux500: replace legacy *,wakeup property with wakeup-source
      ARM: dts: zynq: replace gpio-key,wakeup with wakeup-source property
      ARM: dts: armada: replace isil, irq2-can-wakeup-machine with wakeup-source property
      ARM: dts: am335x: replace gpio-key,wakeup with wakeup-source property
      ARM: dts: omap: replace legacy *,wakeup property with wakeup-source

Sugar Zhang (1):
      ARM: dts: rockchip: add channels properties for i2s

Tang Yuantian (1):
      ARM: dts: ls1021a: add sata node to dts

Thomas Petazzoni (1):
      ARM: mvebu: remove duplicated regulator definition in Armada 388 GP

Tim Harvey (5):
      ARM: dts: imx: ventana: GW54xx PMIC swbst reg always-on
      ARM: dts: imx: ventana: fix GW53xx/GW54xx lvds channel
      ARM: dts: imx: ventana: Allow HDMI and LVDS to work simultaneously
      ARM: dts: imx: ventana: add PWM nodes for Ventana boards
      ARM: dts: imx: ventana: Add SPI support for GW52xx

Tony Lindgren (13):
      Merge commit 'ae0add740cd06169cd124f9aaa6eceb11e5b3060' into omap-for-v4.5/dt
      ARM: dts: Add basic support for dra62x j5-eco SoC
      ARM: dts: Add minimal dra62x j5-eco evm support
      ARM: dts: Add pinctrl macros for dm814x
      ARM: dts: Update edma bindings on dm814x to use edma_xbar
      ARM: dts: Add mmc device entries for dm814x
      ARM: dts: Add mmc support for dm8148-evm
      ARM: dts: Add mmc support for dra62x j5-eco evm
      ARM: dts: Enable emmc on hp t410
      ARM: dts: Add usb support for dm814x and dra62x
      ARM: dts: Add usb support for dm814x-evm
      ARM: dts: Add usb support for hp t410
      ARM: dts: Add usb support for j5-eco evm

Ulrich Hecht (4):
      ARM: shmobile: alt: add I2C1 DT support
      ARM: shmobile: alt: add VIN0, ADV7180 DT support
      ARM: shmobile: r8a7790: switch console back to scif0
      ARM: shmobile: bockw dts: define sdhi0 pins with pull-ups

Uri Mashiach (4):
      ARM: dts: cm-t335: add support for SBC-T335
      ARM: dts: cm-t335: add support for I2C GPIO expander
      ARM: dts: cm-t335: add support for DVI/LCD
      ARM: dts: cm-t335: add support for bluetooth

Uwe Kleine-K?nig (1):
      ARM: dts: imx25-pinfunc: add some more pin configurations

Vignesh R (3):
      ARM: dts: dra72-evm: Mark uart1 rxd as wakeup capable
      ARM: dts: DRA7: add entry for qspi mmap region
      ARM: dts: AM4372: add entry for qspi mmap region

Vladimir Zapolskiy (8):
      arm: dts: lpc32xx: change include syntax to be C preprocessor friendly
      arm: dts: lpc32xx: add labels to all defined peripheral nodes
      arm: dts: lpc32xx: add reg property to cpu device node
      arm: dts: lpc32xx: add device node for the second pwm controller
      arm: dts: ea3250/phy3250: specify phys memory offset for lpc32xx boards
      arm: dts: lpc32xx: add external memory controller device node
      arm: dts: lpc32xx: add device nodes for standard timers
      arm: dts: lpc32xx: move USB controller subdevices into own device node

Wenyou Yang (1):
      ARM: at91/dt: sama5d2: add watchdog node

Wolfram Sang (5):
      ARM: shmobile: r8a7791: remove deprecated #gpio-range-cells from dtsi
      ARM: shmobile: r8a7794: remove deprecated #gpio-range-cells from dtsi
      ARM: shmobile: r8a7790: dtsi: add internal delay for i2c IPs
      ARM: shmobile: r8a7791: dtsi: add internal delay for i2c IPs
      ARM: shmobile: r8a7794: dtsi: add internal delay for i2c IPs

Xing Zheng (3):
      ARM: dts: rockchip: add core rk3036 dtsi
      ARM: dts: rockchip: add rk3036-evb board
      ARM: dts: rockchip: fix the pinctrl bias settings for rk3036

Yendapally Reddy Dhananjaya Reddy (1):
      ARM: dts: enable pinctrl for Broadcom NSP

Zain Wang (1):
      ARM: dts: rockchip: Add Crypto node for rk3288

ZhengShunQian (1):
      ARM: dts: rockchip: add eFuse config of rk3288 SoC


 .../bindings/arm/bcm/brcm,bcm4708.txt           |   7 +
 .../bindings/arm/bcm/brcm,nsp-cpu-method.txt    |  39 +
 .../devicetree/bindings/arm/compulab-boards.txt |  25 +
 Documentation/devicetree/bindings/arm/cpus.txt  |   1 +
 .../bindings/arm/marvell,kirkwood.txt           |   2 +
 .../devicetree/bindings/arm/mediatek.txt        |   4 +
 .../bindings/arm/mediatek/mediatek,infracfg.txt |   2 +-
 .../bindings/arm/mediatek/mediatek,pericfg.txt  |   2 +-
 .../devicetree/bindings/arm/omap/omap.txt       |  18 +
 .../devicetree/bindings/arm/rockchip.txt        |  22 +
 Documentation/devicetree/bindings/arm/scu.txt   |   3 +
 .../devicetree/bindings/arm/technologic.txt     |   6 +
 .../bindings/clock/arm-syscon-icst.txt          |  40 +
 .../bindings/clock/dove-divider-clock.txt       |  28 +
 .../bindings/display/exynos/exynos_hdmi.txt     |   7 +-
 .../display/panel/startek,startek-kd050c.txt    |   4 +
 .../interrupt-controller/mediatek,sysirq.txt    |   1 +
 .../devicetree/bindings/regulator/tps65217.txt  |  10 +
 .../devicetree/bindings/serial/mtk-uart.txt     |  14 +-
 .../devicetree/bindings/soc/dove/pmu.txt        |  56 ++
 .../devicetree/bindings/soc/mediatek/scpsys.txt |  12 +
 .../devicetree/bindings/soc/qcom/qcom,smp2p.txt | 104 +++
 .../devicetree/bindings/soc/qcom/qcom,smsm.txt  | 104 +++
 .../devicetree/bindings/spi/ti_qspi.txt         |  22 +-
 .../bindings/timer/mediatek,mtk-timer.txt       |   1 +
 .../devicetree/bindings/vendor-prefixes.txt     |   3 +
 .../watchdog/{meson6-wdt.txt => meson-wdt.txt}  |   2 +-
 .../devicetree/bindings/watchdog/mtk-wdt.txt    |   6 +-
 arch/arm/boot/dts/Makefile                      |  63 +-
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      | 186 +++--
 arch/arm/boot/dts/am335x-bone-common.dtsi       | 118 +--
 arch/arm/boot/dts/am335x-boneblack.dts          |  44 +-
 arch/arm/boot/dts/am335x-bonegreen.dts          |   4 +-
 arch/arm/boot/dts/am335x-chiliboard.dts         |  20 +-
 arch/arm/boot/dts/am335x-chilisom.dtsi          |  94 ++-
 arch/arm/boot/dts/am335x-cm-t335.dts            | 396 ++++++++++
 arch/arm/boot/dts/am335x-evm.dts                | 233 +++---
 arch/arm/boot/dts/am335x-evmsk.dts              | 280 +++----
 arch/arm/boot/dts/am335x-lxm.dts                | 120 +--
 arch/arm/boot/dts/am335x-nano.dts               | 154 ++--
 arch/arm/boot/dts/am335x-pepper.dts             | 231 +++---
 arch/arm/boot/dts/am335x-phycore-som.dtsi       |  60 +-
 arch/arm/boot/dts/am335x-sbc-t335.dts           | 219 ++++++
 arch/arm/boot/dts/am335x-shc.dts                | 577 ++++++++++++++
 arch/arm/boot/dts/am335x-sl50.dts               |  13 +-
 arch/arm/boot/dts/am335x-wega.dtsi              |  58 +-
 arch/arm/boot/dts/am33xx.dtsi                   |  96 ++-
 arch/arm/boot/dts/am3517-craneboard.dts         |   2 +-
 arch/arm/boot/dts/am4372.dtsi                   |  87 +-
 arch/arm/boot/dts/am437x-cm-t43.dts             | 422 ++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts             | 389 +++++----
 arch/arm/boot/dts/am437x-idk-evm.dts            | 128 +--
 arch/arm/boot/dts/am437x-sbc-t43.dts            | 180 +++++
 arch/arm/boot/dts/am437x-sk-evm.dts             | 298 +++----
 arch/arm/boot/dts/am43x-epos-evm.dts            | 246 +++---
 arch/arm/boot/dts/am57xx-beagle-x15.dts         | 198 ++---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts       | 617 +++++++++++++++
 arch/arm/boot/dts/am57xx-sbc-am57x.dts          | 179 +++++
 arch/arm/boot/dts/arm-realview-pb11mp.dts       | 681 ++++++++++++++++
 arch/arm/boot/dts/armada-370-netgear-rn102.dts  |   2 +-
 arch/arm/boot/dts/armada-370-netgear-rn104.dts  |   2 +-
 arch/arm/boot/dts/armada-388-clearfog.dts       | 456 +++++++++++
 arch/arm/boot/dts/armada-388-gp.dts             |  10 -
 .../boot/dts/armada-38x-solidrun-microsom.dtsi  | 115 +++
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts |  72 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts  |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |  21 +
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi       | 127 +++
 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts     | 170 ++++
 arch/arm/boot/dts/at91-vinco.dts                | 256 ++++++
 arch/arm/boot/dts/bcm-cygnus.dtsi               | 101 ++-
 arch/arm/boot/dts/bcm-nsp.dtsi                  | 232 +++++-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts        |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts        |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts        |   1 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |   1 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |   2 -
 arch/arm/boot/dts/bcm2835.dtsi                  | 194 +----
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts           |  35 +
 arch/arm/boot/dts/bcm2836.dtsi                  |  78 ++
 arch/arm/boot/dts/bcm283x.dtsi                  | 212 +++++
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts     |  30 +
 arch/arm/boot/dts/bcm5301x.dtsi                 |  92 ++-
 arch/arm/boot/dts/bcm63138.dtsi                 |  36 +-
 arch/arm/boot/dts/bcm94708.dts                  |  56 ++
 arch/arm/boot/dts/bcm94709.dts                  |  56 ++
 arch/arm/boot/dts/bcm953012k.dts                |  63 ++
 arch/arm/boot/dts/bcm958625k.dts                |  59 ++
 arch/arm/boot/dts/berlin2.dtsi                  |  23 +
 arch/arm/boot/dts/berlin2cd.dtsi                |  23 +
 arch/arm/boot/dts/berlin2q-marvell-dmp.dts      |  38 +-
 arch/arm/boot/dts/berlin2q.dtsi                 |  34 +-
 arch/arm/boot/dts/compulab-sb-som.dtsi          |  49 ++
 arch/arm/boot/dts/da850-enbw-cmc.dts            |   8 +
 arch/arm/boot/dts/da850-evm.dts                 |   8 +
 arch/arm/boot/dts/da850.dtsi                    |  58 +-
 arch/arm/boot/dts/dm8148-evm.dts                |  55 ++
 arch/arm/boot/dts/dm8148-t410.dts               |  70 ++
 arch/arm/boot/dts/dm814x.dtsi                   | 226 +++++-
 arch/arm/boot/dts/dm816x.dtsi                   |  14 +-
 arch/arm/boot/dts/dove-cubox.dts                |   8 +
 arch/arm/boot/dts/dove.dtsi                     |  22 +
 arch/arm/boot/dts/dra62x-clocks.dtsi            |  23 +
 arch/arm/boot/dts/dra62x-j5eco-evm.dts          |  80 ++
 arch/arm/boot/dts/dra62x.dtsi                   |  23 +
 arch/arm/boot/dts/dra7-evm.dts                  | 255 +++---
 arch/arm/boot/dts/dra7.dtsi                     |   7 +-
 arch/arm/boot/dts/dra72-evm.dts                 | 204 ++---
 arch/arm/boot/dts/ea3250.dts                    |  41 +-
 arch/arm/boot/dts/exynos4.dtsi                  |  18 +-
 arch/arm/boot/dts/exynos4210-origen.dts         |   4 -
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |   4 -
 arch/arm/boot/dts/exynos4210-universal_c210.dts |   8 +
 arch/arm/boot/dts/exynos4210.dtsi               |  14 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 -
 arch/arm/boot/dts/exynos4412-odroidu3.dts       |   1 -
 arch/arm/boot/dts/exynos4412-origen.dts         |   4 -
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |   4 -
 arch/arm/boot/dts/exynos4412-trats2.dts         |   4 +
 arch/arm/boot/dts/exynos4x12.dtsi               |   5 +-
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   |   6 +-
 arch/arm/boot/dts/exynos5250.dtsi               |   9 +
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |   5 +-
 arch/arm/boot/dts/exynos5420.dtsi               |  19 +
 .../boot/dts/exynos5422-odroidxu3-common.dtsi   |   5 -
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts |   2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3.dts      |   2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   5 +-
 arch/arm/boot/dts/imx25-pinfunc.h               |   3 +
 arch/arm/boot/dts/imx25.dtsi                    |   4 +
 arch/arm/boot/dts/imx28-cfa10057.dts            |   4 +-
 arch/arm/boot/dts/imx28.dtsi                    |  11 +
 arch/arm/boot/dts/imx51-ts4800.dts              | 302 +++++++
 arch/arm/boot/dts/imx6dl.dtsi                   |   7 +-
 arch/arm/boot/dts/imx6q-novena.dts              | 785 +++++++++++++++++++
 arch/arm/boot/dts/imx6q.dtsi                    |  52 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi           |  36 +
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi           |  48 ++
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi           |  33 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi           |  47 +-
 arch/arm/boot/dts/imx6qdl-gw551x.dtsi           |  24 +
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi           |  24 +
 arch/arm/boot/dts/imx6qdl.dtsi                  |  61 +-
 arch/arm/boot/dts/imx6sl.dtsi                   |  11 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |  19 +-
 arch/arm/boot/dts/imx6ul.dtsi                   |  18 +
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts         | 286 +++++++
 arch/arm/boot/dts/imx7d-sbc-imx7.dts            |  42 +
 arch/arm/boot/dts/imx7d-sdb.dts                 |  10 +
 arch/arm/boot/dts/imx7d.dtsi                    |  22 +-
 arch/arm/boot/dts/kirkwood-nsa325.dts           | 238 ++++++
 .../arm/boot/dts/kirkwood-pogoplug-series-4.dts | 178 +++++
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts    | 155 +++-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi      |  44 ++
 arch/arm/boot/dts/lpc18xx.dtsi                  |  11 +
 arch/arm/boot/dts/lpc32xx.dtsi                  | 142 +++-
 arch/arm/boot/dts/lpc4337-ciaa.dts              |  34 +
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts     |   5 +
 arch/arm/boot/dts/lpc4357.dtsi                  |   4 +
 arch/arm/boot/dts/ls1021a-qds.dts               |   4 +
 arch/arm/boot/dts/ls1021a-twr.dts               |  13 +
 arch/arm/boot/dts/ls1021a.dtsi                  |  21 +
 arch/arm/boot/dts/meson8b-odroidc1.dts          |  11 +
 arch/arm/boot/dts/meson8b.dtsi                  |   6 +
 arch/arm/boot/dts/mt2701-evb.dts                |  29 +
 arch/arm/boot/dts/mt2701.dtsi                   | 146 ++++
 arch/arm/boot/dts/mt8135.dtsi                   |   2 +-
 arch/arm/boot/dts/omap3-beagle-xm.dts           |  20 +-
 arch/arm/boot/dts/omap3-beagle.dts              |  66 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi             |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi  |   2 +-
 .../boot/dts/omap3-devkit8000-lcd-common.dtsi   |   2 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts            |  54 +-
 arch/arm/boot/dts/omap3-gta04.dtsi              |   2 +-
 arch/arm/boot/dts/omap3-igep0020.dts            |  24 +-
 arch/arm/boot/dts/omap3-igep0030.dts            |  24 +-
 arch/arm/boot/dts/omap3-ldp.dts                 |  60 +-
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi         |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                | 116 +--
 arch/arm/boot/dts/omap3-n950-n9.dtsi            |  12 +-
 .../arm/boot/dts/omap3-overo-alto35-common.dtsi |   2 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi |   4 +-
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi |   2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi |   2 +-
 .../boot/dts/omap3-overo-gallop43-common.dtsi   |   4 +-
 .../arm/boot/dts/omap3-overo-palo35-common.dtsi |   4 +-
 .../arm/boot/dts/omap3-overo-palo43-common.dtsi |   4 +-
 arch/arm/boot/dts/omap3-pandora-common.dtsi     |  34 +-
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts               |  60 +-
 arch/arm/boot/dts/omap3.dtsi                    |   2 +
 arch/arm/boot/dts/omap4-duovero-parlor.dts      |   2 +-
 arch/arm/boot/dts/omap4-panda-a4.dts            |   6 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi       | 164 ++--
 arch/arm/boot/dts/omap4-panda-es.dts            |  10 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts        |   6 +-
 arch/arm/boot/dts/omap4-sdp.dts                 | 110 +--
 .../arm/boot/dts/omap4-var-om44customboard.dtsi |   2 +-
 arch/arm/boot/dts/omap4.dtsi                    |  10 +
 arch/arm/boot/dts/omap5-board-common.dtsi       |  94 +--
 arch/arm/boot/dts/omap5-cm-t54.dts              |   4 +-
 arch/arm/boot/dts/omap5-uevm.dts                |   4 +-
 arch/arm/boot/dts/omap5.dtsi                    |   2 +
 arch/arm/boot/dts/phy3250.dts                   |  41 +-
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts     |  16 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts      |  22 +-
 .../boot/dts/qcom-apq8064-sony-xperia-yuga.dts  | 436 ++++++++++
 arch/arm/boot/dts/qcom-apq8064.dtsi             | 130 ++-
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts  |   2 +
 arch/arm/boot/dts/qcom-apq8084-ifc6540.dts      |   3 +-
 arch/arm/boot/dts/qcom-apq8084-mtp.dts          |   1 +
 arch/arm/boot/dts/qcom-apq8084.dtsi             | 108 +++
 arch/arm/boot/dts/qcom-msm8960.dtsi             |  23 +
 .../dts/qcom-msm8974-sony-xperia-honami.dts     | 382 +++++++++
 arch/arm/boot/dts/qcom-msm8974.dtsi             |  11 +
 arch/arm/boot/dts/qcom-pm8841.dtsi              |  10 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi              |  21 +-
 arch/arm/boot/dts/qcom-pma8084.dtsi             |  12 +-
 arch/arm/boot/dts/r8a73a4-ape6evm.dts           |   4 +-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |   2 +-
 arch/arm/boot/dts/r8a7740.dtsi                  |  13 +
 arch/arm/boot/dts/r8a7778-bockw.dts             |  33 +-
 arch/arm/boot/dts/r8a7778.dtsi                  |   7 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |  56 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |  32 +-
 arch/arm/boot/dts/r8a7791-henninger.dts         | 320 --------
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  60 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |  56 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  65 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |  77 +-
 arch/arm/boot/dts/r8a7793.dtsi                  | 534 +++++++++++++
 arch/arm/boot/dts/r8a7794-alt.dts               | 140 +++-
 arch/arm/boot/dts/r8a7794-silk.dts              |  76 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |  68 +-
 arch/arm/boot/dts/rk3036-evb.dts                |  64 ++
 arch/arm/boot/dts/rk3036-kylin.dts              | 300 +++++++
 arch/arm/boot/dts/rk3036.dtsi                   | 622 +++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                  |  19 +
 arch/arm/boot/dts/rk3188.dtsi                   |  15 +
 arch/arm/boot/dts/rk3228-evb.dts                |  66 ++
 arch/arm/boot/dts/rk3228.dtsi                   | 442 +++++++++++
 arch/arm/boot/dts/rk3288-evb-act8846.dts        |  44 +-
 arch/arm/boot/dts/rk3288-evb-rk808.dts          |  27 -
 arch/arm/boot/dts/rk3288-evb.dtsi               |  37 +-
 arch/arm/boot/dts/rk3288-r89.dts                |  13 +
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |   1 +
 arch/arm/boot/dts/rk3288-rock2-square.dts       |  13 +
 arch/arm/boot/dts/rk3288-thermal.dtsi           |  14 +-
 arch/arm/boot/dts/rk3288-veyron-brain.dts       | 139 ++++
 arch/arm/boot/dts/rk3288-veyron-mickey.dts      | 250 ++++++
 arch/arm/boot/dts/rk3288-veyron-minnie.dts      |  12 +
 arch/arm/boot/dts/rk3288-veyron-speedy.dts      |   8 +
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   5 +
 arch/arm/boot/dts/rk3288.dtsi                   |  30 +-
 arch/arm/boot/dts/rk3xxx.dtsi                   |   1 +
 arch/arm/boot/dts/sama5d2.dtsi                  |  31 +
 arch/arm/boot/dts/sama5d4.dtsi                  |  26 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts              |   2 +-
 arch/arm/boot/dts/sh73a0.dtsi                   |  86 +-
 arch/arm/boot/dts/socfpga.dtsi                  |   1 +
 arch/arm/boot/dts/socfpga_arria5_socdk.dts      |   1 +
 .../boot/dts/socfpga_cyclone5_de0_sockit.dts    |   1 +
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi     |  34 +
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts   |  94 +++
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts    |   1 +
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   |   1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |  33 -
 arch/arm/boot/dts/ste-href-stuib.dtsi           |  23 +
 arch/arm/boot/dts/ste-href-tvk1281618.dtsi      |  52 +-
 arch/arm/boot/dts/ste-hrefv60plus.dtsi          |  18 -
 arch/arm/boot/dts/ste-nomadik-s8815.dts         |   2 +-
 arch/arm/boot/dts/ste-snowball.dts              |   7 +-
 arch/arm/boot/dts/ste-u300.dts                  |  10 -
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts        |  54 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts           |  48 ++
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts    | 164 ++++
 arch/arm/boot/dts/sun4i-a10-mk802.dts           |   4 +
 .../arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |  61 ++
 arch/arm/boot/dts/sun4i-a10.dtsi                |  45 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts    |  14 +
 .../dts/sun5i-a13-empire-electronix-d709.dts    | 241 ++++++
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts        |  30 +
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts  |  85 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |   4 +
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts     | 169 ++++
 arch/arm/boot/dts/sun7i-a20-mk808c.dts          |   4 +
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  |  77 ++
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts   |   4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts   |   4 +
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |   4 +
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts  |  57 ++
 .../arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts |  12 +
 arch/arm/boot/dts/sun7i-a20.dtsi                |  41 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   2 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts    |  77 ++
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 497 ++++++++++++
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |  30 +
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |  24 +-
 arch/arm/boot/dts/sun9i-a80.dtsi                | 159 +++-
 arch/arm/boot/dts/tango4-common.dtsi            | 130 +++
 arch/arm/boot/dts/tango4-smp8758.dtsi           |  31 +
 arch/arm/boot/dts/tango4-vantage-1172.dts       |  37 +
 arch/arm/boot/dts/tps65217.dtsi                 |  56 --
 arch/arm/boot/dts/twl4030_omap3.dtsi            |   2 +-
 arch/arm/boot/dts/twl6030_omap4.dtsi            |   4 +-
 arch/arm/boot/dts/uniphier-common32.dtsi        | 135 ++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi         | 265 +++----
 arch/arm/boot/dts/uniphier-ph1-ld6b.dtsi        |   2 +-
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi        | 288 +++----
 arch/arm/boot/dts/uniphier-ph1-pro5.dtsi        | 274 +++----
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi        | 266 +++----
 arch/arm/boot/dts/uniphier-proxstream2.dtsi     | 269 +++----
 arch/arm/boot/dts/versatile-ab.dts              |  62 +-
 arch/arm/boot/dts/vf-colibri.dtsi               |  26 +
 arch/arm/boot/dts/vf610m4-cosmic.dts            |  90 +++
 arch/arm/boot/dts/vfxxx.dtsi                    |  24 +
 arch/arm/boot/dts/wm8505.dtsi                   |   4 +-
 arch/arm/boot/dts/zynq-7000.dtsi                |   8 +-
 arch/arm/boot/dts/zynq-zc702.dts                |   4 +-
 arch/arm/mach-mediatek/mediatek.c               |   1 +
 arch/arm/mach-omap2/pdata-quirks.c              |  24 +-
 arch/arm64/boot/dts/mediatek/mt8173.dtsi        |   2 +-
 drivers/clk/samsung/clk-exynos4.c               |   1 +
 include/dt-bindings/clock/exynos4.h             |   1 +
 include/dt-bindings/clock/r8a7791-clock.h       |   1 +
 include/dt-bindings/clock/r8a7794-clock.h       |   1 +
 include/dt-bindings/clock/sh73a0-clock.h        |   6 +-
 include/dt-bindings/pinctrl/am43xx.h            |   6 +
 include/dt-bindings/pinctrl/dm814x.h            |  48 ++
 include/dt-bindings/pinctrl/dra.h               |   6 +
 include/dt-bindings/pinctrl/omap.h              |   3 +-
 .../{reset-controller => reset}/mt8135-resets.h |   0
 .../{reset-controller => reset}/mt8173-resets.h |   0
 333 files changed, 19552 insertions(+), 4367 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bcm/brcm,nsp-cpu-method.txt
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/arm/technologic.txt
 create mode 100644 Documentation/devicetree/bindings/clock/arm-syscon-icst.txt
 create mode 100644 Documentation/devicetree/bindings/clock/dove-divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
 create mode 100644 Documentation/devicetree/bindings/soc/dove/pmu.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smp2p.txt
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,smsm.txt
 rename Documentation/devicetree/bindings/watchdog/{meson6-wdt.txt => meson-wdt.txt} (75%)
 create mode 100644 arch/arm/boot/dts/am335x-cm-t335.dts
 create mode 100644 arch/arm/boot/dts/am335x-sbc-t335.dts
 create mode 100644 arch/arm/boot/dts/am335x-shc.dts
 create mode 100644 arch/arm/boot/dts/am437x-cm-t43.dts
 create mode 100644 arch/arm/boot/dts/am437x-sbc-t43.dts
 create mode 100644 arch/arm/boot/dts/am57xx-cl-som-am57x.dts
 create mode 100644 arch/arm/boot/dts/am57xx-sbc-am57x.dts
 create mode 100644 arch/arm/boot/dts/arm-realview-pb11mp.dts
 create mode 100644 arch/arm/boot/dts/armada-388-clearfog.dts
 create mode 100644 arch/arm/boot/dts/armada-38x-solidrun-microsom.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
 create mode 100644 arch/arm/boot/dts/at91-vinco.dts
 create mode 100644 arch/arm/boot/dts/bcm2836-rpi-2-b.dts
 create mode 100644 arch/arm/boot/dts/bcm2836.dtsi
 create mode 100644 arch/arm/boot/dts/bcm283x.dtsi
 create mode 100644 arch/arm/boot/dts/bcm94708.dts
 create mode 100644 arch/arm/boot/dts/bcm94709.dts
 create mode 100644 arch/arm/boot/dts/bcm953012k.dts
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi
 create mode 100644 arch/arm/boot/dts/dra62x-clocks.dtsi
 create mode 100644 arch/arm/boot/dts/dra62x-j5eco-evm.dts
 create mode 100644 arch/arm/boot/dts/dra62x.dtsi
 create mode 100644 arch/arm/boot/dts/imx51-ts4800.dts
 create mode 100644 arch/arm/boot/dts/imx6q-novena.dts
 create mode 100644 arch/arm/boot/dts/imx7d-cl-som-imx7.dts
 create mode 100644 arch/arm/boot/dts/imx7d-sbc-imx7.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa325.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-pogoplug-series-4.dts
 create mode 100644 arch/arm/boot/dts/mt2701-evb.dts
 create mode 100644 arch/arm/boot/dts/mt2701.dtsi
 create mode 100644 arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
 delete mode 100644 arch/arm/boot/dts/r8a7791-henninger.dts
 create mode 100644 arch/arm/boot/dts/rk3036-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3036-kylin.dts
 create mode 100644 arch/arm/boot/dts/rk3036.dtsi
 create mode 100644 arch/arm/boot/dts/rk3228-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3228.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-brain.dts
 create mode 100644 arch/arm/boot/dts/rk3288-veyron-mickey.dts
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts
 create mode 100644 arch/arm/boot/dts/sun5i-a13-empire-electronix-d709.dts
 create mode 100644 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-common.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-smp8758.dtsi
 create mode 100644 arch/arm/boot/dts/tango4-vantage-1172.dts
 delete mode 100644 arch/arm/boot/dts/tps65217.dtsi
 create mode 100644 arch/arm/boot/dts/uniphier-common32.dtsi
 create mode 100644 arch/arm/boot/dts/vf610m4-cosmic.dts
 create mode 100644 include/dt-bindings/pinctrl/dm814x.h
 rename include/dt-bindings/{reset-controller => reset}/mt8135-resets.h (100%)
 rename include/dt-bindings/{reset-controller => reset}/mt8173-resets.h (100%)
