From: olof@lixom.net (Olof Johansson)
Date: Sun, 10 Sep 2017 18:18:03 -0700
Subject: [GIT PULL 3/3] ARM: arm64: Devicetree updates for v4.14
In-Reply-To: <1505092683-19362-1-git-send-email-olof@lixom.net>
References: <1505092683-19362-1-git-send-email-olof@lixom.net>
Message-ID: <1505092683-19362-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As usual, device tree updates is the bulk of our material in this merge
window. This time around, 559 patches affecting both 32- and 64-bit
platforms.

Changes are too many to list individually, but some of the larger ones:

New platform/SoC support:

- Automotive:
+ Renesas R-Car D3 (R8A77995)
+ TI DT76x
+ MediaTek mt2712e
- Communication-oriented:
+ Qualcomm IPQ8074
+ Broadcom Stingray
+ Marvell Armada 8080
- Set top box:
+ Uniphier PXs3

Besides some vendor reference boards for the SoC above, there are also several
new boards/machines:

- TI AM335x Moxa UC-8100-ME-T open platform
- TI AM57xx Beaglebone X15 Rev C
- Microchip/Atmel sama5d27 SoM1 EK
- Broadcom Raspberry Pi Zero W
- Gemini-based D-Link DIR-685 router
- Freescale i.MX6:
+ Toradex Apalis module + Apalis and Ixora carrier boards
+ Engicam GEAM6UL Starter Kit
- Freescale i.MX53-based Beckhoff CX9020 Embedded PC
- Mediatek mt7623-based BananaPi R2
- Several Allwinner-based single-board computers:
+ Cubietruck plus
+ Bananapi M3, M2M and M64
+ NanoPi A64
+ A64-OLinuXino
+ Pine64
- Rockchip RK3328 Pine64/Rock64 board support
- Rockchip RK3399 boards:
+ RK3399 Sapphire module on Excavator carrier (RK3399 reference design)
+ Theobroma Systems RK3399-Q7 SoM
- ZTE ZX296718 PCBOX Board


Conflicts: Two, due to GMAC devicetree updates being merged through netdev:

arch/arm64/boot/dts/rockchip/rk3328.dtsi: add/add. Keep both sides,
make sure to add the closing '};' for the gmac node.

arch/arm64/boot/dts/rockchip/rk3328-evb.dts: Add/add. Slightly messier, but 
the three regulators go into the toplevel node ("/ { ...") and the gmac2phy
node goes below it that at toplevel. Again, careful to make sure both sides
have the closing "};".

----------------------------------------------------------------

The following changes since commit abb7a9ea029bff310359c9794c5895fc1b139bf9:

  Merge tag 'armsoc-drivers' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-devicetree

for you to fetch changes up to b884026a2b80529fc7a4de729b92ee0ba555bfed:

  Merge branch 'next/dt64' into next/dt

----------------------------------------------------------------

Abhishek Shah (1):
      arm64: dts: Add DT node to enable BGMAC driver on Stingray

Adam Ford (1):
      ARM: dts: omap3: logicpd-torpedo-37xx-devkit: Fix MMC1 cd-gpio

Alexander Syring (1):
      ARM: dts: sun7i: enable battery power supply subnode on cubietruck

Alexandre TORGUE (3):
      ARM: dts: stm32: Remove rdinit from bootargs on stm32f469-disco
      ARM: dts: stm32: Remove rdinit from bootargs on stm32f429i-eval
      ARM: dts: stm32: Remove rdinit from bootargs on stm32f429-disco

Alexandre Torgue (1):
      ARM: dts: stm32: reorder stm32h743 nodes

Alistair Francis (1):
      arm64: zynqmp: Use C pre-processor for includes

Andrew F. Davis (2):
      ARM: dts: keystone-k2g: Add TI SCI reset-controller node
      ARM: dts: keystone-k2g-evm: Add and enable DSP CMA memory pool

Andrew Lunn (5):
      ARM: dts: imx6: RDU2: Add Micrel PHY to FEC
      ARM: dts: imx6: RDU2: Add DSA support for the Marvell 88E6352
      ARM: dts: imx6: RDU2: Add Switch EEPROM
      ARM: dts: imx6: RDU2: Add Switch interrupts
      ARM: dts: imx6: RDU2: Add Micrel PHY interrupt

Andy Yan (11):
      ARM: dts: rockchip: enable sdmmc for rv1108 evb
      ARM: dts: rockchip: add i2c dt nodes for rv1108
      ARM: dts: rockchip: add watchdog dt node for rv1108
      ARM: dts: rockchip: add saradc support for rv1108
      ARM: dts: rockchip: add spi dt node for rv1108
      ARM: dts: rockchip: add pwm dt nodes for rv1108
      ARM: dts: rockchip: add pwm backlight for rv1108 evb
      ARM: dts: rockchip: add pmic rk805 dt node for rv1108 evb
      ARM: dts: rockchip: add accelerometer bma250e dt node for rv1108 evb
      ARM: dts: rockchip: add cpu opp table for rv1108
      ARM: dts: rockchip: add cpu power supply for rv1108 evb

Antoine Tenart (3):
      arm64: dts: marvell: mcbin: add an stdout-path
      arm64: dts: marvell: add a reference to the sysctrl syscon in the ppv2 node
      arm64: dts: marvell: mcbin: enable more networking ports

Anup Patel (3):
      arm64: dts: Add sp804 DT nodes for Stingray SoC
      arm64: dts: Add FlexRM DT nodes for Stingray
      arm64: dts: Add SBA-RAID DT nodes for Stingray SoC

Arnd Bergmann (46):
      Merge tag 'samsung-dt-4.14' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'stm32-dt-for-v4.14-1' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'v4.14-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'sunxi-dt-for-4.14' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'gemini-dts-1' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'mvebu-dt-4.14-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'omap-for-v4.14/dt-v3-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'uniphier-dt-v4.14' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'qcom-dts-for-4.14' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'samsung-dt64-4.14' of git://git.kernel.org/.../krzk/linux into next/dt64
      Merge tag 'renesas-arm64-dt-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'mvebu-dt64-4.14-1' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'v4.14-rockchip-dts64-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64
      Merge tag 'sunxi-dt64-for-4.14' of https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'juno-updates-4.14' of git://git.kernel.org/.../sudeep.holla/linux into next/dt64
      Merge tag 'uniphier-dt64-v4.14' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'hisi-arm64-dt-for-4.14-v2' of git://github.com/hisilicon/linux-hisi into next/dt64
      Merge tag 'qcom-arm64-for-4.14' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'keystone_dts_for_4.14' of git://git.kernel.org/.../ssantosh/linux-keystone into next/dt
      Merge tag 'amlogic-dt' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt
      Merge tag 'amlogic-dt64' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'v4.13-next-dts64' of https://github.com/mbgg/linux-mediatek into next/dt64
      Merge tag 'arm-soc/for-4.14/devicetree-arm64' of http://github.com/Broadcom/stblinux into next/dt64
      Merge tag 'imx-dt64-4.14' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'zte-dt64-4.14' of git://git.kernel.org/.../shawnguo/linux into next/dt64
      Merge tag 'omap-for-v4.14/dt-v3-pt2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'arm-soc/for-4.14/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'imx-dt-4.14' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'zte-dt-4.14' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'tegra-for-4.14-arm-dt' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'qcom-arm64-for-4.14-2' of git://git.kernel.org/.../agross/linux into next/dt64
      Merge tag 'renesas-dt2-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings2-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-arm64-dt2-for-v4.14' of https://git.kernel.org/.../horms/renesas into next/dt64
      Merge tag 'mvebu-dt64-4.14-2' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'sunxi-dt-for-4.14-2' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt64-for-4.14-2' of https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'zynq-dt-for-4.14' of https://github.com/Xilinx/linux-xlnx into next/dt
      Merge tag 'zynqmp-dt-for-4.14' of https://github.com/Xilinx/linux-xlnx into next/dt64
      Merge tag 'davinci-for-v4.14/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'samsung-dt-4.14-2' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'aspeed-4.14-devicetree' of git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'v4.14-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'v4.14-rockchip-dts64-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt64

Ashish Kumar (1):
      arm64: dts: ls1088: Correction in Board name from "L1088A" to "LS1088A"

Benjamin Gaignard (2):
      ARM: dts: stm32: add CEC for stm32f7 family
      ARM: dts: stm32: enable CEC for stm32f769 discovery

Bharat Kumar Gogada (1):
      arm64: zynqmp: Adding prefetchable memory space to pcie node

Biju Das (8):
      ARM: dts: r8a7743: Add GPIO support
      ARM: dts: iwg20d-q7: Add pinctl support for scif0
      ARM: dts: r8a7743: Add Ethernet AVB support
      ARM: dts: iwg20d-q7: Add Ethernet AVB support
      ARM: dts: r8a7743: Add I2C DT support
      dt-bindings: apmu: Document r8a7743 support
      ARM: dts: r8a7743: Add APMU node and second CPU core
      ARM: dts: r8a7743: Add OPP table for frequency scaling

Bjorn Andersson (3):
      arm64: dts: qcom: Add RPM glink nodes to msm8996
      arm64: dts: msm8996: Add modem smp2p nodes
      arm64: dts: qcom: msm8996: Specify smd-edge for ADSP

Brian Norris (1):
      arm64: dts: rockchip: set rk3399 dynamic CPU power coefficients

Caesar Wang (5):
      arm64: dts: rockchip: add SdioAudio pd control for rk3399
      dt-bindings: gpu: add the RK3399 mali for rockchip specifics
      arm64: dts: rockchip: add ARM Mali GPU node for RK3399 SoCs
      arm64: dts: rockchip: enable the GPU for RK3399-GRU
      arm64: dts: rockchip: update dynamic-power-coefficient for rk3399

Chen-Yu Tsai (17):
      ARM: dts: sun6i: a31: Use new sun6i-a31-r-intc compatible for NMI/R_INTC
      ARM: dts: sun8i: a23/a33: Use new sun6i-a31-r-intc compatible for NMI/R_INTC
      ARM: dts: sun8i: a83t: Add device node for R_INTC interrupt controller
      ARM: dts: sun8i: a83t: Add MMC controller device nodes
      ARM: dts: sun8i: a83t: Add pingroup for 8-bit eMMC on mmc2
      ARM: dts: sun8i: a83t: cubietruck-plus: Enable micro-SD card and eMMC
      ARM: dts: sun8i: a83t: h8homlet: Enable micro-SD card and onboard eMMC
      ARM: sun8i: a83t: Add device node and pinmux setting for RSB controller
      ARM: sun8i: a83t: cubietruck-plus: Enable PMIC part of AXP818 PMIC
      ARM: sun8i: a83t: cubietruck-plus: Enable AC100 combo chip in AXP818 PMIC
      ARM: sun8i: a83t: h8homlet-v2: Enable PMIC part of AXP818 PMIC
      ARM: sun8i: a83t: h8homlet-v2: Enable AC100 combo chip in AXP818 PMIC
      ARM: sun8i: a83t: Add USB PHY and host device nodes
      ARM: sun8i: a83t: Add device node for USB OTG controller
      ARM: sun8i: a83t: cubietruck-plus: Enable onboard USB peripherals
      ARM: sun8i: a83t: h8homlet-v2: Enable USB ports
      ARM: sun8i: a83t: Add device tree for Sinovoip Bananapi BPI-M3

Chris Brandt (4):
      ARM: dts: rskrza1: Add SCIF2 pin group
      ARM: dts: rskrza1: Add Ethernet pin group
      ARM: dts: rskrza1: Add SDHI1 pin group
      ARM: dts: rskrza1: Add LED0 pin support

Chris Paterson (2):
      ARM: dts: r8a7743: Add MMCIF0 support
      ARM: dts: iwg20m: Add MMCIF0 support

Christian Kohn (1):
      arm: zynq: Add adv7511 on i2c bus for zc70x

Christian Lamparter (2):
      ARM: dts: qcom: add pseudo random number generator on the IPQ4019
      ARM: dts: qcom: add and enable both wifi blocks on the IPQ4019

Chunfeng Yun (1):
      arm: dts: mt2701: Add usb3 device nodes

Claudiu Beznea (2):
      ARM: dts: at91: at91-sama5d27_som1: add sama5d27 SoM1 support
      ARM: dts: at91: at91-sama5d27_som1_ek: Add sama5d27 SoM1 EK support

Cyrille Pitchen (3):
      ARM: dts: at91: sama5d2: add QSPI nodes
      ARM: dts: at91: sama5d2: add classd nodes
      ARM: dts: at91: sama5d2_xplained: add pin muxing and enable classd

C?dric Le Goater (1):
      ARM: dts: aspeed-g4: fix AHB window size of the SMC controllers

Dave Gerlach (2):
      dt-bindings: Drop k2g genpd device ID macros
      ARM: dts: keystone-k2g: Add ti-sci power domain node

David Lechner (1):
      ARM: dts: da850-lego-ev3: Add node for LCD display

David Wu (4):
      ARM: dts: rockchip: Add io-domain node for rk3228
      ARM: dts: rockchip: enable io-domain for rk3229-evb
      arm64: dts: rockchip: Add rk3328 io-domain node
      arm64: dts: rockchip: Add pwm nodes for rk3328

Dmitry Osipenko (1):
      ARM: tegra: Enable UDC on AC100

Dmitry Rezvanov (1):
      ARM: dts: at91: at91sam9g45: add AC97

Dongwoo Lee (2):
      arm64: dts: exynos: Fix wrong label for USB 3.0 controller node
      arm64: dts: exynos: Add extcon property for TM2 and TM2E

Edgar E. Iglesias (1):
      arm64: zynqmp: Correct IRQ nr for the SMMU

Elaine Zhang (4):
      arm64: dts: rockchip: add pd_edp node for rk3399
      clk: rockchip: add more clk ids for rv1108
      clk: rockchip: rename the clk id for HCLK_I2S1_2CH
      clk: rockchip: fix up indentation of some RV1108 clock-ids

Enric Balletbo i Serra (2):
      ARM: dts: tps65217: Add charger interrupts to the common tps65217.dtsi file
      ARM: dts: tps65217: Add power button interrupt to the common tps65217.dtsi file

Eric Anholt (1):
      ARM: dts: bcm283x: Move the BCM2837 DT contents from arm64 to arm.

Fabio Estevam (5):
      ARM: dts: imx7d-sdb: Pass phy-reset-gpios
      ARM: dts: imx6qdl-icore-rqs: Remove unneeded 'fsl,mode' property
      ARM: dts: imx6qdl-gw5xxx: Remove the 'uart-has-rtscts' property
      ARM: dts: imx7d-sdb: Add flexcan support
      ARM: dts: imx6ul-14x14-evk: Remove unrelated pin from ENET group

Fabrice Gasnier (4):
      ARM: dts: stm32: Add DAC support on stm32f429
      ARM: dts: stm32: Add DAC support on stm32h743
      ARM: dts: stm32: add ADC support on stm32h743
      ARM: dts: stm32: enable ADC on stm32h743i-eval board

Fabrizio Castro (2):
      ARM: shmobile: document iW-RainboW-G22M-SM SODIMM System on Module
      ARM: shmobile: document iW-RainboW-G22D SODIMM SOM Development Platform

Faiz Abbas (1):
      ARM: dts: am437x-gp-evm: Add support for buzzer

Finley Xiao (3):
      ARM: dts: rockchip: add cpu-supply property for cpu node of rk3229-evb
      ARM: dts: rockchip: add efuse device node for rk3228
      arm64: dts: rockchip: Add cpu operating points for RK3328 SoC

Florian Fainelli (3):
      ARM: dts: BCM53573: Add Broadcom BCM947189ACDBMR board support
      Merge tag 'bcm2835-dt-next-2017-08-07' into devicetree/next
      Merge tag 'bcm2835-dt-next-2017-08-15' into devicetree/next

Frank Wang (9):
      ARM: dts: rockchip: add basic dtsi file for RK3229 SoC
      ARM: dts: rockchip: add cpu enable method for rk3228 SoC
      ARM: dts: rockchip: add regulator nodes for rk3229-evb
      ARM: dts: rockchip: enable eMMC for rk3229-evb
      ARM: dts: rockchip: enable tsadc for rk3229-evb
      ARM: dts: rockchip: add gpio power-key for rk3229-evb
      dt-bindings: update grf-binding for rv1108 SoCs
      ARM: dts: rockchip: add usb nodes for rv1108 SoCs
      ARM: dts: rockchip: enable usb for rv1108-evb

Franklin S Cooper Jr (4):
      dt-bindings: net: c_can: Update binding for clock and power-domains property
      ARM: dts: am335x-evm: Enable NAND dma prefetch by default
      ARM: dts: am437xx: Enable NAND dma prefetch by default
      ARM: dts: dra7xx: Enable NAND dma prefetch by default

Gary Bisson (2):
      ARM: dts: imx6qdl-sabrelite: fix USB PHY reset
      ARM: dts: imx6qdl-nitrogen6x: fix USB PHY reset

Gautam Bhat (1):
      ARM: dts: imx7d-sdb: Set VLDO4 outpt to 2.8V for MIPI CSI/DSI

Geert Uytterhoeven (24):
      arm64: dts: renesas: Move CPG_AUDIO_CLK_I from board to soc files
      arm64: dts: r8a7795: Add all MSIOF nodes
      arm64: dts: r8a7796: Add missing second pair of DMA names to MSIOF nodes
      dt-bindings: sram: Document renesas,smp-sram
      ARM: dts: r8a7743: Add Inter Connect RAM
      ARM: dts: r8a7745: Add Inter Connect RAM
      ARM: dts: r8a7790: Add Inter Connect RAM
      ARM: dts: r8a7791: Add Inter Connect RAM
      ARM: dts: r8a7792: Add Inter Connect RAM
      ARM: dts: r8a7793: Add Inter Connect RAM
      ARM: dts: r8a7794: Add Inter Connect RAM
      ARM: dts: r8a7743: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7745: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7790: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7791: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7792: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7793: Reserve SRAM for the SMP jump stub
      ARM: dts: r8a7794: Reserve SRAM for the SMP jump stub
      ARM: shmobile: Document R-Car D3 SoC DT bindings
      ARM: shmobile: Document Renesas Draak board DT bindings
      arm64: renesas: Add Renesas R8A77995 Kconfig support
      arm64: dts: renesas: Add Renesas R8A77995 SoC support
      arm64: dts: renesas: Add Renesas Draak board support
      ARM: dts: iwg20m: Correct indentation of mmcif0 properties

Gregory CLEMENT (2):
      arm64: dts: marvell: Fully re-order nodes in Marvell CP110 dtsi files
      ARM64: dts: marvell: add NAND support on the CP110

Grzegorz Jaszczyk (1):
      ARM64: dts: marvell: enable USB host on Armada-8040-DB

Guodong Xu (4):
      arm64: dts: hikey960: Add support for syscon-reboot-mode
      arm64: dts: hikey960: Add pstore support
      arm64: dts: hi3660: Reset the mmc hosts
      arm64: dts: hikey960: change bluetooth uart max-speed to 3mbps

Guy Shapiro (1):
      ARM: dts: imx: update snvs-poweroff mask

Hanna Hawa (2):
      ARM64: dts: marvell: enable USB host on Armada-7040-DB
      arm64: dts: marvell: add Device Tree files for Armada-8KP

Hans Verkuil (2):
      arm64: dts: qcom: add cec clock for apq8016 board
      ARM: dts: koelsch: Add CEC clock for HDMI transmitter

Heiko Stuebner (4):
      ARM: dts: rockchip: fix property-ordering in rv1108 mmc nodes
      arm64: dts: rockchip: remove num-slots property from rk3399-sapphire
      Merge branch 'v4.14-shared/clkids' into v4.14-armsoc/dts32
      arm64: dts: rockchip: add rk3328-rock64 board

Helmut Klein (1):
      ARM64: dts: meson-gx: use stable UART bindings with correct gate clock

Hoegeun Kwon (2):
      arm64: dts: exynos: Remove the OF graph from DSI node
      ARM: dts: exynos: Remove the OF graph from DSI node

Honghui Zhang (1):
      arm: dts: mediatek: add larbid property for larb

Horia Geant? (3):
      arm64: dts: freescale: ls208xa: share aliases node
      arm64: dts: freescale: ls208xa: add crypto node
      arm64: dts: freescale: ls1088a: add crypto node

Huibin Hong (1):
      ARM: dts: rockchip: add spi node and spi pinctrl on rk3228/rk3229

Icenowy Zheng (8):
      arm64: allwinner: a64: add NMI (R_INTC) controller on A64
      arm64: allwinner: a64: add AXP803 node to Pine64 device tree
      arm64: allwinner: a64: add DTSI file for AXP803 PMIC
      arm64: allwinner: a64: enable AXP803 regulators for Pine64
      arm64: allwinner: a64: add AXP803 PMIC support to SoPine and the baseboard
      arm64: allwinner: a64: enable USB host controller for BPi M64
      arm64: allwinner: a64: enable AXP803 for Banana Pi M64
      arm64: allwinner: a64: add proper support for the Wi-Fi on BPi M64

Jacob Chen (9):
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-tinker
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-evb
      ARM: dts: rockchip: enable ARM Mali GPU on rk3288-fennec
      ARM: dts: rockchip: enable saradc for rk3288-evb
      ARM: dts: rockchip: enable adc key for rk3288-evb
      arm64: dts: rockchip: add rk3399 mipi nodes
      arm64: dts: rockchip: add rk3399 hdmi nodes
      arm64: dts: rockchip: Add support for rk3399 sapphire SOM
      arm64: dts: rockchip: Add support for rk3399 excavator main board

Jacopo Mondi (5):
      ARM: dts: r7s72100: Add pin controller node
      ARM: dts: genmai: Add SCIF2 pin group
      ARM: dts: genmai: Add RIIC2 pin group
      ARM: dts: genmai: Add user led device nodes
      ARM: dts: genmai: Add ethernet pin group

Jaehoon Chung (1):
      ARM: dts: rockchip: change to "max-frequency" from "clock-freq-min-max" on rv1108

Jagan Teki (9):
      ARM: dts: imx6ul-isiot: Move common nodes in imx6ul-isiot.dtsi
      ARM: dts: imx6ul-isiot: Add Sound card with codec node
      ARM: dts: imx6ul-isiot: Add FEC node support
      ARM: dts: imx6ul-geam-kit: Remove re-enabled usdhc1
      ARM: dts: imx6ul-geam: Drop imx6ul-geam.dtsi
      ARM: dts: imx6ul-geam: Skip suffix -kit from dts name
      ARM: dts: imx6ul-geam: Add Sound card with codec node
      arm64: allwinner: a64: Add initial NanoPi A64 support
      arm64: allwinner: a64: Add A64-OLinuXino initial support

Jason Uy (1):
      ARM: dts: cygnus: Enable Performance Monitoring Unit

Javier Martinez Canillas (3):
      ARM: dts: r7s72100: Add generic compatible string for I2C EEPROM
      ARM: dts: koelsch: Add generic compatible string for I2C EEPROM
      arm64: zynqmp: Add generic compatible string for I2C EEPROM

Jeffy Chen (2):
      arm64: dts: rockchip: Fix wrong rt5514 dmic delay property for Gru
      arm64: dts: rockchip: Assign mic irq to correct device for Gru

Jerome Brunet (6):
      ARM64: dts: meson-gxbb: p20x: add card regulator settle times
      clk: meson: meson8b: fix protection against undefined clks
      clk: meson: gxbb: fix protection against undefined clks
      clk: meson8b: expose every clock in the bindings
      clk: meson-gxbb: expose almost every clock in the bindings
      clk: meson: gxbb: Add sd_emmc clk0 clkids

Jianqun Xu (1):
      arm64: dts: rockchip: include opp dtsi for rk3399 firefly

John Crispin (4):
      arm: dts: mt7623: add mt6323.dtsi file
      arm: dts: mt7623: cleanup the mt7623n rfb uart nodes
      arm: dts: mt7623: enable the usb device on the mt7623n rfb
      arm: dts: mt7623: enable the nand device on the mt7623n nand rfb

Jon Mason (3):
      ARM: dts: NSP: Add dma-coherent to relevant DT entries
      ARM: dts: NSP: Rearrage USB entries
      ARM: dts: NSP: Add USB3 and USB3 PHY to NSP

Jonathan Richardson (1):
      ARM: dts: cygnus: Add additional peripherals to dtsi

Jose Alarcon (1):
      ARM: dts: imx6q-bx50v3: Enable i2c recovery mechanism

Joseph Chen (1):
      arm64: dts: rockchip: add rk805 node for rk3328-evb

Karthik Tummala (1):
      ARM: dts: omap3: Remove needless interrupt-parent property

Katsuhiro Suzuki (2):
      ARM: dts: uniphier: add audio out pin-mux node
      arm64: dts: uniphier: add reset controller node of analog amplifier

Kazuya Mizuguchi (1):
      arm64: dts: renesas: r8a7795: Add usb companion property in EHCI

Keerthy (1):
      ARM: dts: keystone-k2g: Add gpio nodes

Keiji Hayashibara (1):
      arm64: dts: uniphier: add watchdog node for LD11 and LD20

Kever Yang (1):
      arm64: dts: rockchip: init rk3399 vop clock rates

Kevin Hilman (3):
      dt-bindings: amlogic: add unstable statement
      Merge tag 'meson-clk-headers-for-4.14' of git://github.com/BayLibre/clk-meson into v4.14/dt64
      Merge tag 'v4.13-rc4' into v4.14/dt64

Kishon Vijay Abraham I (16):
      ARM: dts: dra72-evm-common: Correct vmmc-supply for mmc2
      ARM: dts: dra72-evm: Add vqmmc supply to mmc1
      ARM: dts: dra72-evm-revc: Add vqmmc supply to mmc1
      ARM: dts: am57xx-beagle-x15-revb1: Fix supply name used for MMC1 IO lines
      ARM: dts: dra7: Add "max-frequency" property to MMC dt nodes
      ARM: dts: am571x-idk: Fix GPIO polarity for MMC1 card detect
      ARM: dts: am572x-idk: Fix GPIO polarity for MMC1 card detect
      ARM: dts: omap*: Replace deprecated "vmmc_aux" with "vqmmc"
      ARM: dts: DRA7: Add pcie1 dt node for EP mode
      ARM: dts: dra7-evm: Add pinmux configuration for MMC
      ARM: dts: am57xx-beagle-x15: Add pinmux configuration for MMC
      ARM: dts: am571x-idk: Add pinmux configuration for MMC
      ARM: dts: am572x-idk: Add pinmux configuration for MMC
      ARM: dts: dra72-evm: Add pinmux configuration for MMC
      ARM: dts: dra72-evm-revc: Add pinmux configuration for MMC
      ARM: dts: dra71-evm: Add pinmux configuration for MMC

Klaus Goger (5):
      ARM: dts: rockchip: fix typo in rk3036 mmc pinctrl
      arm64: dts: rockchip: fix typo in mmc pinctrl
      dt-bindings: add rk3399-q7 SoM
      arm64: dts: rockchip: add RK3399-Q7 (Puma) SoM
      arm64: dts: rockchip: add Haikou baseboard with RK3399-Q7 SoM

Kunihiko Hayashi (1):
      ARM: dts: uniphier: add pinctrl groups of ethernet phy mode

Laurent Pinchart (12):
      arm64: dts: r8a7796: Add FCPF and FCPV instances
      arm64: dts: r8a7796: Add VSP instances
      arm64: dts: r8a7796: Add DU device to DT
      arm64: dts: r8a7796: Add HDMI encoder instance
      arm64: dts: r8a7796: salvator-x: Add DU external dot clocks
      arm64: dts: r8a7796: salvator-x: Enable HDMI output
      arm64: dts: r8a7795: Add support for the DU
      arm64: dts: salvator-xs: Add VC6 clock generator
      arm64: dts: r8a7795: salvator-xs: Connect DU dot clocks 0 and 3
      dt-bindings: display: renesas: Add R-Car M3-W HDMI TX DT bindings
      dt-bindings: display: rcar-du: Add a VSP channel index to the vsps DT property
      arm64: dts: salvator-common: Remove extra LVDS port label

Leo Yan (3):
      arm64: dts: hi3660: enable idle states
      arm64: dts: hi3660: add L2 cache topology
      arm64: dts: hi3660: enable watchdog

Linus Walleij (4):
      ARM: dts: gemini: Switch to using macros
      ARM: dts: Add DTS file for D-Link DIR-685
      ARM: dts: gemini: add pin control set-up for the SoC
      ARM: dts: augment Ux500 to use DT cpufreq

Lokesh Vutla (7):
      dt-bindings: ti,edma: Add 66AK2G specific information
      dt-bindings: ti,omap-hsmmc: Add 66AK2G mmc controller
      ARM: dts: keystone-k2g: add MMC0 and MMC1 nodes
      ARM: dts: keystone-k2g-evm: Enable MMC0 and MMC1
      ARM: dts: k2g: Add DCAN nodes
      ARM: dts: Add support for dra76x family of devices
      ARM: dts: Add support for dra76-evm

Ludovic Desroches (1):
      ARM: dts: at91: sama5d2_xplained: use pin macros instead of numbers

Marc Zyngier (4):
      ARM64: dts: marvell: armada-37xx: Fix GIC maintenance interrupt
      ARM64: dts: marvell: armada-37xx: Enable memory-mapped GIC CPU interface
      ARM64: dts: marvell: armada-37xx: Wire PMUv3
      ARM64: dts: marvell: armada-37xx: Enable USB2 on espressobin

Marcel Ziswiler (6):
      ARM: dts: imx6q-apalis-ixora: combine aliases
      ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: get rid of tegra legacy gen1_i2c comment
      ARM: dts: imx6qdl-apalis: reword cam i2c comment
      ARM: dts: imx6q-apalis-ixora: get rid of obsolete fusion comment
      ARM: dts: imx6q-apalis-ixora: add camera i2c bus definition
      ARM: dts: imx6qdl-apalis: imx6q-apalis-ixora: use i2c from dwc hdmi

Marcin Niestroj (1):
      ARM: dts: imx6ul-liteboard: Support poweroff

Marcin Wojtas (2):
      ARM64: dts: marvell: armada-37xx: Enable uSD on ESPRESSObin
      ARM: dts: armada-38x: Add arm_global_timer node

Marco Franchi (4):
      ARM: dts: imx6ul-evk: Add DRM panel support
      ARM: dts: imx6ul-evk: Pass the 'backlight' property
      ARM: dts: imx7d-sdb: Add DRM panel support
      ARM: dts: imx7d-sdb: Pass 'enable-gpios' and 'power-supply' properties

Marcus Cooper (2):
      ARM: dts: sun8i: h3: Enable USB OTG on the Beelink X2
      ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2

Mark Yao (1):
      arm64: dts: rockchip: Add rk3399 vop and display-subsystem

Martin Blumenstingl (7):
      ARM64: dts: meson-gx: consistently use the GIC_SPI and IRQ type macros
      ARM: dts: move the pwm_ab and pwm_cd nodes to meson.dtsi
      ARM: dts: meson8: add the PWM controller nodes
      ARM: dts: meson8b: use the existing wdt node to override the compatible
      ARM: dts: meson: add a node which describes the SRAM
      dt-bindings: clock: meson8b: describe the embedded reset controller
      ARM: dts: meson: mark the clock controller also as reset controller

Martyn Welch (1):
      ARM: dts: imx: Correct B850v3 clock assignment

Masahiro Yamada (12):
      ARM: dts: uniphier: use SPDX-License-Identifier (2nd)
      ARM: dts: uniphier: remove sLD3 SoC support
      arm64: dts: uniphier: use #include instead of /include/
      arm64: dts: uniphier: use cross-arch include instead of symlinks
      arm64: dts: uniphier: add Denali NAND controller nodes
      ARM: dts: uniphier use #include instead of /include/
      ARM: dts: uniphier: add Denali NAND controller node
      arm64: dts: uniphier: add AIDET nodes
      arm64: dts: uniphier: fix size of sdctrl node
      ARM: dts: uniphier: add AIDET nodes
      ARM: dts: uniphier: fix size of sdctrl nodes
      arm64: dts: uniphier: add PXs3 SoC support

Matthias Brugger (5):
      ARM: mediatek: dts: Cleanup bindings documentation
      arm: dts: mt7623: fix mmc interrupt assignment
      ARM: mediatek: dts: Add MT6797 binding
      arm64: dts: mediatek: add watchdog to MT6797
      arm64: dts: mediatek: Delete unused dummy clock for MT6797

Matthias Kaehlcke (2):
      arm64: dts: rockchip: Update CPU regulator voltage ranges for Gru
      arm64: dts: rockchip: Use vctrl regulators for dynamic CPU voltages on Gru/Kevin

Maxime Ripard (2):
      ARM: dts: sun8i: Add BananaPI M2-Magic DTS
      Revert "ARM: dts: sun8i: h3: Enable dwmac-sun8i on the Beelink X2"

Michal Simek (12):
      arm64: zynqmp: Remove leading 0s from mtd table for spi flashes
      arm: zynq: Label whole PL part as fpga_full region
      arm: zynq: Use C pre-processor for includes in dts
      arm: zynq: Remove earlycon from bootargs
      arm64: zynqmp: Move nodes which have no reg property out of bus
      arm64: zynqmp: Add references to cpu nodes
      arm64: zynqmp: Add dcc console for zynqmp
      arm64: zynqmp: Add CCI-400 node
      arm64: zynqmp: Add support for RTC
      arm64: zynqmp: Add new uartps compatible string
      arm64: zynqmp: Add fpd/lpd dmas
      arm64: zynqmp: Add missing mmc aliases in ep108

Naga Sureshkumar Relli (2):
      arm64: zynqmp: Set status disabled in dtsi
      arm64: zynqmp: Enable can1 for ep108

Neil Armstrong (8):
      ARM64: dts: meson-gx: Add SoC info register
      ARM64: dts: meson-gxl-khadas-vim: Add GPIO lines names
      ARM64: dts: meson-gxbb-nanopi-k2: Add GPIO lines names
      dt-bindings: clock: gxbb-aoclk: Add CEC 32k clock
      ARM: dts: meson6: use stable UART bindings
      ARM64: dts: meson-gx: update AO clkc to new bindings
      ARM64: dts: meson-gx: Add AO CEC nodes
      ARM64: dts: meson-gxl-libretech-cc: Add GPIO lines names

Nishanth Menon (1):
      ARM: dts: keystone-k2g: Add PMMC node to support TI-SCI protocol

Oleksij Rempel (1):
      ARM: dts: imx6: RIoTboard provide gpio-line-names

Olof Johansson (11):
      Merge tag 'v4.13-next-dts32' of https://github.com/mbgg/linux-mediatek into next/dt
      Merge tag 'mvebu-dt64-4.14-3' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'amlogic-dt64-2' of git://git.kernel.org/.../khilman/linux-amlogic into next/dt64
      Merge tag 'uniphier-dt-v4.14-2' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'uniphier-dt64-v4.14-2' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt64
      Merge tag 'sunxi-dt-for-4.14-3' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-fixes-for-4.13-3' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-fixes-for-4.13-3' of https://git.kernel.org/.../sunxi/linux into next/dt64
      Merge tag 'mvebu-dt64-4.14-4' of git://git.infradead.org/linux-mvebu into next/dt64
      Merge tag 'at91-ab-4.14-dt2' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge branch 'next/dt64' into next/dt

Patrick Bruenn (4):
      dt-bindings: arm: Add entry for Beckhoff CX9020
      ARM: dts: imx53: add srtc node
      ARM: dts: imx53: add alternative UART2 configuration
      ARM: dts: imx: add CX9020 Embedded PC device tree

Paul Kocialkowski (1):
      ARM: tegra: Register host1x node with IOMMU binding on Tegra124

Pavel Machek (1):
      ARM: dts: nokia n900: update dts with camera support

Peter Ujfalusi (1):
      ARM: dts: keystone-k2g: Add eDMA nodes

Pierre-Yves MORDRET (2):
      ARM: dts: stm32: Add DMA support for STM32F746 SoC
      ARM: dts: stm32: Add DMA support for STM32H743 SoC

Rafa? Mi?ecki (3):
      ARM: dts: BCM5301X: Specify USB ports for each controller
      ARM: dts: BCM5301X: Specify USB ports for USB LEDs of few devices
      ARM: BCM53573: Specify ports for USB LED for Tenda AC9

Rajendra Nayak (1):
      arm64: dts: qcom: db820c: Add pm8994 regulator node

Ramesh Shanmugasundaram (2):
      arm64: dts: r8a7796: Add DRIF support
      arm64: dts: r8a7795: Add DRIF support

Ran Wang (1):
      arm64: dts: ls1012a: add USB host controller nodes

Raveendra Padasalagi (1):
      ARM: dts: cygnus: Add generic-ehci/ohci nodes

Ravikumar Kattekola (1):
      ARM: dts: dra7-evm: Correct the vmmc-supply for mmc2

Ray Jui (1):
      ARM: dts: cygnus: Fix incorrect UART2 register base

Rob Clark (2):
      arm64: dts: qcom: msm8916: Add gpu support
      arm64: dts: qcom: msm8916: Add IOMMU support

Rob Herring (6):
      arm64: dts: xilinx: fix PCI bus dtc warnings
      ARM: dts: exynos: fix PCI bus dtc warnings
      ARM: dts: marvell: fix PCI bus dtc warnings
      ARM: dts: spear13xx: fix PCI bus dtc warnings
      ARM: dts: versatile: fix PCI bus dtc warnings
      arm64: dts: apm: fix PCI bus dtc warnings

Robert Nelson (1):
      ARM: dts: am57xx-beagle-x15: Add support for rev C

Rocky Hao (3):
      arm64: dts: rockchip: add tsadc node for rk3328 SoC
      arm64: dts: rockchip: add thermal nodes for rk3328 SoC
      arm64: dts: rockchip: Enable tsadc module on RK3328 eavluation board

Romain Perier (1):
      arm64: dts: rockchip: Add basic cpu frequencies for RK3368

Russell King (5):
      arm64: dts: marvell: cp110: add GPIO interrupts
      arm64: dts: marvell: mcbin: add pinctrl nodes
      arm64: dts: marvell: fix USB3 regulator definition on MacchiatoBin
      arm64: dts: marvell: mcbin: add support for i2c mux
      arm64: dts: marvell: mcbin: add support for PCIe

Ryder Lee (1):
      arm: dts: mt7623: cleanup binding file

SZ Lin (1):
      ARM: dts: am335x: add support for Moxa UC-8100-ME-T open platform

Sai Pavan Boddu (1):
      arm: zynq: Add device-type property for zynq ethernet phy nodes

Sam Nelson (3):
      ARM: dts: keystone-k2hk-evm: Add and enable common DSP CMA memory pool
      ARM: dts: keystone-k2l-evm: Add and enable common DSP CMA memory pool
      ARM: dts: keystone-k2e-evm: Add and enable DSP CMA memory pool

Sanchayan Maity (4):
      ARM: dts: imx6q-apalis-ixora: fix usdhc2 pinctrl property
      ARM: dts: imx6qdl-apalis: split usdhc1 pinctrl to support 4- and 8-bit
      ARM: dts: imx6: add support for Toradex Ixora V1.1 carrier board
      ARM: dts: imx6q-apalis-eval: add support for Apalis Evaluation Board

Scott Branden (3):
      arm64: dts: move ns2 into northstar2 directory
      ARM: dts: cygnus: place v3d in proper address ordered location
      ARM: dts: cygnus: add serial0 alias for uart3 on bcm91130_entphn

Sean Wang (11):
      arm64: dts: mt7622: add basic nodes to the mt7622.dtsi file
      arm64: dts: mt7622: add dts file for MT7622 reference board variant 1
      dt-bindings: net: mediatek: update documentation for reset signals
      arm: dts: mt7623: fixup binding violation missing reset in ethernet node
      dt-bindings: arm: mediatek: update for MT7623n SoC and relevant boards
      dt-bindings: arm: mediatek: add bindings for mediatek MT7623a SoC Platform
      arm: dts: mt7623: rename mt7623-evb.dts to arch/arm/boot/dts/mt7623n-rfb.dtsi
      arm: dts: mt7623: add support for Bananapi R2 (BPI-R2) board
      arm: dts: mt7623: add clock-frequency to CPU nodes
      arm: dts: mt2701: Add ethernet device node
      arm: dts: mt7623: Add SD-card and EMMC to bananapi-r2

Sebastian Reichel (2):
      ARM: dts: motorola-cpcap-mapphone: set initial mode for vaudio
      ARM: dts: omap4-droid4: Add vibrator

Sekhar Nori (3):
      ARM: dts: dra72x: Create a common file with MMC/SD IOdelay data
      ARM: dts: dra74x: Create a common file with MMC/SD IOdelay data
      ARM: dts: am57xx-idk: Move common MMC/SD properties to common file

Sergei Shtylyov (8):
      arm64: dts: r8a7795: add IMR-LX4 support
      arm64: dts: r8a7796: add IMR-LX4 support
      ARM: dts: r8a7743: add PFC support
      ARM: dts: sk-rzg1m: add SCIF0 pins
      ARM: dts: sk-rzg1m: add Ether pins
      ARM: dts: r8a7745: add PFC support
      ARM: dts: sk-rzg1e: add SCIF2 pins
      ARM: dts: sk-rzg1e: add Ether pins

Shawn Guo (11):
      arm64: dts: zx296718: add VGA device support
      arm64: dts: zx296718: add I2S and I2C audio codec
      arm64: dts: zx296718: add pinctrl and gpio devices
      arm64: dts: zx296718: set a better parent clock for I2S0
      arm64: dts: zx296718: add voltage data into OPP table
      arm64: dts: zx296718: add PWM device support
      arm64: dts: zx296718: add irdec device for remote control
      arm64: dts: zx296718-evb: use audio-graph-card for HDMI audio
      arm64: dts: zx296718-evb: add I2S sound card support
      arm64: dts: zte: add initial zx296718-pcbox board support
      arm64: dts: hi6220: improve g-tx-fifo-size setting for usb device

Shawn Lin (13):
      ARM: dts: zte: remove num-slots from zx296702-ad1
      arm64: dts: zte: remove num-slots from zx296718
      ARM: dts: rockchip: remove num-slots from all platforms
      ARM: dts: rockchip: fix compatible string for eMMC node of rk3228 SoC
      ARM: dts: rockchip: add sdmmc and sdio nodes for rk3228 SoC
      arm64: dts: rockchip: change clkreq mode for rk3399-evb
      arm64: dts: rockchip: remove num-slots from all platforms
      ARM: dts: exynos: Remove num-slots from exynos platforms
      arm64: dts: exynos: Remove num-slots from exynos platforms
      arm64: dts: rockchip: remove abused keep-power-in-suspend
      arm64: dts: rockchip: change clkreq mode for rk3399-firefly
      arm64: dts: rockchip: kill pcie_clkreqn and pcie_clkreqnb for rk3399
      arm64: dts: rockchip: enable sdmmc controller on rk3399-firefly

Shubhrajyoti Datta (1):
      arm64: zynqmp: Add operating points

Simon Horman (7):
      ARM: dts: r8a7790: Use R-Car Gen 2 fallback binding for vin nodes
      ARM: dts: r8a7791: Use R-Car Gen 2 fallback binding for vin nodes
      ARM: dts: r8a7794: Use R-Car Gen 2 fallback binding for vin nodes
      ARM: dts: r8a7790: Use R-Car SATA Gen2 fallback compat string
      ARM: dts: r8a7791: Use R-Car SATA Gen2 fallback compat string
      arm64: dts: r8a7795: Use R-Car SATA Gen3 fallback compat string
      arm64: dts: r8a7795: correct whitespace of companion property

Simon Xue (5):
      ARM: dts: rockchip: add more iommu nodes on rk3288
      arm64: dts: rockchip: add rk3328 iommu nodes
      arm64: dts: rockchip: add rk3368 iommu nodes
      arm64: dts: rockchip: add more rk3399 iommu nodes
      ARM: dts: rockchip: add rk322x iommu nodes

Songjun Wu (1):
      ARM: dts: at91: sama5d2: add isc node

Srinath Mannam (2):
      arm64: dts: Add MDIO multiplexer DT node for Stingray
      arm64: dts: Add SATA DT nodes for Stingray SoC

Stanimir Varbanov (1):
      arm64: dts: qcom: msm8916: Add Venus video codec support

Stefan Agner (2):
      ARM: dts: imx7: add GPMI NAND and APBH DMA
      ARM: dts: imx7-colibri: add NAND support

Stefan Krsmanovic (1):
      arm64: zynqmp: Add idle state for ZynqMP

Stefan Wahren (5):
      ARM: bcm283x: Define UART pinmuxing on board level
      dt-bindings: bcm: Add Raspberry Pi Zero W
      ARM: dts: bcm2835: Add Raspberry Pi Zero W
      dt-bindings: arm: add SMP enable-method for BCM2836
      ARM: dts: bcm283x: Add 32-bit enable method for SMP

Steffen Trumtrar (1):
      ARM: dts: i.MX25: add RNGB node to dtsi

Stephen Boyd (1):
      arm64: dts: qcom: Force host mode for USB on apq8016-sbc

Sudeep Holla (1):
      arm64: dts: juno: replace underscores with hyphen in device node names

Sugar Zhang (5):
      ARM: dts: rockchip: add rk322x spdif node
      arm64: dts: rockchip: add rk3368 spdif node
      arm64: dts: rockchip: add rk3328 spdif node
      arm64: dts: rockchip: add rk3328 i2s nodes
      arm64: dts: rockchip: add rk3328 pdm node

Suman Anna (5):
      ARM: dts: keystone-k2hk: Add DSP nodes
      ARM: dts: keystone-k2l: Add DSP nodes
      ARM: dts: keystone-k2e: Add DSP node
      ARM: dts: keystone-k2g: Add DSP node
      ARM: dts: keystone-k2g-ice: Add and enable DSP CMA memory pool

Suzuki K. Poulose (3):
      arm64: dts: juno: Use the new coresight replicator string
      ARM: dts: qcom-msm8974: dts: Update coresight replicator
      arm64: dts: qcom-msm8916: dts: Update coresight replicator

Tao Huang (1):
      ARM: dts: rockchip: convert rk3288 device tree files to 64 bits

Tero Kristo (1):
      ARM: dts: keystone-k2g: Add ti-sci clock provider node

Thierry Reding (3):
      ARM: tegra: Enable UDC on Beaver
      ARM: tegra: Enable UDC on Dalmore
      ARM: tegra: Enable UDC on Jetson TK1

Thomas Petazzoni (2):
      arm64: dts: marvell: re-order RTC nodes in Marvell CP110 description
      arm64: dts: marvell: add TX interrupts for PPv2.2

Tim Harvey (1):
      ARM: dts: imx: ventana: add ADV1780 analog video decoder

Tony Lindgren (4):
      Merge tag 'v4.13-rc1' into omap-for-v4.14/mmc-regulator
      Merge branch 'omap-for-v4.14/mmc-regulator' into omap-for-v4.14/dt
      ARM: dts: Add dra7 iodelay configuration
      ARM: dts: Disable HDMI CEC internal pull-ups

VNSL Durga (1):
      arm64: zynqmp: Added clocks to DT for ep108

Varadarajan Narayanan (4):
      dt-bindings: qcom: Add IPQ8074 bindings
      ARM: dts: ipq4019: Fix pinctrl node name
      ARM: dts: ipq4019: Move xo and timer nodes to SoC dtsi
      arm64: dts: Add ipq8074 SoC and HK01 board support

Velibor Markovski (1):
      arm64: dts: Enable stats for CCN-502 interconnect on Stingray

Victor Chong (1):
      arm64: dts: hikey960: Add optee node

Vivek Gautam (5):
      arm64: dts: pmi8994: Add device node for pmi8994 gpios
      arm64: dts: msm8996: Add device node for qcom qusb2 phy
      arm64: dts: msm8996: Add device node for qcom qmp-phy for usb
      arm64: dts: msm8996: Add device node for qcom qmp-phy for pcie
      arm64: dts: msm8996: Add device node for qcom,dwc3

Vladimir Barinov (7):
      arm64: dts: ulcb: Enable I2C for DVFS device
      arm64: dts: ulcb: Enable I2C4
      arm64: dts: ulcb: Add DU external dot clock sources
      arm64: dts: r8a7795: h3ulcb: Add DU external dot clocks
      arm64: dts: r8a7796: m3ulcb: Add DU external dot clocks
      arm64: dts: ulcb: Add HDMI output connector
      arm64: dts: ulcb: Enable HDMI output

Wang Ruyi (1):
      arm64: dts: hi3660: add bindings for DMA

William Wu (3):
      arm64: dts: rockchip: add usb2 nodes for RK3328 SoCs
      arm64: dts: rockchip: enable usb2 for RK3328 evaluation board
      arm64: dts: rockchip: disable tx ipgap linecheck for rk3399 dwc3

Yakir Yang (1):
      arm64: dts: rockchip: add rk3399 edp nodes

YiPing Xu (1):
      arm64: dts: hi3660: add pmu dt node for hi3660

Yoshihiro Shimoda (10):
      arm64: dts: renesas: r8a7795: add usb2_phy ch3 device node
      arm64: dts: renesas: r8a7795: add usb2.0 host ch3 device nodes
      arm64: dts: renesas: r8a7795: add usb-dmac ch2 and ch3 device nodes
      arm64: dts: renesas: r8a7795: add hsusb ch3 device node
      arm64: dts: r8a7796: add usb2_phy device nodes
      arm64: dts: r8a7796: add USB2.0 Host (EHCI/OHCI) device nodes
      arm64: dts: r8a7796: Add USB3.0 host device node
      arm64: dts: r8a7796: Add USB-DMAC device nodes
      arm64: dts: r8a7796: Add HSUSB device node
      arm64: dts: r8a77995: add pfc device node

Yuantian Tang (2):
      arm64: dts: ls1088a: add cpu idle support
      arm64: dts: ls208xa: add cpu idle support

Zhangfei Gao (1):
      arm64: dts: hi6220: add acpu_sctrl

Zhou Wang (1):
      arm64: dts: hisi: add PCIe host controller node for hip07 SoC

yt.shen at mediatek.com (2):
      dt-bindings: arm: Add bindings for Mediatek MT2712 SoC Platform
      arm64: dts: Add Mediatek SoC MT2712 and evaluation board dts and Makefile


 .../devicetree/bindings/arm/amlogic.txt         |  12 +
 .../bindings/arm/bcm/brcm,bcm2835.txt           |   4 +
 Documentation/devicetree/bindings/arm/bhf.txt   |   6 +
 Documentation/devicetree/bindings/arm/cpus.txt  |   1 +
 .../bindings/arm/marvell/armada-8kp.txt         |  15 +
 .../devicetree/bindings/arm/mediatek.txt        |  18 +-
 .../devicetree/bindings/arm/omap/omap.txt       |   6 +
 Documentation/devicetree/bindings/arm/qcom.txt  |   2 +
 .../devicetree/bindings/arm/rockchip.txt        |  12 +
 .../devicetree/bindings/arm/shmobile.txt        |   8 +
 .../bindings/clock/amlogic,meson8b-clkc.txt     |   9 +-
 .../bindings/display/bridge/renesas,dw-hdmi.txt |   1 +
 .../devicetree/bindings/display/renesas,du.txt  |  51 +-
 .../devicetree/bindings/dma/ti-edma.txt         |  95 ++-
 .../bindings/gpu/arm,mali-midgard.txt           |   1 +
 .../interrupt-controller/mediatek,sysirq.txt    |   1 +
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt   |  52 +-
 .../devicetree/bindings/net/can/c_can.txt       |  13 +-
 .../devicetree/bindings/net/mediatek-net.txt    |   6 +-
 .../devicetree/bindings/pci/mvebu-pci.txt       |   2 +-
 .../devicetree/bindings/power/renesas,apmu.txt  |   3 +-
 .../devicetree/bindings/serial/mtk-uart.txt     |   1 +
 .../devicetree/bindings/soc/rockchip/grf.txt    |   3 +
 .../bindings/soc/ti/sci-pm-domain.txt           |   5 +-
 .../bindings/sram/renesas,smp-sram.txt          |  27 +
 .../devicetree/bindings/vendor-prefixes.txt     |   1 +
 .../devicetree/bindings/watchdog/mtk-wdt.txt    |   6 +-
 arch/arm/boot/dts/Makefile                      |  24 +-
 arch/arm/boot/dts/am335x-bone-common.dtsi       |   3 -
 arch/arm/boot/dts/am335x-chiliboard.dts         |   3 -
 arch/arm/boot/dts/am335x-evm.dts                |   1 +
 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts  | 525 +++++++++++++++
 arch/arm/boot/dts/am437x-gp-evm.dts             |  15 +
 arch/arm/boot/dts/am43x-epos-evm.dts            |   1 +
 arch/arm/boot/dts/am571x-idk.dts                |  35 +-
 arch/arm/boot/dts/am572x-idk.dts                |  34 +-
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi |  36 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revb1.dts   |  17 +-
 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts    |  39 ++
 arch/arm/boot/dts/am57xx-beagle-x15.dts         |  11 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |   8 +
 arch/arm/boot/dts/armada-370.dtsi               |   4 +-
 arch/arm/boot/dts/armada-375.dtsi               |   4 +-
 arch/arm/boot/dts/armada-380.dtsi               |   5 +-
 arch/arm/boot/dts/armada-385-db-ap.dts          |   2 +-
 arch/arm/boot/dts/armada-385-turris-omnia.dts   |   2 +-
 arch/arm/boot/dts/armada-385.dtsi               |   6 +-
 arch/arm/boot/dts/armada-388-clearfog.dts       |   2 +-
 arch/arm/boot/dts/armada-388-clearfog.dtsi      |   2 +-
 arch/arm/boot/dts/armada-388-db.dts             |   2 +-
 arch/arm/boot/dts/armada-388-gp.dts             |   2 +-
 arch/arm/boot/dts/armada-388-rd.dts             |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi               |   7 +
 arch/arm/boot/dts/armada-390-db.dts             |   2 +-
 arch/arm/boot/dts/armada-395-gp.dts             |   2 +-
 arch/arm/boot/dts/armada-398-db.dts             |   2 +-
 arch/arm/boot/dts/armada-39x.dtsi               |   6 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi       |   3 +-
 arch/arm/boot/dts/armada-xp-db.dts              |   2 +-
 arch/arm/boot/dts/armada-xp-gp.dts              |   2 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi        |   7 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi        |  11 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi        |  14 +-
 arch/arm/boot/dts/aspeed-g4.dtsi                |   4 +-
 arch/arm/boot/dts/at91-sama5d27_som1.dtsi       | 102 +++
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts     | 537 +++++++++++++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |  39 +-
 arch/arm/boot/dts/at91sam9g45.dtsi              |  21 +
 arch/arm/boot/dts/at91sam9m10g45ek.dts          |   4 +
 arch/arm/boot/dts/bcm-cygnus.dtsi               | 149 ++++-
 arch/arm/boot/dts/bcm-nsp.dtsi                  |  59 +-
 arch/arm/boot/dts/bcm2835-rpi-a-plus.dts        |   6 +
 arch/arm/boot/dts/bcm2835-rpi-a.dts             |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b-plus.dts        |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b-rev2.dts        |   6 +
 arch/arm/boot/dts/bcm2835-rpi-b.dts             |   6 +
 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts        | 139 ++++
 arch/arm/boot/dts/bcm2835-rpi-zero.dts          |   6 +
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |   2 +-
 arch/arm/boot/dts/bcm2836-rpi-2-b.dts           |   6 +
 arch/arm/boot/dts/bcm2836.dtsi                  |   1 +
 arch/arm/boot/dts/bcm2837-rpi-3-b.dts           |  52 +-
 .../dts/broadcom => arm/boot/dts}/bcm2837.dtsi  |   1 +
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |   4 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |   3 +
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |   6 +
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts   |   4 +
 .../boot/dts/bcm4709-tplink-archer-c9-v1.dts    |   5 +
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |   3 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts   |   3 +
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts        |   2 +
 arch/arm/boot/dts/bcm5301x.dtsi                 |  34 +
 arch/arm/boot/dts/bcm53573.dtsi                 |   4 +
 arch/arm/boot/dts/bcm911360_entphn.dts          |   7 +-
 arch/arm/boot/dts/bcm947189acdbmr.dts           |  97 +++
 arch/arm/boot/dts/bcm958522er.dts               |   8 +
 arch/arm/boot/dts/bcm958525er.dts               |   8 +
 arch/arm/boot/dts/bcm958525xmc.dts              |   8 +
 arch/arm/boot/dts/bcm958622hr.dts               |   8 +
 arch/arm/boot/dts/bcm958623hr.dts               |   8 +
 arch/arm/boot/dts/bcm958625hr.dts               |   8 +
 arch/arm/boot/dts/bcm958625k.dts                |   8 +
 arch/arm/boot/dts/da850-lego-ev3.dts            |  24 +
 arch/arm/boot/dts/dove-d3plug.dts               |   4 +-
 arch/arm/boot/dts/dove.dtsi                     |   8 +-
 arch/arm/boot/dts/dra7-evm-common.dtsi          | 258 ++++++++
 arch/arm/boot/dts/dra7-evm.dts                  | 277 +-------
 arch/arm/boot/dts/dra7.dtsi                     |  36 +-
 arch/arm/boot/dts/dra71-evm.dts                 |  30 +-
 arch/arm/boot/dts/dra72-evm-common.dtsi         |   7 +-
 arch/arm/boot/dts/dra72-evm-revc.dts            |  32 +
 arch/arm/boot/dts/dra72-evm-tps65917.dtsi       |   2 +-
 arch/arm/boot/dts/dra72-evm.dts                 |  32 +
 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi       | 350 ++++++++++
 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi       | 647 +++++++++++++++++++
 arch/arm/boot/dts/dra76-evm.dts                 | 423 ++++++++++++
 arch/arm/boot/dts/dra76x.dtsi                   |  19 +
 arch/arm/boot/dts/exynos3250-artik5-eval.dts    |   1 -
 arch/arm/boot/dts/exynos3250-artik5.dtsi        |   1 -
 arch/arm/boot/dts/exynos3250-monk.dts           |   1 -
 arch/arm/boot/dts/exynos3250-rinato.dts         |  22 -
 arch/arm/boot/dts/exynos4210-trats.dts          |  21 -
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |   1 -
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   1 -
 arch/arm/boot/dts/exynos4412-origen.dts         |   1 -
 arch/arm/boot/dts/exynos4412-trats2.dts         |  22 -
 arch/arm/boot/dts/exynos5250-arndale.dts        |   2 -
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |   2 -
 arch/arm/boot/dts/exynos5250-snow-common.dtsi   |   3 -
 arch/arm/boot/dts/exynos5250-spring.dts         |   2 -
 arch/arm/boot/dts/exynos5260-xyref5260.dts      |   2 -
 arch/arm/boot/dts/exynos5410-smdk5410.dts       |   2 -
 arch/arm/boot/dts/exynos5420-peach-pit.dts      |   3 -
 arch/arm/boot/dts/exynos5440.dtsi               |   2 +
 arch/arm/boot/dts/exynos5800-peach-pi.dts       |   3 -
 arch/arm/boot/dts/gemini-dlink-dir-685.dts      | 246 +++++++
 arch/arm/boot/dts/gemini-nas4220b.dts           |  24 +
 arch/arm/boot/dts/gemini-rut1xx.dts             |  39 ++
 arch/arm/boot/dts/gemini-sq201.dts              |  36 +-
 arch/arm/boot/dts/gemini-wbd111.dts             |  26 +
 arch/arm/boot/dts/gemini-wbd222.dts             |  26 +
 arch/arm/boot/dts/gemini.dtsi                   | 173 ++++-
 arch/arm/boot/dts/imx25.dtsi                    |   7 +
 arch/arm/boot/dts/imx53-cx9020.dts              | 297 +++++++++
 arch/arm/boot/dts/imx53-pinfunc.h               |   4 +
 arch/arm/boot/dts/imx53.dtsi                    |   9 +
 arch/arm/boot/dts/imx6dl-gw52xx.dts             |  58 ++
 arch/arm/boot/dts/imx6dl-gw53xx.dts             |  58 ++
 arch/arm/boot/dts/imx6dl-gw54xx.dts             |  58 ++
 arch/arm/boot/dts/imx6dl-riotboard.dts          |  45 ++
 arch/arm/boot/dts/imx6q-apalis-eval.dts         | 278 ++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts   | 291 +++++++++
 arch/arm/boot/dts/imx6q-apalis-ixora.dts        |  32 +-
 arch/arm/boot/dts/imx6q-b850v3.dts              |   2 +-
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             |  42 ++
 arch/arm/boot/dts/imx6q-gw52xx.dts              |  58 ++
 arch/arm/boot/dts/imx6q-gw53xx.dts              |  58 ++
 arch/arm/boot/dts/imx6q-gw54xx.dts              |  58 ++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi           |  44 +-
 arch/arm/boot/dts/imx6qdl-gw51xx.dtsi           |  54 ++
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi           |   1 -
 arch/arm/boot/dts/imx6qdl-gw553x.dtsi           |  54 ++
 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi        |   1 -
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi       |  19 +
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi        |  19 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         | 112 +++-
 arch/arm/boot/dts/imx6qdl.dtsi                  |   1 +
 arch/arm/boot/dts/imx6sl.dtsi                   |   1 +
 arch/arm/boot/dts/imx6sx.dtsi                   |   1 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dts          |  40 +-
 .../dts/{imx6ul-geam.dtsi => imx6ul-geam.dts}   |  74 +++
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi      | 141 ----
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts         |   1 -
 arch/arm/boot/dts/imx6ul-isiot-nand.dts         |   1 -
 arch/arm/boot/dts/imx6ul-isiot.dtsi             | 183 ++++++
 arch/arm/boot/dts/imx6ul-liteboard.dts          |   4 +
 arch/arm/boot/dts/imx6ul.dtsi                   |   1 +
 arch/arm/boot/dts/imx7-colibri.dtsi             |   9 +
 arch/arm/boot/dts/imx7d-sdb.dts                 |  93 ++-
 arch/arm/boot/dts/imx7s.dtsi                    |  32 +
 arch/arm/boot/dts/keystone-k2e-evm.dts          |  18 +
 arch/arm/boot/dts/keystone-k2e.dtsi             |  20 +
 arch/arm/boot/dts/keystone-k2g-evm.dts          |  71 ++
 arch/arm/boot/dts/keystone-k2g-ice.dts          |  18 +
 arch/arm/boot/dts/keystone-k2g.dtsi             | 204 ++++++
 arch/arm/boot/dts/keystone-k2hk-evm.dts         |  53 ++
 arch/arm/boot/dts/keystone-k2hk.dtsi            | 139 ++++
 arch/arm/boot/dts/keystone-k2l-evm.dts          |  33 +
 arch/arm/boot/dts/keystone-k2l.dtsi             |  71 ++
 arch/arm/boot/dts/kirkwood-6192.dtsi            |   3 +-
 arch/arm/boot/dts/kirkwood-6281.dtsi            |   3 +-
 arch/arm/boot/dts/kirkwood-6282.dtsi            |   4 +-
 arch/arm/boot/dts/kirkwood-98dx4122.dtsi        |   3 +-
 .../boot/dts/logicpd-torpedo-37xx-devkit.dts    |   2 +-
 arch/arm/boot/dts/meson.dtsi                    |  30 +-
 arch/arm/boot/dts/meson6.dtsi                   |  28 +
 arch/arm/boot/dts/meson8.dtsi                   |  16 +
 arch/arm/boot/dts/meson8b.dtsi                  |  33 +-
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi  |   1 +
 arch/arm/boot/dts/mt2701.dtsi                   | 106 +++
 arch/arm/boot/dts/mt6323.dtsi                   | 241 +++++++
 arch/arm/boot/dts/mt7623-evb.dts                |  33 -
 arch/arm/boot/dts/mt7623.dtsi                   | 211 ++++--
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts   | 487 ++++++++++++++
 arch/arm/boot/dts/mt7623n-rfb-nand.dts          | 111 ++++
 arch/arm/boot/dts/mt7623n-rfb.dtsi              |  92 +++
 arch/arm/boot/dts/omap3-beagle-xm.dts           |   2 +-
 arch/arm/boot/dts/omap3-beagle.dts              |   2 +-
 arch/arm/boot/dts/omap3-cm-t3517.dts            |   2 +-
 arch/arm/boot/dts/omap3-cm-t3730.dts            |   2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi  |   2 +-
 arch/arm/boot/dts/omap3-evm-common.dtsi         |   2 +-
 arch/arm/boot/dts/omap3-n900.dts                |  89 ++-
 arch/arm/boot/dts/omap3-overo-base.dtsi         |   2 +-
 arch/arm/boot/dts/omap3-tao3530.dtsi            |   2 +-
 arch/arm/boot/dts/omap3-zoom3.dts               |   2 +-
 arch/arm/boot/dts/omap3.dtsi                    |   4 -
 arch/arm/boot/dts/omap3430-sdp.dts              |   2 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts        |  42 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts      |   2 +-
 arch/arm/boot/dts/omap4-panda-common.dtsi       |   2 +-
 arch/arm/boot/dts/omap4-sdp-es23plus.dts        |   2 +-
 arch/arm/boot/dts/omap4-sdp.dts                 |   2 +-
 .../arm/boot/dts/omap4-var-om44customboard.dtsi |   2 +-
 arch/arm/boot/dts/omap5-board-common.dtsi       |   2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts              |   2 +-
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi   |  29 +-
 arch/arm/boot/dts/qcom-ipq4019.dtsi             | 109 +++-
 arch/arm/boot/dts/qcom-msm8974.dtsi             |   2 +-
 arch/arm/boot/dts/r7s72100-genmai.dts           |  71 +-
 arch/arm/boot/dts/r7s72100-rskrza1.dts          |  61 ++
 arch/arm/boot/dts/r7s72100.dtsi                 |  78 +++
 arch/arm/boot/dts/r8a7743-iwg20d-q7.dts         |  31 +
 arch/arm/boot/dts/r8a7743-iwg20m.dtsi           |  26 +
 arch/arm/boot/dts/r8a7743-sk-rzg1m.dts          |  25 +-
 arch/arm/boot/dts/r8a7743.dtsi                  | 301 ++++++++-
 arch/arm/boot/dts/r8a7745-sk-rzg1e.dts          |  25 +-
 arch/arm/boot/dts/r8a7745.dtsi                  |  30 +-
 arch/arm/boot/dts/r8a7790.dtsi                  |  30 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  10 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  28 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |  18 +
 arch/arm/boot/dts/r8a7793.dtsi                  |  18 +
 arch/arm/boot/dts/r8a7794.dtsi                  |  22 +-
 arch/arm/boot/dts/rk3036-kylin.dts              |   2 -
 arch/arm/boot/dts/rk3036.dtsi                   |   3 +-
 arch/arm/boot/dts/rk3066a-bqcurie2.dts          |   2 -
 arch/arm/boot/dts/rk3066a-mk808.dts             |   2 -
 arch/arm/boot/dts/rk3066a-rayeager.dts          |   3 -
 arch/arm/boot/dts/rk3188-px3-evb.dts            |   2 -
 arch/arm/boot/dts/rk3188-radxarock.dts          |   1 -
 arch/arm/boot/dts/rk3229-evb.dts                | 129 +++-
 .../dts/{imx6ul-geam-kit.dts => rk3229.dtsi}    | 104 ++-
 arch/arm/boot/dts/rk322x.dtsi                   | 199 +++++-
 arch/arm/boot/dts/rk3288-evb.dtsi               |  51 +-
 arch/arm/boot/dts/rk3288-fennec.dts             |   8 +-
 .../boot/dts/rk3288-firefly-reload-core.dtsi    |   3 +-
 arch/arm/boot/dts/rk3288-firefly-reload.dts     |   2 -
 arch/arm/boot/dts/rk3288-firefly.dtsi           |   5 +-
 arch/arm/boot/dts/rk3288-miqi.dts               |   4 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts        |   1 -
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       |   3 +-
 arch/arm/boot/dts/rk3288-popmetal.dts           |   4 +-
 arch/arm/boot/dts/rk3288-r89.dts                |   3 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |   3 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts       |   2 -
 arch/arm/boot/dts/rk3288-tinker.dts             |   8 +-
 arch/arm/boot/dts/rk3288-veyron-sdmmc.dtsi      |   1 -
 arch/arm/boot/dts/rk3288-veyron.dtsi            |   4 +-
 arch/arm/boot/dts/rk3288.dtsi                   | 215 +++---
 arch/arm/boot/dts/rv1108-evb.dts                | 190 ++++++
 arch/arm/boot/dts/rv1108.dtsi                   | 369 ++++++++++-
 arch/arm/boot/dts/sama5d2.dtsi                  |  77 ++-
 arch/arm/boot/dts/spear1310.dtsi                |   3 +
 arch/arm/boot/dts/spear1340.dtsi                |   1 +
 arch/arm/boot/dts/ste-dbx5x0.dtsi               |  15 +-
 arch/arm/boot/dts/stm32429i-eval.dts            |   2 +-
 arch/arm/boot/dts/stm32f429-disco.dts           |   2 +-
 arch/arm/boot/dts/stm32f429.dtsi                |  25 +
 arch/arm/boot/dts/stm32f469-disco.dts           |   2 +-
 arch/arm/boot/dts/stm32f746.dtsi                |  51 ++
 arch/arm/boot/dts/stm32f769-disco.dts           |   6 +
 arch/arm/boot/dts/stm32h743.dtsi                | 127 +++-
 arch/arm/boot/dts/stm32h743i-eval.dts           |  18 +
 arch/arm/boot/dts/sun6i-a31.dtsi                |   6 +-
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |   4 +
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   6 +-
 .../dts/sun8i-a83t-allwinner-h8homlet-v2.dts    |  85 +++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts    | 148 +++++
 .../arm/boot/dts/sun8i-a83t-cubietruck-plus.dts | 101 +++
 arch/arm/boot/dts/sun8i-a83t.dtsi               | 176 +++++
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       |  22 +-
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts    | 321 +++++++++
 arch/arm/boot/dts/tegra114-dalmore.dts          |  10 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts       |  12 +-
 arch/arm/boot/dts/tegra124.dtsi                 |   1 +
 arch/arm/boot/dts/tegra20-paz00.dts             |   2 +
 arch/arm/boot/dts/tegra30-beaver.dts            |  10 +
 arch/arm/boot/dts/tps65217.dtsi                 |   3 +
 arch/arm/boot/dts/uniphier-ld4-ref.dts          |  10 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi             |  20 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts         |  10 +-
 arch/arm/boot/dts/uniphier-ld6b.dtsi            |   2 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi         |  58 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts         |   2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts         |  10 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts       |   2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi            |  20 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi            |  60 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts      |   2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts       |   2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |  22 +-
 arch/arm/boot/dts/uniphier-sld3-ref.dts         |  75 ---
 arch/arm/boot/dts/uniphier-sld3.dtsi            | 260 --------
 arch/arm/boot/dts/uniphier-sld8-ref.dts         |  10 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi            |  20 +-
 arch/arm/boot/dts/versatile-pb.dts              |   2 +-
 arch/arm/boot/dts/zx296702-ad1.dts              |   2 -
 arch/arm/boot/dts/zynq-7000.dtsi                |   8 +
 arch/arm/boot/dts/zynq-parallella.dts           |   3 +-
 arch/arm/boot/dts/zynq-zc702.dts                |  20 +-
 arch/arm/boot/dts/zynq-zc706.dts                |  20 +-
 arch/arm/boot/dts/zynq-zed.dts                  |   5 +-
 arch/arm/boot/dts/zynq-zybo.dts                 |   5 +-
 arch/arm64/Kconfig.platforms                    |   6 +
 arch/arm64/boot/dts/allwinner/Makefile          |   2 +
 arch/arm64/boot/dts/allwinner/axp803.dtsi       | 150 +++++
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts   | 143 +++-
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts     | 207 ++++++
 .../boot/dts/allwinner/sun50i-a64-olinuxino.dts | 199 ++++++
 .../boot/dts/allwinner/sun50i-a64-pine64.dts    | 112 ++++
 .../allwinner/sun50i-a64-sopine-baseboard.dts   |  22 +
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi   |  86 +++
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi   |   9 +
 .../boot/dts/amlogic/meson-gx-p23x-q20x.dtsi    |   7 +
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi       |  46 +-
 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts   |  58 ++
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts |   7 +
 .../arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi |  10 +
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts |   6 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi     |  34 +
 .../boot/dts/amlogic/meson-gxl-s905d-p230.dts   |   8 +-
 .../dts/amlogic/meson-gxl-s905x-khadas-vim.dts  |  63 ++
 .../amlogic/meson-gxl-s905x-libretech-cc.dts    |  64 ++
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts |   7 +
 .../boot/dts/amlogic/meson-gxl-s905x-p212.dts   |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi      |  35 +
 .../boot/dts/amlogic/meson-gxm-nexbox-a1.dts    |   7 +
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi      |   4 +
 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi      |   2 +
 arch/arm64/boot/dts/apm/apm-storm.dtsi          |   5 +
 arch/arm64/boot/dts/arm/foundation-v8.dtsi      |   2 +-
 arch/arm64/boot/dts/arm/juno-base.dtsi          |  14 +-
 .../arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi |   2 +-
 arch/arm64/boot/dts/broadcom/Makefile           |   4 +-
 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi   |   1 -
 .../arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts |  42 +-
 .../boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi |   1 -
 .../boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi |   1 -
 arch/arm64/boot/dts/broadcom/bcm283x.dtsi       |   1 -
 .../arm64/boot/dts/broadcom/northstar2/Makefile |   6 +
 .../broadcom/{ => northstar2}/ns2-clock.dtsi    |   0
 .../dts/broadcom/{ => northstar2}/ns2-svk.dts   |   0
 .../dts/broadcom/{ => northstar2}/ns2-xmc.dts   |   0
 .../boot/dts/broadcom/{ => northstar2}/ns2.dtsi |   0
 .../dts/broadcom/stingray/bcm958742-base.dtsi   |  78 +++
 .../boot/dts/broadcom/stingray/bcm958742k.dts   |   4 +
 .../boot/dts/broadcom/stingray/bcm958742t.dts   |   4 +
 .../dts/broadcom/stingray/stingray-fs4.dtsi     | 118 ++++
 .../dts/broadcom/stingray/stingray-sata.dtsi    | 278 ++++++++
 .../boot/dts/broadcom/stingray/stingray.dtsi    | 136 ++++
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |  19 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi      |   4 +-
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts |   2 -
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi  |  17 +
 .../boot/dts/freescale/fsl-ls1088a-rdb.dts      |   2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi  |  65 ++
 .../boot/dts/freescale/fsl-ls2080a-qds.dts      |   5 -
 .../boot/dts/freescale/fsl-ls2080a-rdb.dts      |   5 -
 .../boot/dts/freescale/fsl-ls2080a-simu.dts     |   5 -
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi  |  17 +
 .../boot/dts/freescale/fsl-ls2088a-qds.dts      |   5 -
 .../boot/dts/freescale/fsl-ls2088a-rdb.dts      |   5 -
 arch/arm64/boot/dts/freescale/fsl-ls2088a.dtsi  |  17 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi  |  51 ++
 .../boot/dts/hisilicon/hi3660-hikey960.dts      |  37 +-
 arch/arm64/boot/dts/hisilicon/hi3660.dtsi       | 130 ++++
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi       |   9 +-
 arch/arm64/boot/dts/hisilicon/hip07-d05.dts     |   4 +
 arch/arm64/boot/dts/hisilicon/hip07.dtsi        |  22 +
 arch/arm64/boot/dts/marvell/Makefile            |   1 +
 .../dts/marvell/armada-3720-espressobin.dts     |  30 +
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi    |  11 +-
 arch/arm64/boot/dts/marvell/armada-7040-db.dts  |  39 ++
 arch/arm64/boot/dts/marvell/armada-8040-db.dts  |  65 ++
 .../boot/dts/marvell/armada-8040-mcbin.dts      | 124 +++-
 arch/arm64/boot/dts/marvell/armada-8080-db.dts  |  67 ++
 arch/arm64/boot/dts/marvell/armada-8080.dtsi    |  53 ++
 .../dts/marvell/armada-ap810-ap0-octa-core.dtsi | 104 +++
 .../boot/dts/marvell/armada-ap810-ap0.dtsi      | 163 +++++
 .../boot/dts/marvell/armada-cp110-master.dtsi   |  83 ++-
 .../boot/dts/marvell/armada-cp110-slave.dtsi    |  83 ++-
 arch/arm64/boot/dts/mediatek/Makefile           |   2 +
 arch/arm64/boot/dts/mediatek/mt2712-evb.dts     |  32 +
 arch/arm64/boot/dts/mediatek/mt2712e.dtsi       | 171 +++++
 arch/arm64/boot/dts/mediatek/mt6797.dtsi        |  12 +-
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts    |  27 +
 arch/arm64/boot/dts/mediatek/mt7622.dtsi        | 110 ++++
 arch/arm64/boot/dts/qcom/Makefile               |   1 +
 .../boot/dts/qcom/apq8016-sbc-pmic-pins.dtsi    |   1 +
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi       |  17 +-
 .../boot/dts/qcom/apq8096-db820c-pmic-pins.dtsi |  24 +
 arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi    | 198 ++++++
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts       |  52 ++
 arch/arm64/boot/dts/qcom/ipq8074.dtsi           | 194 ++++++
 arch/arm64/boot/dts/qcom/msm8916.dtsi           | 120 +++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi           | 314 +++++++++
 arch/arm64/boot/dts/qcom/pmi8994.dtsi           |  17 +
 arch/arm64/boot/dts/renesas/Makefile            |   1 +
 .../boot/dts/renesas/r8a7795-es1-h3ulcb.dts     |   2 -
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts |   2 -
 arch/arm64/boot/dts/renesas/r8a7795-es1.dtsi    |   9 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts  |  16 +-
 .../boot/dts/renesas/r8a7795-salvator-x.dts     |   2 -
 .../boot/dts/renesas/r8a7795-salvator-xs.dts    |   8 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi        | 314 ++++++++-
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts  |  14 +-
 .../boot/dts/renesas/r8a7796-salvator-x.dts     |  31 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi        | 414 +++++++++++-
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts  |  46 ++
 arch/arm64/boot/dts/renesas/r8a77995.dtsi       | 155 +++++
 .../arm64/boot/dts/renesas/salvator-common.dtsi |   4 -
 arch/arm64/boot/dts/renesas/salvator-xs.dtsi    |  10 +
 arch/arm64/boot/dts/renesas/ulcb.dtsi           |  51 ++
 arch/arm64/boot/dts/rockchip/Makefile           |   3 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts     | 163 +++++
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts  | 333 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi        | 399 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi    |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts |   1 -
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts |   2 -
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts |   3 -
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts     |   2 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi        | 140 +++-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts     |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts |  16 +-
 .../boot/dts/rockchip/rk3399-gru-kevin.dts      |  44 ++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi    | 132 ++--
 .../arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi |  33 +
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi    |  33 +
 .../boot/dts/rockchip/rk3399-puma-haikou.dts    | 228 +++++++
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi   | 547 ++++++++++++++++
 .../dts/rockchip/rk3399-sapphire-excavator.dts  | 240 +++++++
 .../boot/dts/rockchip/rk3399-sapphire.dtsi      | 644 ++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi        | 284 +++++++-
 arch/arm64/boot/dts/socionext/Makefile          |   3 +-
 .../boot/dts/socionext/uniphier-ld11-global.dts |   6 +-
 .../boot/dts/socionext/uniphier-ld11-ref.dts    |   6 +-
 .../arm64/boot/dts/socionext/uniphier-ld11.dtsi |  35 +-
 .../boot/dts/socionext/uniphier-ld20-global.dts |   6 +-
 .../boot/dts/socionext/uniphier-ld20-ref.dts    |   6 +-
 .../arm64/boot/dts/socionext/uniphier-ld20.dtsi |  37 +-
 .../boot/dts/socionext/uniphier-pinctrl.dtsi    |   2 +-
 .../boot/dts/socionext/uniphier-pxs3-ref.dts    |  62 ++
 .../arm64/boot/dts/socionext/uniphier-pxs3.dtsi | 367 +++++++++++
 .../dts/socionext/uniphier-ref-daughter.dtsi    |   2 +-
 .../dts/socionext/uniphier-support-card.dtsi    |   2 +-
 .../arm64/boot/dts/xilinx/zynqmp-ep108-clk.dtsi |  50 +-
 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts     |  18 +-
 arch/arm64/boot/dts/xilinx/zynqmp.dtsi          | 277 +++++++-
 arch/arm64/boot/dts/zte/Makefile                |   1 +
 arch/arm64/boot/dts/zte/zx296718-evb.dts        |  68 +-
 arch/arm64/boot/dts/zte/zx296718-pcbox.dts      | 143 ++++
 arch/arm64/boot/dts/zte/zx296718.dtsi           | 171 ++++-
 drivers/clk/meson/gxbb.c                        |   2 +
 drivers/clk/meson/gxbb.h                        | 125 +---
 drivers/clk/meson/meson8b.c                     |   1 +
 drivers/clk/meson/meson8b.h                     | 103 +--
 include/dt-bindings/clock/gxbb-aoclkc.h         |   1 +
 include/dt-bindings/clock/gxbb-clkc.h           |  63 ++
 include/dt-bindings/clock/meson8b-clkc.h        |  70 ++
 include/dt-bindings/clock/rv1108-cru.h          | 123 +++-
 include/dt-bindings/genpd/k2g.h                 |  90 ---
 include/dt-bindings/pinctrl/dra.h               |   3 +
 .../reset/amlogic,meson8b-clkc-reset.h          |  27 +
 487 files changed, 22378 insertions(+), 2316 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/bhf.txt
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/armada-8kp.txt
 create mode 100644 Documentation/devicetree/bindings/sram/renesas,smp-sram.txt
 create mode 100644 arch/arm/boot/dts/am335x-moxa-uc-8100-me-t.dts
 create mode 100644 arch/arm/boot/dts/am57xx-beagle-x15-revc.dts
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1.dtsi
 create mode 100644 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts
 create mode 100644 arch/arm/boot/dts/bcm2835-rpi-zero-w.dts
 rename arch/{arm64/boot/dts/broadcom => arm/boot/dts}/bcm2837.dtsi (96%)
 create mode 100644 arch/arm/boot/dts/bcm947189acdbmr.dts
 create mode 100644 arch/arm/boot/dts/dra7-evm-common.dtsi
 create mode 100644 arch/arm/boot/dts/dra72x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/dra74x-mmc-iodelay.dtsi
 create mode 100644 arch/arm/boot/dts/dra76-evm.dts
 create mode 100644 arch/arm/boot/dts/dra76x.dtsi
 create mode 100644 arch/arm/boot/dts/gemini-dlink-dir-685.dts
 create mode 100644 arch/arm/boot/dts/imx53-cx9020.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-eval.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
 rename arch/arm/boot/dts/{imx6ul-geam.dtsi => imx6ul-geam.dts} (87%)
 delete mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi
 create mode 100644 arch/arm/boot/dts/mt6323.dtsi
 delete mode 100644 arch/arm/boot/dts/mt7623-evb.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb-nand.dts
 create mode 100644 arch/arm/boot/dts/mt7623n-rfb.dtsi
 rename arch/arm/boot/dts/{imx6ul-geam-kit.dts => rk3229.dtsi} (56%)
 create mode 100644 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
 create mode 100644 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
 delete mode 100644 arch/arm/boot/dts/uniphier-sld3-ref.dts
 delete mode 100644 arch/arm/boot/dts/uniphier-sld3.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/axp803.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm2835-rpi.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-smsc9514.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x-rpi-usb-host.dtsi
 delete mode 120000 arch/arm64/boot/dts/broadcom/bcm283x.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/northstar2/Makefile
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-clock.dtsi (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-svk.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2-xmc.dts (100%)
 rename arch/arm64/boot/dts/broadcom/{ => northstar2}/ns2.dtsi (100%)
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-fs4.dtsi
 create mode 100644 arch/arm64/boot/dts/broadcom/stingray/stingray-sata.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8080-db.dts
 create mode 100644 arch/arm64/boot/dts/marvell/armada-8080.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0-octa-core.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712-evb.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt2712e.dtsi
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt7622.dtsi
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
 create mode 100644 arch/arm64/boot/dts/qcom/ipq8074.dtsi
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77995-draak.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a77995.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire-excavator.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
 mode change 120000 => 100644 arch/arm64/boot/dts/socionext/uniphier-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
 mode change 120000 => 100644 arch/arm64/boot/dts/socionext/uniphier-ref-daughter.dtsi
 mode change 120000 => 100644 arch/arm64/boot/dts/socionext/uniphier-support-card.dtsi
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-pcbox.dts
 delete mode 100644 include/dt-bindings/genpd/k2g.h
 create mode 100644 include/dt-bindings/reset/amlogic,meson8b-clkc-reset.h
