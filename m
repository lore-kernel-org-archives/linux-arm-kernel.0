From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 4 Jul 2017 16:22:59 +0200
Subject: [GIT PULL 3/7] ARM: Device-tree updates
Message-ID: <CAK8P3a3DUPCMEf3h7b77QGsEcORK0cPSwJNbNRZd=H2f8MJyEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5ed02dbb497422bf225783f46e6eadd237d23d6b:

  Linux 4.12-rc3 (2017-05-28 17:20:53 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to 0c6cda5839b8b65d1d04cbf5c310735459f7bc60:

  Merge tag 'actions-arm-dt-for-4.13' of
git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions
into next/dt (2017-06-29 17:09:58 +0200)

----------------------------------------------------------------
ARM: Device-tree updates

Device-tree continues to see lots of updates. The majority of patches
here are smaller changes for new hardware on existing platforms, and
there are a few larger changes worth pointing out.

New machines:

- The new Action Semi S500 platform is added along with initial
  support for the LeMaker Guitar board.

- STM32 gains support for three new boards: stm32h743-disco,
  stm32f746-disco, and stm32f769-disco, along with new device
  support for the existing stm32f429 boards.

- Renesas adds two new boards, the tiny GR-Peach based on RZ/A1H
  with 10MB on-chip SRAM, and the iWave G20D-Q7 System-on-Module
  plus board.

- On Marvell "mvebu", we gain support for the Linksys WRT3200ACM
  wireless router.

- For NXP i.MX, we gain support for the Gateworks Ventana GW5600
  and the Technexion Pico i.MX7D single-board computers.

- The BeagleBone Blue is added for OMAP, it's the latest variation
  of the popular Beaglebone Black single-board computer.

- The Allwinner based Lichee Pi Zero and NanoPi M1 Plus boards
  are added, these are the latest variations of a seemingly endless
  supply of similar single-board computers.

Other updates:

- Linus Walleij improves support for the "Faraday" based SoC platforms
  from various SoC makers (Moxart, Aspeed, Gemini)

- The ARM Mali GPU is now describe on Rockchips SoCs

- Mediatek MT7623 is extended significantly, making it much
  more useful.

- Lots of individual updates on Renesas, OMAP, Rockchips, Broadcom,
  Allwinner, Qualcomm, iMX

- For Amlogic, the clock support is extended a lot on meson8b.

- We now build the devicetree file for the Raspberry Pi 3 on 32-bit
  ARM, in addition to the existing ARM64 support, to help users
  wanting to run a 32-bit system on it.

----------------------------------------------------------------
Alexandre Bailon (1):
      ARM: dts: da850: Add CPPI 4.1 DMA to USB OTG controller

Alexandre Belloni (4):
      ARM: dts: imx6qdl-nitrogen6_max: fix rv4162 compatible
      ARM: dts: imx6qdl-nitrogen6_som2: fix rv4162 compatible
      ARM: dts: imx7d-nitrogen7: fix rv4162 compatible
      ARM: dts: am335x-phycore-som: fix rv4162 compatible

Alexandre TORGUE (1):
      ARM: dts: stm32: Set gpio controller as interrupt controller on F4 and F7

Andreas F?rber (8):
      dt-bindings: Add vendor prefix for Actions Semi
      dt-bindings: arm: Document Actions Semi S500
      dt-bindings: timer: Document Owl timer
      dt-bindings: arm: Document Actions Semi S900
      ARM: dts: Add Actions Semi S500 and LeMaker Guitar
      dt-bindings: arm: cpus: Add S500 enable-method
      ARM: dts: owl-s500: Set CPU enable-method
      ARM: dts: owl-s500: Add SPS node

Andrew Lunn (3):
      ARM: dts: vf610-zii: Add switch eeprom-length properties
      ARM: dts: mvebu: Add PWM properties to .dtsi files
      ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan

Andrey Smirnov (6):
      ARM: dts: imx: Reintroduce 'anatop-enable-bit' where appropriate
      ARM: dts: imx7s: Add node for GPC
      ARM: dts: imx7s: Mark 'gpr' compatible with i.MX6 variant
      ARM: dts: imx7d-sdb: Add GPIO expander node
      ARM: dts: imx7d: Add node for PCIe controller
      ARM: dts: imx7d-sdb: Enable PCIe peripheral

Andy Yan (2):
      ARM: dts: rockchip: rename core dtsi from RK1108 to RV1108
      ARM: dts: rockchip: rename RK1108-evb to RV1108-evb

Antoine Tenart (2):
      ARM: sun5i: add a cryptographic engine node
      ARM: dts: sunxi: add SoC specific compatibles for the crypto nodes

Arnd Bergmann (5):
      Merge tag 'samsung-dt-4.13-2' of
git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'pxa-dt-4.13' of https://github.com/rjarzmik/linux into next/dt
      Merge tag 'socfpga_dts_for_v4.13' of
git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'amlogic-dt-2' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'actions-arm-dt-for-4.13' of
git://git.kernel.org/.../afaerber/linux-actions into next/dt

Baruch Siach (1):
      ARM: dts: at91: sama5d2_xplained: remove wrong memory node

Biju Das (4):
      ARM: dts: iwg20m: Add iWave RZG1M Qseven SOM
      ARM: dts: iwg20d-q7: Add support for iWave G20D-Q7 board based on RZ/G1M
      ARM: shmobile: document iW-RainboW-G20M-Qseven-RZG1M system on module
      ARM: shmobile: document iW-RainboW-G20D-Qseven-RZG1M board

Bird, Tim (1):
      ARM: dts: qcom: add charger otg regulator

Boris Brezillon (4):
      dt-bindings: mtd: atmel-nand: Document the nfc-io bindings
      ARM: dts: at91: Declare EBI/NAND controllers
      ARM: dts: at91: Switch to the new NAND bindings
      ARM: dts: at91: Add the NOR flash available on sama5d3 dev kits

Carlo Caione (1):
      ARM: dts: meson: Extend L2 cache controller node for Meson8 and Meson8b

Chen-Yu Tsai (28):
      ARM: sun8i: a83t: Drop skeleton.dtsi
      ARM: sun8i: a83t: Rename pinmux setting names
      ARM: sunxi: common-regulators: Drop pinmux settings for GPIO pins
      ARM: sunxi: Drop mmc0_cd_pin_reference_design pinmux setting
      ARM: sun8i: h3: orangepi-pc: Enable USB OTG
      ARM: sun8i: h3: bananapi-m2-plus: Enable USB OTG
      ARM: dts: sun6i: Add second display pipeline device nodes
      ARM: dts: sun6i: Enable tcon0 by default
      ARM: sun8i: a83t: Drop leading zeroes from device node addresses
      ARM: sun8i: a83t: Replace underscores with hyphens in pinmux node names
      ARM: sun8i: a83t: Add CCU device nodes
      ARM: sun8i: a83t: Set clock accuracy for 24MHz oscillator
      ARM: sun8i: a83t: Add device node for DMA controller
      ARM: sun8i: a83t: Add device node for SPDIF transmitter
      ARM: sun8i: a83t: cubietruck-plus: Add LED device nodes
      ARM: sun8i: a83t: cubietruck-plus: Enable SPDIF output
      ARM: sun7i: a20: cubieboard2: Move usb_otg node for alphabetical ordering
      ARM: sun7i: a20: cubieboard2: Enable AXP209's ACIN power supply
      ARM: sun7i: a20: bananapi-m1-plus: Enable AXP209's ACIN power supply
      ARM: sun4i: a10: cubieboard: Enable AXP209's ACIN power supply
      ARM: sun6i: a31: hummingbird: Enable AXP221's ACIN power supply
      ARM: sun7i: a20: cubietruck: Tie AXP209's USB power supply to USB PHY
      ARM: sun8i: a83t: Add device node for PRCM
      ARM: sunxi: h3-h5: Convert R_CCU raw numbers to macros
      ARM: sun8i: a83t: Add device node for R_PIO
      ARM: sun8i: h3: Enable EMAC with external PHY on Orange Pi Plus 2E
      ARM: sun6i: a31s: primo81: Change USB OTG to OTG mode
      ARM: sun6i: a31s: primo81: Enable battery power supply

Chris Brandt (3):
      ARM: dts: r7s72100: add USB bit definitions
      ARM: dts: r7s72100: add usb clocks to device tree
      ARM: dts: r7s72100: add clock bit definitions

Chris Packham (2):
      ARM: dts: mvebu: add missing interrupt to 98dx4251 switch
      ARM: dts: mvebu: disable the rtc on 98dx3236 SoC

Christian Lamparter (1):
      ARM: dts: qcom: ipq4019: fix i2c_0 node

Christopher Spinrath (1):
      ARM: dts: imx6q-cm-fx6: add sdio wifi/bt nodes

Claudiu Beznea (1):
      ARM: dts: at91: sama5d2_xplained: add pwm controller

Corentin Labbe (11):
      arm: sun8i: sunxi-h3-h5: Add dt node for the syscon control module
      arm: sun8i: sunxi-h3-h5: add dwmac-sun8i ethernet driver
      arm: sun8i: orangepi-pc: Enable dwmac-sun8i
      arm: sun8i: orangepi-one: Enable dwmac-sun8i
      arm: sun8i: orangepi-2: Enable dwmac-sun8i
      arm: sun8i: orangepi-pc-plus: Set EMAC activity LEDs to active high
      arm: sun8i: nanopi-neo: Enable dwmac-sun8i
      ARM: sun8i: orangepi-plus: Enable dwmac-sun8i
      ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i
      arm: sun8i: orangepi-zero: Enable dwmac-sun8i
      ARM: sun8i: a83t: Add dt node for the syscon control module

Cosar Dindar (3):
      ARM: dts: stm32: Add CRC support to stm32f429
      ARM: dts: stm32: enable CRC32 on stm32429-disco board
      ARM: dts: stm32: enable CRC32 on stm32429i-eval board

David Lechner (1):
      ARM: dts: da850-lego-ev3: Add node for LEGO MINDSTORMS EV3 Battery

Dinh Nguyen (1):
      ARM: dts: socfpga: set the i2c frequency

Eddie Cai (1):
      clk: rockchip: add ids for camera on rk3399

Elaine Zhang (2):
      clk: rockchip: add clock-ids for more rk3228 clocks
      ARM: dts: rockchip: set default rates for core clocks on rk322x

Enric Balletbo i Serra (1):
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-veyron

Eric Anholt (3):
      ARM: dts: Add devicetree for the Raspberry Pi 3, for arm32 (v6)
      ARM: dts: Cygnus: Add BCM11360's V3D device
      ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY

Fabio Estevam (17):
      ARM: dts: imx6qdl-wandboard: Fix audio channel swap
      ARM: dts: imx6qdl-colibri: Fix audio channel swap
      ARM: dts: imx6sx-sdb: Properly model the ARM and SOC regulator supplies
      ARM: dts: omap3: Remove 'enable-active-low' property
      ARM: dts: imx7s-warp: Pass 'no-1-8-v' property to the eMMC
      ARM: dts: imx6: Fix BCM43xx node name
      ARM: dts: sunxi: Fix BCM43xx node name
      ARM: dts: imx7d-pico: Add watchdog support
      ARM: dts: imx7d-pico: Pass 'no-1-8-v' property to the eMMC
      ARM: dts: imx23-sansa: Remove 'enable-active-low' property
      ARM: dts: tx6: Remove 'enable-active-low' property
      ARM: dts: imx7: Fix typo in watchdog pin name
      ARM: dts: imx: Fix Ethernet PHY reset polarity
      ARM: dts: imx7d-sdb: Adjust the regulator nodes
      ARM: dts: imx7d-sdb: Add Wifi support
      ARM: dts: imx7d-sdb: Add Bluetooth support
      ARM: dts: imx6: Fix PCI GPIO reset polarity

Finley Xiao (1):
      ARM: dts: rockchip: add operating-points-v2 for cpu on rk322x

Florian Fainelli (2):
      Merge tag 'bcm2835-dt-next-2017-03-30' into devicetree/next
      Merge tag 'bcm2835-dt-next-2017-06-12' into devicetree/next

Frank Wang (3):
      ARM: dts: rockchip: add watchdog device node on rk322x
      ARM: dts: rockchip: correct rk322x uart2 pinctrl
      ARM: dts: rockchip: add second uart2 pinctrl on rk322x

Franklin S Cooper Jr (4):
      ARM: dts: keystone-k2g: Remove skeleton.dtsi
      ARM: dts: k2g-evm: Add unit address to memory node
      ARM: keystone: Create new binding for K2G ICE evm
      ARM: dts: keystone: Add minimum support for K2G ICE evm

Garlic Tseng (1):
      arm: dts: mediatek: Add audio driver node for MT2701

Geert Uytterhoeven (2):
      ARM: shmobile: Update R-Car Gen3 ULCB board part numbers
      ARM: shmobile: Document Renesas H3-based Salvator-XS board DT bindings

Gerd Hoffmann (1):
      ARM: dts: bcm283x: switch from &sdhci to &sdhost

Guillaume Tucker (4):
      dt-bindings: gpu: add bindings for the ARM Mali Midgard GPU
      ARM: dts: rockchip: add ARM Mali GPU node for rk3288
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-rock2-som
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-firefly

Guochun Mao (1):
      arm: dts: mt2701: add nor flash node

H. Nikolaus Schaller (1):
      ARM: dts: OMAP5: uevm: add ?SD card detect

Hans Verkuil (1):
      ARM: dts: exynos: add needs-hpd to &hdmicec for Odroid-U3

Heiko Stuebner (1):
      Merge branch 'v4.13-shared/clkids' into v4.13-armsoc/dts32

Helmut Klein (1):
      clk: meson-gxbb: expose UART clocks

Hoegeun Kwon (1):
      ARM: dts: exynos: Fix polarity of panel reset gpio in Rinato

Hugues Fruchet (4):
      ARM: dts: stm32: Enable DCMI support on STM32F429 MCU
      ARM: dts: stm32: Enable DCMI camera interface on STM32F429-EVAL board
      ARM: dts: stm32: Enable STMPE1600 gpio expander of STM32F429-EVAL board
      ARM: dts: stm32: Enable OV2640 camera support of STM32F429-EVAL board

Icenowy Zheng (6):
      ARM: sun8i: v3s: restore the usage of CCU definitions
      ARM: sun8i: v3s: add LRADC device node
      ARM: sun8i: v3s: add pinmux for mmc1
      ARM: sun8i: v3s: add support for Lichee Pi Zero w/ dock board
      ARM: sun8i: v3s: enable SPI
      ARM: sun8i: v3s: add device nodes for DE2 display pipeline

Jacopo Mondi (2):
      ARM: dts: r7s72100: add Renesas RZ/A1 pinctrl header
      ARM: dts: r7s72100: Add support for GR-Peach

Jagan Teki (1):
      ARM: dts: sun8i: h3: Add initial NanoPi M1 Plus support

Javier Martinez Canillas (5):
      ARM: dts: at91: Add generic compatible string for I2C EEPROM
      ARM: dts: imx: Add generic compatible string for I2C EEPROM
      ARM: dts: omap: Add generic compatible string for I2C EEPROM
      ARM: dts: uniphier: Add generic compatible string for I2C EEPROM
      ARM: dts: turris-omnia: Add generic compatible string for I2C EEPROM

Jerome Brunet (3):
      clk: meson-gxbb: expose spdif clock gates
      clk: meson-gxbb: expose i2s master clock
      clk: meson-gxbb: expose spdif master clock

John Crispin (9):
      arm: dts: mt7623: add clock controller device nodes
      arm: dts: mt7623: add subsystem clock controller device nodes
      arm: dts: mt7623: add power domain controller device node
      arm: dts: mt7623: add pinctrl nodes to the mt7623 dtsi file
      arm: dts: mt7623: add pmic wrapper nodes to the mt7623 dtsi file
      arm: dts: mt7623: add i2c nodes to the mt7623.dtsi file
      arm: dts: mt7623: add nand nodes to the mt7623.dtsi file
      arm: dts: mt7623: add mmc nodes to the mt7623.dtsi file
      arm: dts: mt7623: add usb nodes to the mt7623.dtsi file

Jon Mason (1):
      ARM: dts: NSP: Add Thermal Support

Jun Gao (1):
      arm: dts: Add Mediatek MT2701 i2c device node

Keerthy (2):
      ARM: dts: da850: Add interrupt-controller property to gpio node
      ARM: dts: AM43XX: Remove min and max voltage values for dcdc3

Kevin Hilman (2):
      ARM: dts: da850-evm: fix tca6416 for use with GPIO hogs
      Merge tag 'meson-clk-headers-for-4.13-2' of
git://github.com/BayLibre/clk-meson into v4.13/dt

Krzysztof Kozlowski (2):
      ARM: dts: exynos: Use human-friendly symbols for interrupt flags
in board sources
      ARM: dts: exynos: Use human-friendly symbols for GIC interrupt properties

Laurent Pinchart (1):
      ARM: dts: renesas: Switch to panel-lvds bindings for Mitsubishi panels

Linus Walleij (10):
      dt-bindings: Augment Gemini for clocks, resets
      ARM: dts: Add the Gemini reset controller
      ARM: dts: Add clocks to the Gemini SoC
      ARM: dts: augment Moxa and Aspeed DTS for FTTMR010
      ARM: dts: add XOADC and IIO HWMON to MSM8660/APQ8060
      ARM: dts: Qualcomm APQ8060 DragonBoard ALS sensor
      ARM: dts: add GSBI8 defines to the MSM8660 family
      ARM: dts: add core I2C devices to the APQ8060 Dragonboard
      ARM: dts: Add Gemini DMA controller
      ARM: dts: add Gemini PATA/SATA support

Lionel Debieve (1):
      ARM: dts: stm32: Add missing reset-cells node in stm32f746

Lucas Stach (2):
      ARM: dts: imx6: adopt DT to new GPC binding
      ARM: dts: imx6qp: add specific compatible for GPC

Marcus Cooper (1):
      ARM: dts: sun8i-h3: orange-pi-2: Enable audio codec

Marek Belisko (1):
      ARM: dts: twl4030: Add missing madc reference for bci subnode

Marek Szyprowski (2):
      ARM: dts: exynos: Remove MFC reserved buffers
      ARM: dts: exynos: Add HDMI CEC device to Exynos5 SoC family

Marek Vasut (7):
      ARM: dts: r8a7791: add GyroADC clock
      ARM: dts: r8a7791: Add GyroADC clock and device node
      ARM: dts: socfpga: Fix the ethernet clock phandle
      ARM: dts: socfpga: Enable QSPI support on VINING FPGA
      ARM: dts: socfpga: Remove I2C EEPROMs from VINING FPGA
      ARM: dts: socfpga: Drop LED node from VINING FPGA
      ARM: dts: socfpga: Add second ethernet alias to VINING FPGA

Martin Blumenstingl (20):
      ARM: dts: meson: organize devices in their corresponding busses
      ARM: dts: meson8b: inherit meson.dtsi from meson8b.dtsi
      clk: meson-gxbb: un-export the CPU clock
      ARM: dts: meson8: add and use the real clock controller
      clk: meson8b: export the SAR ADC clocks
      clk: meson8b: export the SDIO clock
      clk: meson8b: export the gate clock for the HW random number generator
      clk: meson8b: export the USB clocks
      clk: meson8b: export the ethernet gate clock
      ARM: dts: meson8: fix the IR receiver pins
      ARM: dts: meson: use C preprocessor friendly include syntax
      ARM: dts: meson: use GIC_SPI and IRQ_TYPE_EDGE_RISING macros
      ARM: dts: meson8: add the PWM_E and PWM_F pins
      ARM: dts: meson8: add the pins for the SDIO controller
      ARM: dts: meson: add the SAR ADC
      ARM: dts: meson8: add reserved memory zones
      ARM: dts: meson: add the hardware random number generator
      ARM: dts: meson: add USB support on Meson8 and Meson8b
      ARM: dts: meson8b: add the SCU device node
      ARM: dts: meson: use the real ethernet clock on Meson8 and Meson8b

Masahiro Yamada (3):
      ARM: dts: imx6: use #include "..." to include local DT
      ARM: dts: uniphier: fix simple-bus unit address format error
      ARM: dts: uniphier: use SPDX-License-Identifier

Maxime Ripard (2):
      ARM: sun5i: a10s: Add the HDMI controller node
      ARM: sun5i: a10s-olinuxino: Enable HDMI

Neil Armstrong (1):
      clk: meson-gxbb: expose SPICC gate

Oleksij Rempel (1):
      arm: dts: sun7i-a20-bananapi: name the GPIO lines

Olof Johansson (23):
      Merge tag 'renesas-dt-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'gemini-v4.13-dts-1' of
git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'omap-for-v4.13/dt-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'davinci-for-v4.13/dt' of
git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'v4.13-rockchip-dts32-1' of
git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'samsung-dt-4.13' of
git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'keystone_dts_for_4.13' of
git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'v4.12-next-dts32' of
https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'stm32-dt-for-v4.13-1' of
git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'uniphier-dt-v4.13' of
git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'arm-soc/for-4.13/devicetree' of
http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'gemini-v4.13-dts-2' of
git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'amlogic-dt' of
git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'sunxi-dt-for-4.13' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt-h3-for-4.13' of
https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'omap-for-v4.13/dt-part2-signed' of
git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'tegra-for-4.13-arm-dt' of
git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'qcom-dts-for-4.13' of
git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'renesas-dt2-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings2-for-v4.13' of
https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'at91-ab-4.13-dt' of
git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'mvebu-dt-4.13-1' of
git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'imx-dt-4.13' of
git://git.kernel.org/.../shawnguo/linux into next/dt

Patrice Chotard (3):
      ARM: dts: stm32: Add usart2_pins on stm32h743
      ARM: dts: stm32: Add usart2 support on stm32h743
      ARM: dts: stm32: Add stm32h743i-disco board

Peter Ujfalusi (1):
      ARM: dts: am43xx-clocks: Add support for CLKOUT2

Philipp Zabel (2):
      ARM: dts: imx6qdl: add multiplexer controls
      ARM: dts: imx6qdl: Add video multiplexers, mipi_csi, and their connections

Quentin Schulz (4):
      ARM: dtsi: axp209: add battery power supply subnode
      ARM: dtsi: axp22x: add battery power supply subnode
      ARM: dts: sun8i: sina33: enable battery power supply subnode
      ARM: sun5i: chip: enable battery power supply subnode

Rafa? Mi?ecki (2):
      ARM: dts: BCM5301X: Add CPU thermal sensor and zone
      ARM: dts: BCM5301X: Specify MDIO bus in the DT

Ralph Sennhauser (13):
      ARM: dts: mvebu: Add PWM properties for armada-38x
      ARM: dts: armada-385-linksys: flatten dtsi
      ARM: dts: armada-385-linksys: label nodes
      ARM: dts: armada-385-linksys: flatten dependants
      ARM: dts: armada-385-linksys: drop redundant properties in dependants
      ARM: dts: armada-385-linksys: bm pools by label order
      ARM: dts: armada-385-linksys: usb3 label cleanup
      ARM: dts: armada-385-linksys: drop legacy DSA bindings
      ARM: dts: armada-385-linksys: use binary unit prefixes
      ARM: dts: armada-385-linksys: partition layout is board specific
      ARM: dts: armada-385-linksys: group pins in pinctrl
      ARM: dts: armada-385-linksys: fixup button node names
      ARM: dts: mvebu: add support for Linksys WRT3200ACM (Rango)

Randy Li (1):
      ARM: dts: rockchip: add adc button for Firefly

Ricardo Salveti (1):
      arm: dts: boneblack-wireless: add WL1835 Bluetooth device node

Rick Chang (1):
      arm: dts: mt2701: Add node for Mediatek JPEG Decoder

Rob Herring (2):
      ARM: dts: r8a779x: Fix PCI bus dtc warnings
      ARM: dts: tegra: fix PCI bus dtc warnings

Robert Nelson (2):
      ARM: dts: Add am335x-boneblue
      ARM: dts: bonegreen-wireless: add WL1835 Bluetooth device node

Rocky Hao (1):
      ARM: dts: rockchip: set a sane frequence for tsadc on rk322x

Roger Quadros (1):
      ARM: dts: dra7x-evm: Enable dual-role mode for USB1

Sean Wang (11):
      arm: dts: mt7623: add spi nodes to the mt7623.dtsi file
      arm: dts: mt7623: add pwm nodes to the mt7623.dtsi file
      arm: dts: mt7623: add ethernet nodes to the mt7623.dtsi file
      arm: dts: mt7623: add crypto engine nodes to the mt7623.dtsi file
      arm: dts: mt7623: add ir nodes to the mt7623.dtsi file
      arm: dts: mt7623: add afe nodes to the mt7623.dtsi file
      arm: dts: mt7623: add rng nodes to the mt7623.dtsi file
      arm: dts: mt7623: add auxadc nodes to the mt7623.dtsi file
      arm: dts: mt7623: add efuse nodes to the mt7623.dtsi file
      arm: dts: mt7623: add thermal nodes to the mt7623.dtsi file
      arm: dts: mt7623: add Sean as one of authors for mt7623.dtsi files

Sebastian Reichel (5):
      ARM: dts: omap4-droid4: Add bluetooth
      ARM: dts: omap4-droid4: Add isl29030 ALS/proximity sensor
      ARM: dts: omap4-droid4: Fix WLAN compatible
      ARM: dts: omap4: Fix aes entry
      ARM: dts: omap4.dtsi: remove aes[12]_fck

Sergey Matyukevich (1):
      ARM: dts: orange-pi-zero: add node for SPI NOR

Simon Horman (11):
      ARM: dts: emev2: update PFC node name to pin-controller
      ARM: dts: r8a73a4: update PFC node name to pin-controller
      ARM: dts: r8a7740: update PFC node name to pin-controller
      ARM: dts: r8a7778: update PFC node name to pin-controller
      ARM: dts: r8a7779: update PFC node name to pin-controller
      ARM: dts: r8a7790: update PFC node name to pin-controller
      ARM: dts: r8a7791: update PFC node name to pin-controller
      ARM: dts: r8a7793: update PFC node name to pin-controller
      ARM: dts: sh73a0: update PFC node name to pin-controller
      ARM: dts: r8a7793: set maximum frequency for SDHI clocks
      ARM: dts: gose: Enable UHS-I SDR-50 and SDR-104

Sjoerd Simons (1):
      ARM: dts: rockchip: Setup usb vbus-supply on rk3288-rock2

Stefan Agner (2):
      ARM: dts: imx7: add USDHC NAND and IPG clock to SDHC instances
      ARM: dts: imx7: use 3 PWM cells

Stefan Wahren (4):
      ARM: dts: bcm283x: Add CPU thermal zone with 1 trip point
      ARM: dts: bcm283x: Add dtsi for OTG mode
      ARM: dts: bcm283x: Add generic USB PHY
      ARM: dts: bcm2835-rpi-zero: Enable OTG mode

Stephen Boyd (3):
      ARM: dts: qcom: Remove s4/5vs1,2 from RPM pm8941 control
      ARM: dts: qcom-msm8974: Add HS usb node and OTG detection mechanisms
      ARM: dts: qcom-apq8064: Collapse usb support into one node

Stephen Warren (1):
      ARM: tegra: remove Whistler support

Steve Longerbeam (9):
      ARM: dts: imx6qdl: Add compatible, clocks, irqs to MIPI CSI-2 node
      ARM: dts: imx6qdl: add capture-subsystem device
      ARM: dts: imx6qdl-sabrelite: remove erratum ERR006687 workaround
      ARM: dts: imx6-sabrelite: add OV5642 and OV5640 camera sensors
      ARM: dts: imx6-sabresd: add OV5642 and OV5640 camera sensors
      ARM: dts: imx6-sabreauto: create i2cmux for i2c3
      ARM: dts: imx6-sabreauto: add reset-gpios property for max7310_b
      ARM: dts: imx6-sabreauto: add pinctrl for gpt input capture
      ARM: dts: imx6-sabreauto: add the ADV7180 video decoder

Subhajit Paul (1):
      ARM: dts: dra7xx-clocks: Use DPLL_GPU for GPU clocks

Sugar Zhang (1):
      ARM: dts: rockchip: fix rk322x i2s1 pinctrl error

Suman Anna (7):
      ARM: dts: am572x-idk: Enable the system mailboxes 5 and 6
      ARM: dts: am571x-idk: Enable the system mailboxes 5 and 6
      ARM: dts: omap44xx-clocks: Set IVA DPLL and its output clock rates
      ARM: dts: omap54xx-clocks: Set IVA DPLL and its output clock rates
      ARM: dts: dra7xx-clocks: Source IPU1 functional clock from CORE DPLL
      ARM: dts: dra7xx-clocks: Set DSP DPLL and its output clock rates
      ARM: dts: dra7xx-clocks: Set IVA DPLL and its output clock rates

Suniel Mahesh (1):
      arm: dts: am33xx: Remove redundant interrupt-parent property

Sven Eckelmann (1):
      ARM: dts: qcom: add gsbi7 serial to ipq8064 SoC device tree

Tero Kristo (2):
      ARM: dts: omap4: add aes2 instance
      ARM: dts: omap4: add SHAM node

Tim Harvey (2):
      ARM: dts: imx: ventana: fix DTC warnings
      ARM: dts: imx: add Gateworks Ventana GW5600 support

Tony Lindgren (4):
      ARM: dts: Enable earlycon stdout path for duovero
      ARM: dts: Enable earlycon stdout path for LogicPD torpedo
      ARM: dts: Configure USB host for 37xx-evm
      ARM: dts: omap4-droid4: Configure CPCAP battery driver

Ulrich Hecht (2):
      ARM: dts: gose: add HDMI input
      ARM: dts: gose: add composite video input

Uwe Kleine-K?nig (3):
      ARM: dts: omap4-devkit8000: fix gpmc ranges property
      dts: gpio_atmel: adapt binding doc to reality
      ARM: dts: at91-sama5d4: use IRQ_TYPE_* to specify irq flags

Vanessa Maegima (1):
      ARM: dts: imx7d-pico: Add initial support

Vikas Manocha (1):
      ARM: dts: stm32: add stm32f769I & stm32f746 discovery board support

Viresh Kumar (4):
      ARM: sun8i: Use - instead of @ for DT OPP entries
      ARM: dts: Use - instead of @ for DT OPP entries for TI SoCs
      ARM: dts: uniphier: Use - instead of @ for DT OPP entries
      ARM: pxa: Use - instead of @ for DT OPP entries

Wenyou Yang (1):
      ARM: dts: at91: sama5d2: add m_can nodes

William Wu (2):
      ARM: dts: rockchip: add usb nodes on rk322x
      ARM: dts: rockchip: enable usb for rk3229 evb board

Yannick Fertre (4):
      ARM: dts: stm32: Add ltdc support on stm32f429 MCU
      ARM: dts: stm32: Enable ltdc & simple panel on stm32f429-Eval board
      ARM: dts: stm32: Add watchdog support for STM32F429 SoC
      ARM: dts: stm32: Add watchdog support for STM32F429 eval board

Youlin Pei (1):
      ARM: dts: mt2701: Add mtk-cirq node for mt2701

Yuantian Tang (1):
      ARM: dts: ls1021a: update the clockgen node

 Documentation/devicetree/bindings/arm/actions.txt  |  39 ++
 Documentation/devicetree/bindings/arm/cpus.txt     |   1 +
 Documentation/devicetree/bindings/arm/gemini.txt   |  24 +-
 .../devicetree/bindings/arm/keystone/keystone.txt  |   3 +
 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +-
 Documentation/devicetree/bindings/arm/shmobile.txt |  13 +-
 Documentation/devicetree/bindings/arm/tegra.txt    |   1 -
 .../devicetree/bindings/cpufreq/ti-cpufreq.txt     |  20 +-
 .../devicetree/bindings/gpio/gpio_atmel.txt        |  10 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.txt   |  86 +++
 .../devicetree/bindings/mtd/atmel-nand.txt         |  14 +
 .../bindings/timer/actions,owl-timer.txt           |  20 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |  27 +-
 arch/arm/boot/dts/aks-cdu.dts                      |  56 +-
 arch/arm/boot/dts/am335x-baltos.dtsi               |   2 +-
 arch/arm/boot/dts/am335x-base0033.dts              |   2 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi          |  10 +-
 arch/arm/boot/dts/am335x-boneblack-wireless.dts    |   5 +
 arch/arm/boot/dts/am335x-boneblack.dts             |   2 +-
 arch/arm/boot/dts/am335x-boneblue.dts              | 460 +++++++++++++
 arch/arm/boot/dts/am335x-bonegreen-wireless.dts    |   5 +
 arch/arm/boot/dts/am335x-nano.dts                  |   2 +-
 arch/arm/boot/dts/am335x-pepper.dts                |   2 +-
 arch/arm/boot/dts/am335x-phycore-som.dtsi          |   2 +-
 arch/arm/boot/dts/am335x-shc.dts                   |   2 +-
 arch/arm/boot/dts/am335x-sl50.dts                  |   2 +-
 arch/arm/boot/dts/am33xx.dtsi                      |  26 +-
 arch/arm/boot/dts/am4372.dtsi                      |  10 +-
 arch/arm/boot/dts/am437x-gp-evm.dts                |   2 -
 arch/arm/boot/dts/am437x-idk-evm.dts               |   2 +-
 arch/arm/boot/dts/am437x-sk-evm.dts                |   4 +-
 arch/arm/boot/dts/am43x-epos-evm.dts               |   4 +-
 arch/arm/boot/dts/am43xx-clocks.dtsi               |  36 +
 arch/arm/boot/dts/am571x-idk.dts                   |  17 +
 arch/arm/boot/dts/am572x-idk.dts                   |  20 +
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi    |   2 +-
 arch/arm/boot/dts/animeo_ip.dts                    |  53 +-
 arch/arm/boot/dts/armada-370.dtsi                  |  19 +-
 arch/arm/boot/dts/armada-385-linksys-caiman.dts    | 187 +++--
 arch/arm/boot/dts/armada-385-linksys-cobra.dts     | 187 +++--
 arch/arm/boot/dts/armada-385-linksys-rango.dts     | 203 ++++++
 arch/arm/boot/dts/armada-385-linksys-shelby.dts    | 187 +++--
 arch/arm/boot/dts/armada-385-linksys.dtsi          | 362 ++++------
 arch/arm/boot/dts/armada-385-turris-omnia.dts      |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi                  |  16 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi          |   4 +
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi          |   1 +
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts      |   8 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |  16 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |  19 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |  19 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                   |   7 +-
 arch/arm/boot/dts/aspeed-g5.dtsi                   |   7 +-
 arch/arm/boot/dts/at91-cosino.dtsi                 |  83 ++-
 arch/arm/boot/dts/at91-kizbox.dts                  |  42 +-
 arch/arm/boot/dts/at91-kizbox2.dts                 |  45 +-
 arch/arm/boot/dts/at91-kizboxmini.dts              |  52 +-
 arch/arm/boot/dts/at91-linea.dtsi                  |  27 +-
 arch/arm/boot/dts/at91-qil_a9260.dts               | 103 +--
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |  32 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  97 +--
 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi          |   4 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  83 ++-
 arch/arm/boot/dts/at91-sama5d4ek.dts               |  83 ++-
 arch/arm/boot/dts/at91-tse850-3.dts                |  72 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |  65 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |  48 +-
 arch/arm/boot/dts/at91sam9261ek.dts                |  83 ++-
 arch/arm/boot/dts/at91sam9263.dtsi                 |  89 ++-
 arch/arm/boot/dts/at91sam9263ek.dts                | 103 +--
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi        | 103 +--
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  64 +-
 arch/arm/boot/dts/at91sam9m10g45ek.dts             |  49 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  74 +-
 arch/arm/boot/dts/at91sam9n12ek.dts                |  26 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |  69 +-
 arch/arm/boot/dts/at91sam9rlek.dts                 |  85 ++-
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 134 ++--
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |  83 ++-
 arch/arm/boot/dts/axp209.dtsi                      |   5 +
 arch/arm/boot/dts/axp22x.dtsi                      |   5 +
 arch/arm/boot/dts/bcm-cygnus.dtsi                  |  71 ++
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  26 +
 arch/arm/boot/dts/bcm2835-rpi-zero.dts             |   2 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |   2 +-
 arch/arm/boot/dts/bcm2835.dtsi                     |   4 +
 arch/arm/boot/dts/bcm2836.dtsi                     |   4 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |   1 +
 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi         |  10 +
 arch/arm/boot/dts/bcm283x.dtsi                     |  27 +
 arch/arm/boot/dts/bcm5301x.dtsi                    |  34 +
 arch/arm/boot/dts/bcm911360_entphn.dts             |  20 +
 arch/arm/boot/dts/da850-evm.dts                    |   2 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |  28 +
 arch/arm/boot/dts/da850.dtsi                       |  29 +-
 arch/arm/boot/dts/dra7-evm.dts                     |   3 +-
 arch/arm/boot/dts/dra7.dtsi                        |   4 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi            |   3 +-
 arch/arm/boot/dts/dra7xx-clocks.dtsi               |  20 +
 arch/arm/boot/dts/emev2.dtsi                       |   2 +-
 arch/arm/boot/dts/ethernut5.dts                    |  47 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |   6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |   8 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |   2 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |   4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |   6 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |   4 +
 arch/arm/boot/dts/exynos4412-odroidx.dts           |   2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |   8 +-
 arch/arm/boot/dts/exynos5.dtsi                     |  84 +--
 arch/arm/boot/dts/exynos5250-arndale.dts           |   1 -
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |   7 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   1 -
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |   4 +
 arch/arm/boot/dts/exynos5250-spring.dts            |   1 -
 arch/arm/boot/dts/exynos5250.dtsi                  |  21 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   1 -
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   5 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |   7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   1 -
 arch/arm/boot/dts/exynos5420.dtsi                  |  89 +--
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |   2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |   5 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   5 +-
 arch/arm/boot/dts/ge863-pro3.dtsi                  |  41 +-
 arch/arm/boot/dts/gemini-nas4220b.dts              |  10 +
 arch/arm/boot/dts/gemini-sq201.dts                 |  10 +
 arch/arm/boot/dts/gemini.dtsi                      |  81 ++-
 arch/arm/boot/dts/imx23-sansa.dts                  |   7 +-
 arch/arm/boot/dts/imx25-karo-tx25.dts              |   2 +-
 arch/arm/boot/dts/imx25-pdk.dts                    |   2 +-
 arch/arm/boot/dts/imx25.dtsi                       |   1 +
 arch/arm/boot/dts/imx27-phytec-phycard-s-som.dtsi  |   2 +-
 arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi    |   2 +-
 arch/arm/boot/dts/imx28-cfa10037.dts               |   2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts               |   2 +-
 arch/arm/boot/dts/imx28-cfa10057.dts               |   2 +-
 arch/arm/boot/dts/imx28-cfa10058.dts               |   2 +-
 arch/arm/boot/dts/imx28-eukrea-mbmx287lc.dts       |   2 +-
 arch/arm/boot/dts/imx28-evk.dts                    |   4 +-
 arch/arm/boot/dts/imx28-m28cu3.dts                 |   2 +-
 arch/arm/boot/dts/imx50-evk.dts                    |   2 +-
 arch/arm/boot/dts/imx50.dtsi                       |   1 +
 arch/arm/boot/dts/imx51-apf51.dts                  |   2 +-
 arch/arm/boot/dts/imx53-mba53.dts                  |   2 +-
 arch/arm/boot/dts/imx53-qsb-common.dtsi            |   2 +-
 arch/arm/boot/dts/imx53-smd.dts                    |   2 +-
 arch/arm/boot/dts/imx53-tqma53.dtsi                |   2 +-
 arch/arm/boot/dts/imx53-tx53.dtsi                  |   2 +-
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi        |   2 +-
 arch/arm/boot/dts/imx6dl-gw560x.dts                |  55 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts             |   2 +-
 arch/arm/boot/dts/imx6dl-sabrelite.dts             |   5 +
 arch/arm/boot/dts/imx6dl-sabresd.dts               |   5 +
 arch/arm/boot/dts/imx6dl.dtsi                      | 189 ++++++
 arch/arm/boot/dts/imx6q-ba16.dtsi                  |   2 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts                 |  43 +-
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts            |   4 +-
 arch/arm/boot/dts/imx6q-evi.dts                    |   2 +-
 arch/arm/boot/dts/imx6q-gw5400-a.dts               |   7 +-
 arch/arm/boot/dts/imx6q-gw560x.dts                 |  59 ++
 arch/arm/boot/dts/imx6q-novena.dts                 |   4 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts              |   5 +
 arch/arm/boot/dts/imx6q-sabresd.dts                |   5 +
 arch/arm/boot/dts/imx6q-utilite-pro.dts            |   2 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts               |   4 +-
 arch/arm/boot/dts/imx6q.dtsi                       | 127 +++-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi             |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   4 +-
 arch/arm/boot/dts/imx6qdl-colibri.dtsi             |   1 +
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   5 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   5 -
 arch/arm/boot/dts/imx6qdl-gw560x.dtsi              | 749 +++++++++++++++++++++
 arch/arm/boot/dts/imx6qdl-microsom-ar8035.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_som2.dtsi      |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           | 131 +++-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           | 152 ++++-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             | 116 +++-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   5 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   3 +-
 arch/arm/boot/dts/imx6qdl.dtsi                     |  60 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts              |   4 +-
 arch/arm/boot/dts/imx6qp.dtsi                      |   4 +
 arch/arm/boot/dts/imx6sl.dtsi                      |   3 +
 arch/arm/boot/dts/imx6sx-nitrogen6sx.dts           |   4 +-
 arch/arm/boot/dts/imx6sx-sdb.dts                   |   8 +
 arch/arm/boot/dts/imx6sx.dtsi                      |   3 +
 arch/arm/boot/dts/imx6ul-opos6ul.dtsi              |   2 +-
 arch/arm/boot/dts/imx6ul-tx6ul-mainboard.dts       |   2 +-
 arch/arm/boot/dts/imx6ul-tx6ul.dtsi                |   7 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |   1 +
 arch/arm/boot/dts/imx7-colibri.dtsi                |   2 +-
 arch/arm/boot/dts/imx7d-nitrogen7.dts              |   6 +-
 arch/arm/boot/dts/imx7d-pico.dts                   | 403 +++++++++++
 arch/arm/boot/dts/imx7d-pinfunc.h                  |   6 +-
 arch/arm/boot/dts/imx7d-sdb.dts                    | 133 +++-
 arch/arm/boot/dts/imx7d.dtsi                       |  37 +
 arch/arm/boot/dts/imx7s-warp.dts                   |   3 +-
 arch/arm/boot/dts/imx7s.dtsi                       |  50 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts             |   2 +-
 arch/arm/boot/dts/keystone-k2g-ice.dts             |  35 +
 arch/arm/boot/dts/keystone-k2g.dtsi                |   3 +-
 arch/arm/boot/dts/logicpd-torpedo-som.dtsi         |   4 +
 arch/arm/boot/dts/ls1021a.dtsi                     |  90 +--
 arch/arm/boot/dts/meson.dtsi                       | 213 +++---
 arch/arm/boot/dts/meson6-atv1200.dts               |   2 +-
 arch/arm/boot/dts/meson6.dtsi                      |   4 +-
 arch/arm/boot/dts/meson8.dtsi                      | 240 +++++--
 arch/arm/boot/dts/meson8b.dtsi                     | 272 ++++----
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi     |  16 +
 arch/arm/boot/dts/moxart.dtsi                      |   3 +-
 arch/arm/boot/dts/mt2701-evb.dts                   | 132 ++++
 arch/arm/boot/dts/mt2701.dtsi                      | 179 ++++-
 arch/arm/boot/dts/mt7623.dtsi                      | 546 ++++++++++++++-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |   9 +-
 arch/arm/boot/dts/omap3-evm-37xx.dts               | 102 +++
 arch/arm/boot/dts/omap3-evm-common.dtsi            |  34 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |   2 +-
 arch/arm/boot/dts/omap3-sb-t35.dtsi                |   3 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi               |   1 -
 arch/arm/boot/dts/omap4-droid4-xt894.dts           |  39 +-
 arch/arm/boot/dts/omap4-duovero.dtsi               |   4 +
 arch/arm/boot/dts/omap4-var-som-om44.dtsi          |   2 +-
 arch/arm/boot/dts/omap4.dtsi                       |  22 +-
 arch/arm/boot/dts/omap44xx-clocks.dtsi             |  22 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |   2 +-
 arch/arm/boot/dts/omap5-sbc-t54.dts                |   2 +-
 arch/arm/boot/dts/omap5-uevm.dts                   |  13 +
 arch/arm/boot/dts/omap54xx-clocks.dtsi             |   6 +
 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts     |  26 +
 arch/arm/boot/dts/owl-s500-guitar.dtsi             |  22 +
 arch/arm/boot/dts/owl-s500.dtsi                    | 186 +++++
 arch/arm/boot/dts/pm9g45.dts                       |  99 +--
 arch/arm/boot/dts/pxa25x.dtsi                      |   8 +-
 arch/arm/boot/dts/pxa27x.dtsi                      |  14 +-
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts     | 129 ++++
 .../arm/boot/dts/qcom-apq8064-arrow-sd-600eval.dts |  48 +-
 arch/arm/boot/dts/qcom-apq8064-asus-nexus7-flo.dts |  20 +-
 arch/arm/boot/dts/qcom-apq8064-cm-qs600.dts        |  53 +-
 arch/arm/boot/dts/qcom-apq8064-ifc6410.dts         |  53 +-
 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |  16 +-
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 154 +++--
 arch/arm/boot/dts/qcom-apq8074-dragonboard.dts     |  20 +
 arch/arm/boot/dts/qcom-ipq4019.dtsi                |   4 +-
 arch/arm/boot/dts/qcom-ipq8064.dtsi                |  23 +
 arch/arm/boot/dts/qcom-msm8660.dtsi                |  84 +++
 .../boot/dts/qcom-msm8974-sony-xperia-honami.dts   |   1 -
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  54 +-
 arch/arm/boot/dts/qcom-pm8941.dtsi                 |  36 +-
 arch/arm/boot/dts/r7s72100-gr-peach.dts            |  66 ++
 arch/arm/boot/dts/r7s72100.dtsi                    |   6 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7740.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts            |  25 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi              |  29 +
 arch/arm/boot/dts/r8a7778.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7779.dtsi                     |   2 +-
 arch/arm/boot/dts/r8a7790.dtsi                     |  18 +-
 arch/arm/boot/dts/r8a7791.dtsi                     |  32 +-
 arch/arm/boot/dts/r8a7793-gose.dts                 | 161 ++++-
 arch/arm/boot/dts/r8a7793.dtsi                     |   5 +-
 arch/arm/boot/dts/r8a7794.dtsi                     |  16 +-
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi     |   3 +-
 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi     |   3 +-
 arch/arm/boot/dts/rk3229-evb.dts                   |  74 ++
 arch/arm/boot/dts/rk322x.dtsi                      | 211 +++++-
 arch/arm/boot/dts/rk3288-firefly-reload.dts        |  17 +
 arch/arm/boot/dts/rk3288-firefly.dtsi              |  18 +
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   5 +
 arch/arm/boot/dts/rk3288-rock2-square.dts          |   8 +-
 arch/arm/boot/dts/rk3288-veyron.dtsi               |   5 +
 arch/arm/boot/dts/rk3288.dtsi                      |  43 ++
 .../boot/dts/{rk1108-evb.dts => rv1108-evb.dts}    |   6 +-
 arch/arm/boot/dts/{rk1108.dtsi => rv1108.dtsi}     |  20 +-
 arch/arm/boot/dts/sama5d2.dtsi                     | 117 ++++
 arch/arm/boot/dts/sama5d3.dtsi                     | 131 +++-
 arch/arm/boot/dts/sama5d3xcm.dtsi                  |  97 ++-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi              |  77 ++-
 arch/arm/boot/dts/sama5d4.dtsi                     | 177 ++++-
 arch/arm/boot/dts/sh73a0.dtsi                      |   2 +-
 arch/arm/boot/dts/socfpga.dtsi                     |   4 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi       |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts  |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts      |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 101 ++-
 arch/arm/boot/dts/stm32429i-eval.dts               |  88 +++
 arch/arm/boot/dts/stm32f429-disco.dts              |   4 +
 arch/arm/boot/dts/stm32f429.dtsi                   | 121 +++-
 arch/arm/boot/dts/stm32f746-disco.dts              |  74 ++
 arch/arm/boot/dts/stm32f746.dtsi                   |  36 +
 arch/arm/boot/dts/stm32f769-disco.dts              |  74 ++
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi           |  13 +
 arch/arm/boot/dts/stm32h743.dtsi                   |   8 +
 arch/arm/boot/dts/stm32h743i-disco.dts             |  73 ++
 arch/arm/boot/dts/sun4i-a10-a1000.dts              |   2 +-
 arch/arm/boot/dts/sun4i-a10-ba10-tvbox.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts    |   2 +-
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts         |   6 +-
 arch/arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts   |   2 +-
 arch/arm/boot/dts/sun4i-a10-gemei-g9.dts           |   2 +-
 arch/arm/boot/dts/sun4i-a10-hackberry.dts          |   2 +-
 arch/arm/boot/dts/sun4i-a10-hyundai-a7hd.dts       |   6 +-
 arch/arm/boot/dts/sun4i-a10-inet1.dts              |   2 +-
 arch/arm/boot/dts/sun4i-a10-inet97fv2.dts          |   2 +-
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts       |   2 +-
 .../boot/dts/sun4i-a10-itead-iteaduino-plus.dts    |   2 +-
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-marsboard.dts          |   2 +-
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts         |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802.dts              |   2 +-
 arch/arm/boot/dts/sun4i-a10-mk802ii.dts            |   2 +-
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts     |   2 +-
 arch/arm/boot/dts/sun4i-a10-pcduino.dts            |   2 +-
 arch/arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts   |   2 +-
 arch/arm/boot/dts/sun4i-a10.dtsi                   |   6 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts       |   8 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts       |   4 -
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts   |  33 +-
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts           |   4 -
 arch/arm/boot/dts/sun5i-a10s.dtsi                  |  47 ++
 .../boot/dts/sun5i-a13-empire-electronix-d709.dts  |   4 -
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts           |   5 -
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts          |   4 -
 arch/arm/boot/dts/sun5i-r8-chip.dts                |   4 +
 arch/arm/boot/dts/sun5i.dtsi                       |  10 +
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts        |  10 +-
 arch/arm/boot/dts/sun6i-a31.dtsi                   | 172 ++++-
 arch/arm/boot/dts/sun6i-a31s-primo81.dts           |  20 +-
 arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   |   2 +-
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts   |   6 +-
 arch/arm/boot/dts/sun7i-a20-bananapi.dts           |  51 ++
 arch/arm/boot/dts/sun7i-a20-bananapro.dts          |   2 +-
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts        |  14 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts         |   5 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts        |   2 +-
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts          |   4 +-
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts        |   2 +-
 arch/arm/boot/dts/sun7i-a20-itead-ibox.dts         |   2 +-
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts          |   8 -
 arch/arm/boot/dts/sun7i-a20-m3.dts                 |   2 +-
 arch/arm/boot/dts/sun7i-a20-mk808c.dts             |   2 +-
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts    |   2 +-
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts    |   2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3-nano.dts      |   2 +-
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts           |   6 +-
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts     |   2 +-
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts   |   4 +-
 arch/arm/boot/dts/sun7i-a20.dtsi                   |   9 +-
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts     |   8 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                   |  30 +-
 .../boot/dts/sun8i-a83t-allwinner-h8homlet-v2.dts  |   2 +-
 arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts   |  50 +-
 arch/arm/boot/dts/sun8i-a83t.dtsi                  | 111 ++-
 arch/arm/boot/dts/sun8i-h2-plus-orangepi-zero.dts  |  21 +
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts    |  53 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts      |  64 ++
 arch/arm/boot/dts/sun8i-h3-nanopi-neo.dts          |   7 +
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts          |  21 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts        |   8 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc-plus.dts    |   5 +
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts         |  30 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts       |  32 +
 arch/arm/boot/dts/sun8i-h3-orangepi-plus2e.dts     |  26 +
 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts |  96 +++
 arch/arm/boot/dts/sun8i-v3s.dtsi                   | 183 ++++-
 arch/arm/boot/dts/sunxi-common-regulators.dtsi     |  30 -
 arch/arm/boot/dts/sunxi-h3-h5.dtsi                 |  48 +-
 arch/arm/boot/dts/tegra124-apalis-eval.dts         |   2 +-
 arch/arm/boot/dts/tegra124-apalis.dtsi             |   2 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   2 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   4 +-
 arch/arm/boot/dts/tegra20-harmony.dts              |   2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi            |   2 +-
 arch/arm/boot/dts/tegra20-tec.dts                  |   2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts            |   2 +-
 arch/arm/boot/dts/tegra20-whistler.dts             | 636 -----------------
 arch/arm/boot/dts/tegra20.dtsi                     |   4 +-
 arch/arm/boot/dts/tegra30-apalis-eval.dts          |   2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi              |   2 +-
 arch/arm/boot/dts/tegra30-beaver.dts               |   2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi              |   2 +-
 arch/arm/boot/dts/tegra30.dtsi                     |   5 +-
 arch/arm/boot/dts/tny_a9260_common.dtsi            |  89 ++-
 arch/arm/boot/dts/tny_a9263.dts                    | 103 +--
 arch/arm/boot/dts/twl4030.dtsi                     |   2 +
 arch/arm/boot/dts/uniphier-ld4-ref.dts             |  38 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi                |  40 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts            |  38 +-
 arch/arm/boot/dts/uniphier-ld6b.dtsi               |  38 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts            |  40 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts            |  38 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts          |  40 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi               |  40 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi               |  34 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts         |  40 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts          |  38 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi               |  56 +-
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi       |  38 +-
 arch/arm/boot/dts/uniphier-sld3-ref.dts            |  38 +-
 arch/arm/boot/dts/uniphier-sld3.dtsi               |  40 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts            |  38 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi               |  40 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi       |  42 +-
 arch/arm/boot/dts/usb_a9260_common.dtsi            | 103 +--
 arch/arm/boot/dts/usb_a9263.dts                    | 103 +--
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts          |   2 +
 drivers/clk/meson/gxbb.h                           |  20 +-
 drivers/clk/meson/meson8b.h                        |  20 +-
 include/dt-bindings/clock/gxbb-clkc.h              |  10 +-
 include/dt-bindings/clock/meson8b-clkc.h           |  10 +
 include/dt-bindings/clock/r7s72100-clock.h         |  53 ++
 include/dt-bindings/clock/r8a7791-clock.h          |   1 +
 include/dt-bindings/clock/rk3228-cru.h             |  47 ++
 include/dt-bindings/clock/rk3399-cru.h             |   2 +
 include/dt-bindings/pinctrl/r7s72100-pinctrl.h     |  16 +
 424 files changed, 11529 insertions(+), 4106 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/actions.txt
 create mode 100644 Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
 create mode 100644
Documentation/devicetree/bindings/timer/actions,owl-timer.txt
 create mode 100644 arch/arm/boot/dts/am335x-boneblue.dts
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-rango.dts
 create mode 100644 arch/arm/boot/dts/bcm2837-rpi-3-b.dts
 create mode 100644 arch/arm/boot/dts/bcm283x-rpi-usb-otg.dtsi
 create mode 100644 arch/arm/boot/dts/imx6dl-gw560x.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw560x.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw560x.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-pico.dts
 create mode 100644 arch/arm/boot/dts/keystone-k2g-ice.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-guitar-bb-rev-b.dts
 create mode 100644 arch/arm/boot/dts/owl-s500-guitar.dtsi
 create mode 100644 arch/arm/boot/dts/owl-s500.dtsi
 create mode 100644 arch/arm/boot/dts/r7s72100-gr-peach.dts
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20m.dtsi
 rename arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} (94%)
 rename arch/arm/boot/dts/{rk1108.dtsi => rv1108.dtsi} (95%)
 create mode 100644 arch/arm/boot/dts/stm32f746-disco.dts
 create mode 100644 arch/arm/boot/dts/stm32f769-disco.dts
 create mode 100644 arch/arm/boot/dts/stm32h743i-disco.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
 create mode 100644 arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts
 delete mode 100644 arch/arm/boot/dts/tegra20-whistler.dts
 create mode 100644 include/dt-bindings/pinctrl/r7s72100-pinctrl.h
