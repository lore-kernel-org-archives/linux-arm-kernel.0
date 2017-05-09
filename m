From: olof@lixom.net (Olof Johansson)
Date: Mon,  8 May 2017 23:52:49 -0700
Subject: [GIT PULL 3/7] ARM: Device-tree updates
In-Reply-To: <1494312773-9790-1-git-send-email-olof@lixom.net>
References: <1494312773-9790-1-git-send-email-olof@lixom.net>
Message-ID: <1494312773-9790-4-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device-tree continues to see lots of updates. The majority of patches
here are smaller changes for new hardware on existing platforms, and
there are a few larger changes worth pointing out.

Major new platforms:

- Gemini has been ported to DT, so a handful of "new" platforms moved over
from board files
- Rockchip RK3288 support for Tinkerboard and Phytec phyCORE-RK3288 SoM and RDK
- A bunch of embedded platforms, several Linksys platforms, Synology DS116,
- Motorola Droid4 (really old OMAP-based phone) support is added.

Some refactorings, i.e. Allwinner H3/H5 support is commonalized.

And lots of smaller changes, cleanups, etc. See shortlog for more description

We're adding ability to cross-include DT files between arm and arm64,
by creating appropriate links in the dt-include directory, and using arm/
and arm64/ as include prefixes. This will avoid other local hacks such as
per-file links between the two arch trees (this broke for external mirroring
of DT contents). Now they can just provide their own appropriate dt-include
hierarcy per platform.

Conflicts:

arch/arm/boot/dts/stm32746g-eval.dts:
Add/add. Should be a status-okay entry for both rtc and crc.

arch/arm/boot/dts/rk3188.dtsi:
Add/change. Keep status line and symbolic version of interrupts.

arch/arm/boot/dts/r7s72100.dtsi:
Add/add. Keep both sides, make sure to add };
----------------------------------------------------------------

The following changes since commit a744eb00db32ffc0fafa001711391fbfd0d56ebc:

  Merge tag 'armsoc-soc' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-dt

for you to fetch changes up to b9f34da74e1c4b5f2574333277cd8d8f53bad056:

  Merge tag 'samsung-dt-4.12-2' of git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux into next/dt

----------------------------------------------------------------

Aditya Xavier (1):
      ARM: dts: BCM5301X: Add missing Netgear R8000 LEDs and Keys

Alexander Kochetkov (1):
      ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc for rk3188

Alexander Kurz (1):
      ARM: dts: imx50: imx50-esdhc use imx53-esdhc

Alexander Syring (1):
      ARM: sun7i: cubietruck: enable ACIN und USB power supply subnode

Alexandre Belloni (2):
      ARM: dts: at91: sama5d2: add sfrbu
      ARM: dts: at91: sama5d2_xplained: enable RTC wakeup

Alexandre Courbot (1):
      dt-bindings: Add documentation for GP10B GPU

Alexandre TORGUE (1):
      ARM: dts: stm32: Add STM32H743 MCU and STM32H743i-EVAL board

Amelie Delaunay (3):
      ARM: dts: stm32: set HSE_RTC clock frequency to 1 MHz on stm32f746
      ARM: dts: stm32: Add RTC support for STM32F746 MCU
      ARM: dts: stm32: enable RTC on stm32746g-eval

Andre Przywara (1):
      arm: sun8i: h3: split Allwinner H3 .dtsi

Andrew Lunn (2):
      ARM: dts: vf610-zii-dev: Wire up devel C switch interrupts
      ARM: dts: vf610-zii-dev-c: Wire up PHY interrupts

Andrey Smirnov (1):
      ARM: dts: imx7s: Do not claim i.MX51 compatibility for SRC

Andy Gross (1):
      Revert "ARM: dts: qcom: msm8974: Add USB gadget nodes"

Ansuel Smith (1):
      ARM: dts: armada: Add default trigger for sata led

Antoine Tenart (3):
      ARM: dts: alpine: remove 0x's from the uart1 node unit address
      ARM: dts: alpine: add spaces before the uart node units.
      ARM: dts: alpine: add valid clock-frequency values

Arnd Bergmann (10):
      Merge tag 'uniphier-dt-v4.12' of git://git.kernel.org/.../masahiroy/linux-uniphier into next/dt
      Merge tag 'davinci-for-v4.12/dt' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'mvebu-dt-4.12-1' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'arm-soc/for-4.12/devicetree' of http://github.com/Broadcom/stblinux into next/dt
      Merge tag 'gemini-dts-2' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge tag 'v4.12-rockchip-dts32-1' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'omap-for-v4.12/dt-v2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'arm-soc/for-4.11/devicetree-fixes' of http://github.com/Broadcom/stblinux into fixes
      Merge tag 'vexpress-dt-4.12' of git://git.kernel.org/.../sudeep.holla/linux into next/dt
      Merge tag 'samsung-dt-4.12-2' of git://git.kernel.org/.../krzk/linux into next/dt

Bartosz Golaszewski (6):
      ARM: dts: da850-evm: fix whitespace errors
      ARM: dts: da850: add vpif video display pins
      ARM: dts: da850-evm: add IO expander node on UI card
      ARM: dts: da850-evm: add the output port to the vpif node
      ARM: dts: dm8168-evm: add the external reference clock for SATA
      ARM: dts: dm8168-evm: add SATA node

Boris Brezillon (2):
      ARM: dts: at91: Fix matrix compatible
      ARM: dts: bcm283x: Add HDMI audio related properties

Bruno Herrera (4):
      ARM: dts: stm32: Add USB FS support for STM32F429 MCU
      ARM: dts: stm32: Enable USB FS on stm32f469-disco
      ARM: dts: stm32: Enable USB HS in FS mode (embedded phy) on stm32f429-disco
      dt-bindings: Document the STM32 USB OTG DWC2 core binding

Chen-Yu Tsai (5):
      ARM: dts: sun8i-a23-q8-tablet: Drop pinmux setting for codec PA gpio
      ARM: dts: sunxi: Remove no longer used pinctrl/sun4i-a10.h header
      ARM: dts: sun6i: sina31s: Enable SPDIF out
      dt-bindings: display: sun4i: Add display backend interrupt to device tree binding
      ARM: dts: sun5i: Add interrupt for display backend

Chris Brandt (9):
      ARM: dts: r7s72100: update sdhi clock bindings
      ARM: dts: r7s72100: Add watchdog timer
      ARM: dts: r7s72100: add power-domains to sdhi
      ARM: dts: r7s72100: fix ethernet clock parent
      ARM: dts: r7s72100: add rtc clock to device tree
      ARM: dts: r7s72100: add RTC_X clock inputs to device tree
      ARM: dts: r7s72100: add rtc to device tree
      ARM: dts: rskrza1: set rtc_x1 clock value
      ARM: dts: rskrza1: add rtc DT support

Chris Packham (5):
      ARM: dts: armada-38x add node labels
      ARM: dts: armada-xp-98dx3236: combine dfx server nodes
      ARM: dts: Use armada-370-xp as a base for armada-xp-98dx3236
      ARM: dts: mvebu: Move mv98dx3236 clock bindings
      ARM: dts: mvebu: remove unnecessary PCI range from 98dx3236

Christopher Spinrath (1):
      ARM: dts: imx6q-utilite-pro: add hpd gpio

Cristian Birsan (1):
      ARM: dts: at91: Disable SPI on at91sam9x5ek to allow MCI1 to work.

C?dric Le Goater (3):
      ARM: dts: aspeed: add SPI controller bindings
      ARM: dts: aspeed: Add SPI controller bindings to Romulus
      ARM: dts: aspeed: Add a fastread property

Dave Gerlach (4):
      ARM: dts: am33xx: Add updated operating-points-v2 table for cpu
      ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu
      ARM: dts: am4372: Update operating-points-v2 table for cpu
      ARM: dts: dra7: Add updated operating-points-v2 table for cpu

David Lechner (3):
      ARM: da850-lego-ev3: Add device tree node for A/DC
      ARM: da850-lego-ev3: Add device tree node for sound
      ARM: dts: da850: move spi0_cs3_pin pinconf node

Eddie Cai (2):
      dt-bindings: add rk3288-based Asus Tinker board
      ARM: dts: rockchip: add dts for RK3288-Tinker board

Emmanuel Vadot (1):
      ARM: dts: sunxi: Add regulators for Sinovoip BPI-M2

Eric Anholt (1):
      ARM: dts: bcm2835: Add the DSI module nodes and clocks.

Ezequiel Garcia (1):
      ARM: dts: sun7i: Use axp209.dtsi on A20-OLinuXino-Micro

Fabio Estevam (3):
      ARM: dts: imx6ul-14x14-evk: Remove unnecessary node
      ARM: dts: imx53-qsb: Constrain the TVE DAC voltage
      ARM: dts: imx6sx: Make UART compatible to 'imx6q-uart'

Fabrice Gasnier (2):
      ARM: dts: stm32: Enable dma by default on stm32f4 adc
      ARM: dts: stm32: Enable pwm1 and pwm3 on stm32f429i-eval

Florian Fainelli (1):
      Merge tag 'bcm2835-dt-next-2017-03-21' into devicetree/next

Florian Vaussard (8):
      ARM: dts: socfpga: Add unit name to clock nodes
      ARM: dts: socfpga: Add unit name to memory nodes
      ARM: dts: socfpga: Remove unneeded unit names
      ARM: dts: socfpga: Remove unneeded reg from stmpe_touchscreen
      ARM: dts: socfpga: Remove unit name for LEDs in EBV SOCrates
      ARM: dts: socfpga: Do not include skeleton.dtsi
      ARM: dts: socfpga: Add labels for CPU nodes
      ARM: dts: socfpga: Add support for PMU

Franklin S Cooper Jr (1):
      ARM: dts: am335x-icev2: Add SPI based NOR

Gabriel Fernandez (2):
      ARM: dts: stm32: Enable clocks for STM32F746 MCU
      dt-bindings: mfd: Add STM32F7 RCC numeric constants into DT include file

Gary Bisson (1):
      ARM: dts: imx6qp-nitrogen6_som2: add Quad Plus variant of the SOM

Geert Uytterhoeven (42):
      ARM: dts: r8a7743: Fix SCIFB0 dmas indentation
      ARM: dts: r8a7745: Fix SCIFB0 dmas indentation
      ARM: dts: renesas: Switch from ARCH_SHMOBILE_MULTI to ARCH_RENESAS
      ARM: dts: r8a73a4: Remove unit-addresses and regs from integrated caches
      ARM: dts: r8a7743: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7745: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7790: Remove unit-addresses and regs from integrated caches
      ARM: dts: r8a7791: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7792: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7793: Remove unit-address and reg from integrated cache
      ARM: dts: r8a7794: Remove unit-address and reg from integrated cache
      ARM: dts: r8a73a4: Add INTC-SYS clock to device tree
      ARM: dts: r8a7790: Add INTC-SYS clock to device tree
      ARM: dts: r8a7791: Add INTC-SYS clock to device tree
      ARM: dts: r8a7792: Add INTC-SYS clock to device tree
      ARM: dts: r8a7794: Add INTC-SYS clock to device tree
      ARM: dts: r8a7793: Add INTC-SYS clock to device tree
      ARM: dts: porter: Always use status "okay" to enable devices
      ARM: dts: bockw: Drop superfluous status update for frequency override
      ARM: dts: marzen: Drop superfluous status update for frequency override
      ARM: dts: lager: Drop superfluous status update for frequency override
      ARM: dts: koelsch: Drop superfluous status updates for frequency overrides
      ARM: dts: porter: Drop superfluous status update for frequency override
      ARM: dts: gose: Drop superfluous status update for frequency override
      ARM: dts: alt: Drop superfluous status update for frequency override
      ARM: dts: silk: Drop superfluous status update for frequency override
      ARM: shmobile: Document RZ/G1H SoC DT binding
      ARM: shmobile: Document RZ/G1N SoC DT binding
      ARM: dts: r8a7743: Add reset control properties
      ARM: dts: r8a7745: Add reset control properties
      ARM: dts: r8a7794: Add DU1 clock to device tree
      ARM: dts: r8a7794: Correct clock of DU1
      ARM: dts: alt: Correct clock of DU1
      ARM: dts: silk: Correct clock of DU1
      ARM: dts: r8a7790: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7791: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7793: Correct parent of SSI[0-9] clocks
      ARM: dts: r8a7792: Correct Z clock
      ARM: dts: r8a7794: Add Z2 clock
      ARM: dts: koelsch: Correct clock frequency of X2 DU clock input
      ARM: dts: r8a7790: Drop _clk suffix from external CAN clock node name
      ARM: dts: r8a7791: Drop _clk suffix from external CAN clock node name

Georgi Djakov (1):
      ARM: dts: qcom: msm8974: Add RPMCC DT node

Gerd Hoffmann (1):
      ARM: dts: bcm2835: add sdhost controller to devicetree

Gregory CLEMENT (1):
      ARM: dts: armada-38x: Adjust mbus controller description on Armada 38x

Hans Verkuil (1):
      ARM: dts: exynos: add HDMI controller phandle to exynos4.dtsi

Heiko Stuebner (7):
      ARM: dts: rockchip: add rk3288 dw-mmc resets
      ARM: dts: rockchip: add rk3036 dw-mmc resets
      ARM: dts: rockchip: add rk3066/rk3188 dw-mmc resets
      ARM: dts: rockchip: add rk322x dw-mmc resets
      ARM: dts: add arm/arm64 include symlinks
      arm64: dts: add arm/arm64 include symlinks
      ARM: dts: rockchip: fix PPI misconfiguration on Cortex-A9 socs

Hoegeun Kwon (1):
      ARM: dts: exynos: Add the burst and esc clock frequency properties to DSI node

Icenowy Zheng (6):
      arm: sun8i: h3: drop skeleton.dtsi inclusion in H3 DTSI
      arm: sun8i: h3: drop pinctrl-a10.h inclusion for H3 DTSI
      arm: sun8i: h3: correct the GIC compatible in H3 to gic-400
      ARM: sunxi: h3/h5: add usb_otg and OHCI/EHCI for usbc0 on H3/H5
      ARM: sun8i: h3: enable USB OTG on Orange Pi One
      ARM: sun8i: h2+: enable USB OTG for Orange Pi Zero board

Ivan T. Ivanov (1):
      ARM: dts: qcom: Add msm8974 CoreSight components

Jacopo Mondi (1):
      ARM: dts: genmai: Enable rtc and rtc_x1 clock

Jaehoon Chung (1):
      ARM: dts: exynos: Add phy-pcie node for pcie to Exynos5440

Jagan Teki (11):
      ARM: dts: imx6qdl-icore: Add backlight support for lvds
      ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 10.1 initial support
      ARM: dts: imx6q: Add Engicam i.CoreM6 Quad/Dual OpenFrame Cap 12.3 initial support
      ARM: dts: imx6q-icore: Add LVDS support
      ARM: dts: imx6ul-geam: Add backlight support for lcdif
      ARM: dts: imx6ul-isiot: Add backlight support for lcdif
      ARM: dts: imx6ul-isiot: Add imx6ul-isiot-common.dtsi
      ARM: dts: imx6ul-isiot: Add i2c nodes
      ARM: dts: imx6ul-isiot-common: Add touchscreen node
      ARM: dts: imx6ul-[geam|isiot]: Add sai2 node
      ARM: dts: imx6q-icore: Add touchscreen node

Jelle van der Waa (1):
      ARM: dts: sun8i: Add dts file for NanoPi NEO Air

Joel Stanley (3):
      ARM: dts: aspeed: Make G5 clocks fixed
      ARM: dts: aspeed: Make G4 clocks fixed
      ARM: dts: aspeed: Update watchdog compatible strings

Jon Hunter (1):
      dt-bindings: tegra: Update compatible strings for Tegra flowctrl

Jon Mason (7):
      ARM: dts: BCM5301X: Add NAND entries to bcm953012k
      ARM: dts: BCM5301X: convert to iProc QSPI
      ARM: dts: BCM5301X: Correct GIC_PPI interrupt flags
      ARM: dts: BCM5301X: Add TWD WD Support to DT
      ARM: dts: BCM5301X: Add I2C support to the DT
      ARM: dts: NSP: Add EHCI/OHCI USB nodes to device tree
      ARM: dts: NSP: disable i2c DT entry by default

Jonathan Liu (1):
      ARM: sun7i: Enable audio codec on A20-OLinuXino-Micro

Jonathan Neusch?fer (1):
      ARM: dts: msm8974: Hook up adsp-pil's xo clock

Keerthy (5):
      ARM: dts: omap3: Add cpu_thermal zone
      ARM: dts: DRA7: Thermal: Add slope and offset values
      ARM: dts: OMAP5: Thermal: Add slope and offset values
      ARM: dts: OMAP443x: Thermal: Add slope and offset values
      ARM: dts: OMAP4460: Thermal: Add slope and offset values

Ken Lin (2):
      ARM: dts: imx6q-bx50v3: change pca953x GPIO default settings
      ARM: dts: imx6q-bx50v3: fix at25 spi-clk frequency issue

Krzysztof Kozlowski (8):
      ARM: dts: exynos: Do not ignore real-world fuse values for thermal zone 0 on Exynos5420
      ARM: dts: exynos: Fix watchdog reset on Exynos4412
      ARM: dts: s3c64xx: Enable watchdog on all S3C64xx boards
      ARM: dts: exynos: Enable watchdog on all Exynos4 boards
      ARM: dts: exynos: Fix infinite interrupt in soft mode on Exynos4210 and Exynos5440
      ARM: dts: s3c64xx: Fix infinite interrupt in soft mode
      ARM: dts: s5pv210: Fix infinite interrupt in soft mode
      Merge tag 'samsung-dt-hdmi-cec-4.12' into next/dt

Kuninori Morimoto (3):
      ARM: dts: r8a7790: Tidyup Audio-DMAC channel for DVC
      ARM: dts: r8a7791: Tidyup Audio-DMAC channel for DVC
      ARM: dts: r8a7793: Tidyup Audio-DMAC channel for DVC

Ladislav Michl (1):
      ARM: dts: omap3-igep: OneNAND support

Lei YU (1):
      ARM: dts: aspeed: romulus: Add UART1

Leonard Crestez (2):
      ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
      ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply

Linus Walleij (15):
      ARM: dts: add top-level DT bindings for Cortina Gemini
      ARM: dts: add device tree for Gemini SoC and SQ201
      ARM: dts: add a devicetree for Raidsonic NAS IB-4220-B
      ARM: dts: add a devicetree for Teltonika RUT1xx
      ARM: dts: add a devicetree for Wiliboard WBD-111
      ARM: dts: add a devicetree for Wiliboard WBD-222
      watchdog: add DT bindings for Cortina Gemini
      ARM: dts: add watchdog to the Gemini
      ARM: dts: add power controller to the Gemini DTS
      ARM: dts: Adjust moxart IRQ controller and flags
      ARM: dts: augment Gemini GPIO nodes
      ARM: dts: add PCI to the Gemini device trees
      ARM: dts: add SDC2 and SDC4 to the MSM8660 family
      ARM: dts: fix typo on APQ8060 Dragonboard
      ARM: dts: augment Moxa ART GPIO node

Loic Pallardy (1):
      ARM: dts: STiH407-family: update rproc node names to avoid conflict

Lucas Stach (6):
      ARM: dts: imx6qp: reference PCIe node by handle
      ARM: dts: imx6qp: reference MMDC node by handle and remove duplication
      ARM: dts: imx6qp: correct IPU nodes
      ARM: dts: imx6qp: add PRE nodes
      ARM: dts: imx6qp: add PRG nodes and hook up to IPUs
      ARM: dts: imx6: add ZII RDU2 boards

Ludovic Desroches (2):
      ARM: dts: at91: sama5d3_xplained: fix ADC vref
      ARM: dts: at91: sama5d3_xplained: not all ADC channels are available

Marco Franchi (1):
      ARM: dts: imx7d-sdb: Add sht11 Click Board support

Marcus Cooper (1):
      ARM: dts: sun8i-h3: Add mmc2 node to the X2

Martin Kaiser (1):
      ARM: dts: i.MX25: add AIPS control registers

Masahiro Yamada (6):
      ARM: dts: uniphier: remove skeleton.dtsi inclusion
      ARM: dts: uniphier: fix no unit name warnings
      ARM: dts: uniphier: move memory node below aliases node
      ARM: dts: uniphier: fix pin groups of eMMC pin-mux node
      ARM: dts: uniphier: add pagesize property to EEPROM of Support Card
      ARM: dts: uniphier: add pagesize property to EEPROM of proto boards

Maxime Ripard (12):
      ARM: sun5i: A10s: Switch the EMAC pins indices
      ARM: sun5i: a10s: switch simple framebuffer indices
      ARM: sun5i: Add UART2 pin group
      ARM: sun5i: Rename UART3 flow control pins
      ARM: sun5i: a13: Merge common controllers into the common DTSI
      ARM: sun5i: a10s: Merge common controllers into the common DTSI
      ARM: sun5i: r8: Merge common controllers into the common DTSI
      ARM: sun5i: gr8: Use common sun5i DTSI
      dt-bindings: gpu: mali: Add optional memory-region
      dt-bindings: gpu: mali: Add optional OPPs
      ARM: sun8i: a33: Add the Mali OPPs
      ARM: sun8i: a33: Add devfreq-based GPU cooling

Michael Heimpold (9):
      ARM: dts: imx28: add alternative pinmuxing for mmc2
      ARM: dts: imx28: rename mmc2_sck_cfg
      ARM: dts: imx28: add alternative muxing for mmc2_sck_cfg
      ARM: dts: imx28-duckbill: update to match vendor distributed DT
      dt-bindings: arm: add entries for I2SE boards
      ARM: dts: add support for I2SE Duckbill 2 boards
      ARM: dts: add support for I2SE Duckbill 2 485
      ARM: dts: add support for I2SE Duckbill 2 EnOcean
      ARM: dts: add support for I2SE Duckbill 2 SPI

Nobuhiro Iwamatsu (1):
      ARM: dts: socfpga: sodia: enable qspi

Olof Johansson (22):
      Merge tag 'gemini-dts-base' of git://git.kernel.org/.../linusw/linux-nomadik into next/dt
      Merge branch 'shared/dt-symlinks' into next/dt
      Merge tag 'renesas-dt-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'renesas-dt-bindings-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge branch 'sti-dt-for-v4.12-round1' of git://git.kernel.org/.../pchotard/sti into next/dt
      Merge tag 'stm32-dt-for-v4.12-1' of git://git.kernel.org/.../atorgue/stm32 into next/dt
      Merge tag 'davinci-for-v4.12/dt-2' of git://git.kernel.org/.../nsekhar/linux-davinci into next/dt
      Merge tag 'socfpga_dts_for_v4.12' of git://git.kernel.org/.../dinguyen/linux into next/dt
      Merge tag 'sunxi-dt-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'sunxi-dt-h3-for-4.12' of https://git.kernel.org/.../sunxi/linux into next/dt
      Merge tag 'tegra-for-4.12-dt-bindings' of git://git.kernel.org/.../tegra/linux into next/dt
      Merge tag 'qcom-dts-for-4.12' of git://git.kernel.org/.../agross/linux into next/dt
      Merge tag 'renesas-dt2-for-v4.12' of https://git.kernel.org/.../horms/renesas into next/dt
      Merge tag 'mvebu-dt-4.12-2' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'samsung-dt-4.12' of git://git.kernel.org/.../krzk/linux into next/dt
      Merge tag 'v4.12-rockchip-dts32-2' of git://git.kernel.org/.../mmind/linux-rockchip into next/dt
      Merge tag 'imx-dt-4.12' of git://git.kernel.org/.../shawnguo/linux into next/dt
      Merge tag 'at91-ab-4.12-dt' of git://git.kernel.org/.../abelloni/linux into next/dt
      Merge tag 'omap-for-v4.12/dt-pt2-signed' of git://git.kernel.org/.../tmlind/linux-omap into next/dt
      Merge tag 'aspeed-4.12-devicetree' of git://git.kernel.org/.../joel/aspeed into next/dt
      Merge tag 'mvebu-dt-4.12-3' of git://git.infradead.org/linux-mvebu into next/dt
      Merge tag 'alpine-dt-for-4.12' of https://git.kernel.org/.../atenart/linux into next/dt

Patrice Chotard (1):
      ARM: dts: STiH407-family: fix spi nodes

Patrick Menschel (6):
      ARM: dts: sun4i: Add CAN node
      ARM: dts: sun4i: Add can0_pins_a pinctrl settings
      ARM: dts: sun7i: Add CAN node
      ARM: dts: sun7i: Add can0_pins_a pinctrl settings
      ARM: dts: sun4i: fix device node ordering
      ARM: dts: sun7i: fix device node ordering

Peng Fan (1):
      ARM: dts: imx7s: enable ocotp

Peter Rosin (1):
      ARM: dts: at91: add envelope detector mux to the Axentia TSE-850

Peter Senna Tschudin (1):
      ARM: dts: imx6q-b850v3: Use megachips-stdpxxxx-ge-b850v3-fw bridges (LVDS-DP++)

Quentin Schulz (9):
      ARM: dtsi: axp209: add AC power supply subnode
      ARM: dtsi: axp22x: add AC power supply subnode
      ARM: dts: sun8i: sina33: enable ACIN power supply subnode
      ARM: sun5i: chip: enable ACIN power supply subnode
      ARM: sun8i: a33: add all operating points
      ARM: sun8i: sina33: add cpu-supply
      ARM: sun8i: a33: add thermal sensor
      ARM: sun8i: a33: add CPU thermal throttling
      ARM: sun8i: sina33: add highest OPP of CPUs

Rafa? Mi?ecki (11):
      ARM: dts: BCM5301X: Add basic DT for Linksys EA9200
      ARM: dts: BCM5301X: Add basic DT for Linksys EA6300 V1
      ARM: dts: BCM5301X: Add basic DT for Linksys EA9500
      ARM: dts: BCM53573: Describe Tenda AC9 PCIe card in DT
      ARM: dts: BCM53573: Add Tenda AC9 2 GHz LED
      ARM: dts: BCM5301X: Relicense DTS files I created to the ISC
      ARM: dts: BCM53573: Don't use nonexistent "default-off" LED trigger
      ARM: dts: BCM5301X: Don't use nonexistent "default-off" LED trigger
      ARM: dts: BCM5301X: Add support for TP-LINK Archer C5 V2
      ARM: dts: BCM5301X: Specify serial console params in dtsi files
      ARM: dts: BCM53573: Specify serial console parameters

Ralph Sennhauser (4):
      ARM: dts: armada-385: add support for the Linksys WRT1900ACS (Shelby)
      ARM: dts: mvebu: linksys: enable buffer manager support
      ARM: dts: armada-385-linksys: disk-activity trigger for all
      ARM: dts: armada-38x: label USB and SATA nodes

Rick Altherr (1):
      arm: dts: aspeed: Describe ADCs for AST2400/AST2500

Rob Herring (3):
      ARM: dts: bcm: fix msi-controller name and unit address
      ARM: dts: alpine: fix PCIe node name
      ARM: dts: imx: fix PCI bus dtc warnings

Roger Quadros (1):
      ARM: dts: am335x-icev2: Add CPSW ethernet0 and ethernet1

Romain Perier (1):
      ARM: dts: rockchip: Add support for ES8388 to the Radxa Rock 2

Russell King (1):
      ARM: dts: clearfog: keep dts alphabetically ordered

Schuyler Patton (1):
      ARM: dts: am57xx-idk: Add DCAN support

Sebastian Reichel (8):
      ARM: dts: omap4-droid4: Add gpio-keys
      ARM: dts: motorola-cpcap-mapphone: add rtc
      ARM: dts: motorola-cpcap-mapphone: add pwrbutton
      ARM: dts: omap4-droid4: Add compass
      ARM: dts: omap4-droid4: Add accelerometer
      ARM: dts: motorola-cpcap-mapphone: add LEDs
      ARM: dts: N900: Add bluetooth
      ARM: dts: N9/N950: add bluetooth

Sekhar Nori (1):
      Documentation: devicetree: mtd: add w25q64 to list of supported SPI flashes

Sjoerd Simons (1):
      ARM: dts: rockchip: Enable sata support on rock2 square

Stefan Agner (5):
      ARM: dts: imx7-colibri: use OF graph to describe the display
      ARM: dts: imx7-colibri: fix PMIC voltages
      ARM: dts: imx7-colibri: allow to disable Ethernet rail
      ARM: dts: imx7-colibri: remove 1.8V fixed regulator
      ARM: dts: imx7-colibri: add Carrier Board 3.3V/5V regulators

Steve Lin (4):
      ARM: dts: BCM5301X: Add support for BCM953012HR
      ARM: dts: BCM953012HR: Add ethernet aliases
      ARM: dts: NSP: Add mailbox (PDC) to NSP
      ARM: dts: NSP: Add crypto (SPU) to dtsi

Sudeep Holla (1):
      ARM: dts: vexpress: fix few unit address format warnings

Thomas Petazzoni (6):
      arm: spear6xx: add labels to various nodes in spear600.dtsi
      arm: spear6xx: use node labels in spear600-evb.dts
      arm: spear6xx: fix spaces in spear600-evb.dts
      arm: spear6xx: switch spear600-evb to the new flash partition DT binding
      arm: spear6xx: remove unneeded pinctrl properties in spear600-evb
      arm: spear6xx: add DT description of the ADC on SPEAr600

Thor Thayer (1):
      ARM: dts: socfpga: Add Devkit A10-SR Reset Controller

Tim Harvey (2):
      ARM: dts: imx: add Gateworks Ventana GW5904 support
      ARM: dts: imx: add Gateworks Ventana GW5903 support

Tony Lindgren (17):
      ARM: dts: Add keypad support for droid 4
      ARM: dts: Configure regulators for droid 4
      ARM: dts: omap4-droid4: Add touchscreen
      ARM: dts: omap4-droid4: Add LCD backlight
      ARM: dts: omap4-droid4: Add GPIO poweroff
      ARM: dts: omap4-droid4: Add tmp105 sensor for droid 4
      ARM: dts: omap4-droid4: Add HDMI support
      ARM: dts: omap4-droid4: Add LCD
      ARM: dts: omap4-droid4: Configure EHCI so modems can be accessed
      ARM: dts: omap4-droid4: Fix MMC1 card for detect GPIO and regulator
      Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2
      ARM: dts: omap4-droid4: Fix interrupt triggering for cpcap
      ARM: dts: omap4-droid4: Stop disabling SRAM and GPMC
      ARM: dts: omap4-droid4: Add CPCAP PMIC ADC configuration
      ARM: dts: omap4-droid4: Add CPCAP PMIC battery charger configuration
      ARM: dts: omap4-droid4: Add CPCAP PMIC OTG PHY configuration
      Merge branch 'omap-for-v4.12/dt-droid4-v2' into omap-for-v4.12/dt-v2

Uwe Kleine-K?nig (3):
      ARM: imx25: set default phy_type and dr_mode for usbotg port
      ARM: dts: imx25-pinfunc: remove duplicate definition
      ARM: dts: imx25-pinfunc: Move MX25_PAD_TDO__TDO to a more sensible place

Valentin Raevsky (1):
      ARM: dts: imx6q-cm-fx6: add analog audio support

Vignesh R (1):
      ARM: dts: am437x-gp-evm: Add pinmux for uart0

Viresh Kumar (1):
      ARM: dts: exynos: Use - instead of @ for DT OPP entries

Vivien Didelot (1):
      ARM: dts: vf610-zii-dev-rev-b: change switch2 label

Wadim Egorov (3):
      ARM: dts: rockchip: Add support for phyCORE-RK3288 SoM
      dt-bindings: Document Phytec phyCORE-RK3288 RDK
      ARM: dts: rockchip: Add support for PCM-947 carrier board

Willy Tarreau (2):
      ARM: dts: rockchip: fix the MiQi board's LED definition
      ARM: dts: armada-385-synology-ds116: add support for Synology DS116 NAS

Yegor Yefremov (2):
      ARM: dts: AM35x: Add hecc node
      ARM: dts: am335x-baltos: add LED support


 .../devicetree/bindings/arm/atmel-at91.txt      |   3 +-
 .../devicetree/bindings/arm/gemini.txt          |  86 ++
 Documentation/devicetree/bindings/arm/i2se.txt  |  22 +
 .../devicetree/bindings/arm/rockchip.txt        |   7 +
 .../devicetree/bindings/arm/shmobile.txt        |   4 +
 .../arm/tegra/nvidia,tegra20-flowctrl.txt       |   8 +-
 .../bindings/clock/mvebu-core-clock.txt         |   7 +
 .../bindings/clock/mvebu-gated-clock.txt        |  11 +
 .../devicetree/bindings/devfreq/exynos-bus.txt  |  46 +-
 .../bindings/display/sunxi/sun4i-drm.txt        |   2 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt |   8 +
 .../devicetree/bindings/gpu/nvidia,gk20a.txt    |  25 +-
 .../devicetree/bindings/mtd/jedec,spi-nor.txt   |   1 +
 .../bindings/net/marvell,prestera.txt           |  13 +-
 Documentation/devicetree/bindings/usb/dwc2.txt  |   4 +
 .../watchdog/cortina,gemini-watchdog.txt        |  17 +
 arch/arm/boot/dts/Makefile                      |  73 +-
 arch/arm/boot/dts/alpine.dtsi                   |  20 +-
 arch/arm/boot/dts/am335x-baltos-ir2110.dts      |   1 +
 arch/arm/boot/dts/am335x-baltos-ir3220.dts      |   1 +
 arch/arm/boot/dts/am335x-baltos-ir5221.dts      |   1 +
 arch/arm/boot/dts/am335x-baltos-leds.dtsi       |  50 +
 arch/arm/boot/dts/am335x-boneblack.dts          |  11 +
 arch/arm/boot/dts/am335x-icev2.dts              | 154 +++
 arch/arm/boot/dts/am33xx.dtsi                   |  87 +-
 arch/arm/boot/dts/am3517.dtsi                   |  12 +
 arch/arm/boot/dts/am4372.dtsi                   |   7 +-
 arch/arm/boot/dts/am437x-gp-evm.dts             |  15 +
 arch/arm/boot/dts/am57xx-idk-common.dtsi        |  24 +
 arch/arm/boot/dts/armada-385-linksys-shelby.dts | 114 +++
 arch/arm/boot/dts/armada-385-linksys.dtsi       |  18 +-
 arch/arm/boot/dts/armada-385-synology-ds116.dts | 321 +++++++
 arch/arm/boot/dts/armada-385.dtsi               |  20 +-
 arch/arm/boot/dts/armada-388-clearfog.dts       |  38 +-
 arch/arm/boot/dts/armada-388.dtsi               |   9 +-
 arch/arm/boot/dts/armada-38x.dtsi               |  49 +-
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi       | 211 +++--
 arch/arm/boot/dts/armada-xp-98dx3336.dtsi       |   2 +-
 arch/arm/boot/dts/armada-xp-98dx4251.dtsi       |   2 +-
 arch/arm/boot/dts/armada-xp-db-dxbc2.dts        |   2 +-
 arch/arm/boot/dts/armada-xp-db-xc3-24g4xg.dts   |   2 +-
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts   |  18 +-
 arch/arm/boot/dts/aspeed-ast2500-evb.dts        |  22 +
 arch/arm/boot/dts/aspeed-bmc-opp-palmetto.dts   |  18 +
 arch/arm/boot/dts/aspeed-bmc-opp-romulus.dts    |  36 +
 arch/arm/boot/dts/aspeed-g4.dtsi                | 109 ++-
 arch/arm/boot/dts/aspeed-g5.dtsi                | 156 +++-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts     |   1 +
 arch/arm/boot/dts/at91-sama5d3_xplained.dts     |   5 +-
 arch/arm/boot/dts/at91-tse850-3.dts             |  29 +-
 arch/arm/boot/dts/at91sam9261.dtsi              |   2 +-
 arch/arm/boot/dts/at91sam9x5ek.dtsi             |   2 +-
 arch/arm/boot/dts/axp209.dtsi                   |   5 +
 arch/arm/boot/dts/axp22x.dtsi                   |   5 +
 arch/arm/boot/dts/bcm-cygnus.dtsi               |   4 +-
 arch/arm/boot/dts/bcm-nsp.dtsi                  |  36 +-
 arch/arm/boot/dts/bcm2835-rpi.dtsi              |  14 +
 arch/arm/boot/dts/bcm283x.dtsi                  |  60 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac56u.dts     |  17 +-
 arch/arm/boot/dts/bcm4708-asus-rt-ac68u.dts     |  14 +-
 .../boot/dts/bcm4708-buffalo-wzr-1750dhp.dts    |   5 -
 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts |  41 +
 arch/arm/boot/dts/bcm4708-netgear-r6250.dts     |   3 -
 arch/arm/boot/dts/bcm4708-netgear-r6300-v2.dts  |  15 +-
 arch/arm/boot/dts/bcm4708-smartrg-sr400ac.dts   |  10 -
 arch/arm/boot/dts/bcm4708.dtsi                  |   8 +
 arch/arm/boot/dts/bcm47081-asus-rt-n18u.dts     |  14 +-
 .../boot/dts/bcm47081-buffalo-wzr-600dhp2.dts   |  16 +-
 .../boot/dts/bcm47081-buffalo-wzr-900dhp.dts    |  12 +-
 .../boot/dts/bcm47081-tplink-archer-c5-v2.dts   |  98 ++
 arch/arm/boot/dts/bcm47081.dtsi                 |  20 +-
 arch/arm/boot/dts/bcm4709-asus-rt-ac87u.dts     |  14 +-
 .../boot/dts/bcm4709-buffalo-wxr-1900dhp.dts    |   8 -
 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts    |  42 +
 arch/arm/boot/dts/bcm4709-netgear-r7000.dts     |  19 +-
 arch/arm/boot/dts/bcm4709-netgear-r8000.dts     |  41 +-
 .../boot/dts/bcm4709-tplink-archer-c9-v1.dts    |   8 -
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts   |  18 +-
 arch/arm/boot/dts/bcm47094-linksys-panamera.dts |  36 +
 arch/arm/boot/dts/bcm47094-luxul-xwr-3100.dts   |   8 -
 arch/arm/boot/dts/bcm47094-netgear-r8500.dts    |   6 -
 arch/arm/boot/dts/bcm47189-tenda-ac9.dts        |  39 +-
 arch/arm/boot/dts/bcm5301x.dtsi                 |  79 +-
 arch/arm/boot/dts/bcm53573.dtsi                 |  10 +-
 arch/arm/boot/dts/bcm94708.dts                  |   8 -
 arch/arm/boot/dts/bcm94709.dts                  |   8 -
 arch/arm/boot/dts/bcm953012er.dts               |   8 -
 arch/arm/boot/dts/bcm953012hr.dts               |  97 ++
 arch/arm/boot/dts/bcm953012k.dts                |  62 +-
 arch/arm/boot/dts/bcm958522er.dts               |  10 +-
 arch/arm/boot/dts/bcm958525er.dts               |  10 +-
 arch/arm/boot/dts/bcm958525xmc.dts              |  10 +
 arch/arm/boot/dts/bcm958622hr.dts               |  10 +-
 arch/arm/boot/dts/bcm958623hr.dts               |  10 +-
 arch/arm/boot/dts/bcm958625hr.dts               |   8 +
 arch/arm/boot/dts/bcm958625k.dts                |   8 +
 arch/arm/boot/dts/bcm988312hr.dts               |  10 +-
 arch/arm/boot/dts/da850-evm.dts                 |  31 +-
 arch/arm/boot/dts/da850-lego-ev3.dts            |  59 +-
 arch/arm/boot/dts/da850.dtsi                    |  31 +-
 arch/arm/boot/dts/dm8168-evm.dts                |  10 +
 arch/arm/boot/dts/dm816x.dtsi                   |   7 +
 arch/arm/boot/dts/dra7.dtsi                     |  41 +-
 arch/arm/boot/dts/dra74x.dtsi                   |   5 +
 arch/arm/boot/dts/exynos3250-rinato.dts         |   2 +
 arch/arm/boot/dts/exynos3250.dtsi               |  46 +-
 arch/arm/boot/dts/exynos4.dtsi                  |   9 -
 arch/arm/boot/dts/exynos4210-origen.dts         |   4 -
 arch/arm/boot/dts/exynos4210-trats.dts          |   2 +
 arch/arm/boot/dts/exynos4210.dtsi               |  40 +-
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi |   4 -
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   4 -
 arch/arm/boot/dts/exynos4412-origen.dts         |   4 -
 arch/arm/boot/dts/exynos4412-prime.dtsi         |   4 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         |   2 +
 arch/arm/boot/dts/exynos4412.dtsi               |  75 +-
 .../boot/dts/exynos5420-tmu-sensor-conf.dtsi    |  25 +
 arch/arm/boot/dts/exynos5420.dtsi               |  50 +-
 arch/arm/boot/dts/exynos5440.dtsi               |  32 +-
 arch/arm/boot/dts/exynos5800.dtsi               |  56 +-
 arch/arm/boot/dts/gemini-nas4220b.dts           | 102 ++
 arch/arm/boot/dts/gemini-rut1xx.dts             |  65 ++
 arch/arm/boot/dts/gemini-sq201.dts              | 118 +++
 arch/arm/boot/dts/gemini-wbd111.dts             | 102 ++
 arch/arm/boot/dts/gemini-wbd222.dts             | 102 ++
 arch/arm/boot/dts/gemini.dtsi                   | 156 ++++
 .../dts/imx25-eukrea-mbimxsd25-baseboard.dts    |   2 -
 arch/arm/boot/dts/imx25-pdk.dts                 |   2 -
 arch/arm/boot/dts/imx25-pinfunc.h               |   5 +-
 arch/arm/boot/dts/imx25.dtsi                    |  12 +
 arch/arm/boot/dts/imx28-duckbill-2-485.dts      | 189 ++++
 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts  | 220 +++++
 arch/arm/boot/dts/imx28-duckbill-2-spi.dts      | 199 ++++
 arch/arm/boot/dts/imx28-duckbill-2.dts          | 183 ++++
 arch/arm/boot/dts/imx28-duckbill.dts            |  81 +-
 arch/arm/boot/dts/imx28-m28cu3.dts              |   2 +-
 arch/arm/boot/dts/imx28.dtsi                    |  28 +-
 arch/arm/boot/dts/imx50.dtsi                    |   8 +-
 arch/arm/boot/dts/imx53-qsb.dts                 |   4 +-
 arch/arm/boot/dts/imx53-qsrb.dts                |   4 +-
 arch/arm/boot/dts/imx6dl-gw5903.dts             |  55 ++
 arch/arm/boot/dts/imx6dl-gw5904.dts             |  55 ++
 arch/arm/boot/dts/imx6q-b450v3.dts              |   7 +
 arch/arm/boot/dts/imx6q-b650v3.dts              |   7 +
 arch/arm/boot/dts/imx6q-b850v3.dts              |  70 ++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi             |  16 +-
 arch/arm/boot/dts/imx6q-cm-fx6.dts              |  83 ++
 arch/arm/boot/dts/imx6q-gw5903.dts              |  55 ++
 arch/arm/boot/dts/imx6q-gw5904.dts              |  59 ++
 arch/arm/boot/dts/imx6q-icore-ofcap10.dts       |  76 ++
 arch/arm/boot/dts/imx6q-icore-ofcap12.dts       |  76 ++
 arch/arm/boot/dts/imx6q-icore.dts               |  34 +
 arch/arm/boot/dts/imx6q-utilite-pro.dts         |  10 +-
 arch/arm/boot/dts/imx6q-zii-rdu2.dts            |  50 +
 arch/arm/boot/dts/imx6qdl-gw5903.dtsi           | 654 +++++++++++++
 arch/arm/boot/dts/imx6qdl-gw5904.dtsi           | 641 +++++++++++++
 arch/arm/boot/dts/imx6qdl-icore.dtsi            |  19 +
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi          |  12 +
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi         | 932 +++++++++++++++++++
 arch/arm/boot/dts/imx6qdl.dtsi                  |   3 +-
 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts     |  55 ++
 arch/arm/boot/dts/imx6qp-sabresd.dts            |   4 +-
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts           |  50 +
 arch/arm/boot/dts/imx6qp.dtsi                   |  99 +-
 arch/arm/boot/dts/imx6sx.dtsi                   |  21 +-
 arch/arm/boot/dts/imx6ul-14x14-evk.dts          |   5 -
 arch/arm/boot/dts/imx6ul-geam.dtsi              |  45 +
 arch/arm/boot/dts/imx6ul-isiot-common.dtsi      | 141 +++
 arch/arm/boot/dts/imx6ul-isiot-emmc.dts         |   1 +
 arch/arm/boot/dts/imx6ul-isiot-nand.dts         |   1 +
 arch/arm/boot/dts/imx6ul-isiot.dtsi             |  73 ++
 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi     |  55 +-
 arch/arm/boot/dts/imx7-colibri.dtsi             |  45 +-
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts     |   1 +
 arch/arm/boot/dts/imx7d-sdb-sht11.dts           |  74 ++
 arch/arm/boot/dts/imx7s.dtsi                    |   7 +-
 arch/arm/boot/dts/include/arm                   |   1 +
 arch/arm/boot/dts/include/arm64                 |   1 +
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi  | 243 +++++
 arch/arm/boot/dts/moxart-uc7112lx.dts           |   2 +-
 arch/arm/boot/dts/moxart.dtsi                   |  21 +-
 arch/arm/boot/dts/omap3-cpu-thermal.dtsi        |  20 +
 arch/arm/boot/dts/omap3-igep.dtsi               |  52 ++
 arch/arm/boot/dts/omap3-n900.dts                |  23 +-
 arch/arm/boot/dts/omap3-n950-n9.dtsi            |  32 +
 arch/arm/boot/dts/omap34xx.dtsi                 |   8 +-
 arch/arm/boot/dts/omap36xx.dtsi                 |   8 +-
 arch/arm/boot/dts/omap4-droid4-xt894.dts        | 375 +++++++-
 arch/arm/boot/dts/omap443x.dtsi                 |   4 +
 arch/arm/boot/dts/omap4460.dtsi                 |   4 +
 arch/arm/boot/dts/omap5.dtsi                    |   9 +
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts  |   6 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi             |  30 +
 .../dts/qcom-msm8974-sony-xperia-honami.dts     |   8 -
 arch/arm/boot/dts/qcom-msm8974.dtsi             | 306 +++++-
 arch/arm/boot/dts/r7s72100-genmai.dts           |   8 +
 arch/arm/boot/dts/r7s72100-rskrza1.dts          |   8 +
 arch/arm/boot/dts/r7s72100.dtsi                 |  65 +-
 arch/arm/boot/dts/r8a73a4.dtsi                  |  19 +-
 arch/arm/boot/dts/r8a7743.dtsi                  |  29 +-
 arch/arm/boot/dts/r8a7745.dtsi                  |  29 +-
 arch/arm/boot/dts/r8a7778-bockw.dts             |   1 -
 arch/arm/boot/dts/r8a7779-marzen.dts            |   1 -
 arch/arm/boot/dts/r8a7790-lager.dts             |   1 -
 arch/arm/boot/dts/r8a7790.dtsi                  |  28 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts           |   4 +-
 arch/arm/boot/dts/r8a7791-porter.dts            |   5 +-
 arch/arm/boot/dts/r8a7791.dtsi                  |  25 +-
 arch/arm/boot/dts/r8a7792.dtsi                  |  25 +-
 arch/arm/boot/dts/r8a7793-gose.dts              |   1 -
 arch/arm/boot/dts/r8a7793.dtsi                  |  25 +-
 arch/arm/boot/dts/r8a7794-alt.dts               |   3 +-
 arch/arm/boot/dts/r8a7794-silk.dts              |   3 +-
 arch/arm/boot/dts/r8a7794.dtsi                  |  30 +-
 arch/arm/boot/dts/rk3036.dtsi                   |   6 +
 arch/arm/boot/dts/rk3188.dtsi                   |   4 +-
 arch/arm/boot/dts/rk322x.dtsi                   |   2 +
 arch/arm/boot/dts/rk3288-miqi.dts               |  12 +-
 arch/arm/boot/dts/rk3288-phycore-rdk.dts        | 298 ++++++
 arch/arm/boot/dts/rk3288-phycore-som.dtsi       | 497 ++++++++++
 arch/arm/boot/dts/rk3288-rock2-som.dtsi         |   2 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts       |  62 ++
 arch/arm/boot/dts/rk3288-tinker.dts             | 536 +++++++++++
 arch/arm/boot/dts/rk3288.dtsi                   |   8 +
 arch/arm/boot/dts/rk3xxx.dtsi                   |  16 +-
 arch/arm/boot/dts/s3c64xx.dtsi                  |   3 +-
 arch/arm/boot/dts/s5pv210.dtsi                  |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                  |   5 +
 arch/arm/boot/dts/socfpga.dtsi                  |  56 +-
 arch/arm/boot/dts/socfpga_arria10.dtsi          |  51 +-
 arch/arm/boot/dts/socfpga_arria10_socdk.dtsi    |   7 +-
 arch/arm/boot/dts/socfpga_arria5_socdk.dts      |   2 +-
 .../boot/dts/socfpga_cyclone5_de0_sockit.dts    |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcv.dtsi     |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_mcvevk.dts   |   1 -
 arch/arm/boot/dts/socfpga_cyclone5_socdk.dts    |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_sockit.dts   |   2 +-
 arch/arm/boot/dts/socfpga_cyclone5_socrates.dts |   8 +-
 arch/arm/boot/dts/socfpga_cyclone5_sodia.dts    |  23 +-
 .../boot/dts/socfpga_cyclone5_vining_fpga.dts   |   2 +-
 arch/arm/boot/dts/socfpga_vt.dts                |   2 +-
 arch/arm/boot/dts/spear600-evb.dts              | 148 ++-
 arch/arm/boot/dts/spear600.dtsi                 |  28 +-
 arch/arm/boot/dts/stih407-family.dtsi           |  18 +-
 arch/arm/boot/dts/stm32429i-eval.dts            |  28 +
 arch/arm/boot/dts/stm32746g-eval.dts            |   4 +
 arch/arm/boot/dts/stm32f429-disco.dts           |  16 +
 arch/arm/boot/dts/stm32f429.dtsi                |  37 +
 arch/arm/boot/dts/stm32f469-disco.dts           |  16 +
 arch/arm/boot/dts/stm32f746.dtsi                |  96 +-
 arch/arm/boot/dts/stm32h743-pinctrl.dtsi        | 156 ++++
 arch/arm/boot/dts/stm32h743.dtsi                |  83 ++
 arch/arm/boot/dts/stm32h743i-eval.dts           |  74 ++
 arch/arm/boot/dts/sun4i-a10-a1000.dts           |   1 -
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts      |   1 -
 .../arm/boot/dts/sun4i-a10-dserve-dsrv9703c.dts |   1 -
 arch/arm/boot/dts/sun4i-a10-hackberry.dts       |   1 -
 arch/arm/boot/dts/sun4i-a10-inet1.dts           |   1 -
 arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts    |   1 -
 arch/arm/boot/dts/sun4i-a10-jesurun-q5.dts      |   1 -
 arch/arm/boot/dts/sun4i-a10-marsboard.dts       |   1 -
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts      |   1 -
 arch/arm/boot/dts/sun4i-a10-mk802.dts           |   1 -
 arch/arm/boot/dts/sun4i-a10-olinuxino-lime.dts  |   1 -
 arch/arm/boot/dts/sun4i-a10-pcduino.dts         |   1 -
 .../arm/boot/dts/sun4i-a10-pov-protab2-ips9.dts |   1 -
 arch/arm/boot/dts/sun4i-a10.dtsi                |  40 +-
 arch/arm/boot/dts/sun5i-a10s-auxtek-t003.dts    |   1 -
 arch/arm/boot/dts/sun5i-a10s-auxtek-t004.dts    |   1 -
 .../arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |   5 +-
 arch/arm/boot/dts/sun5i-a10s-r7-tv-dongle.dts   |   1 -
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts        |   3 +-
 arch/arm/boot/dts/sun5i-a10s.dtsi               |  77 +-
 .../dts/sun5i-a13-empire-electronix-d709.dts    |   1 -
 arch/arm/boot/dts/sun5i-a13-hsg-h702.dts        |   1 -
 arch/arm/boot/dts/sun5i-a13-licheepi-one.dts    |   1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino-micro.dts |   1 -
 arch/arm/boot/dts/sun5i-a13-olinuxino.dts       |   1 -
 arch/arm/boot/dts/sun5i-a13.dtsi                | 140 ---
 arch/arm/boot/dts/sun5i-gr8-chip-pro.dts        |   4 +-
 arch/arm/boot/dts/sun5i-gr8-evb.dts             |   4 +-
 arch/arm/boot/dts/sun5i-gr8.dtsi                | 618 +-----------
 arch/arm/boot/dts/sun5i-r8-chip.dts             |   6 +-
 arch/arm/boot/dts/sun5i-r8.dtsi                 |  40 -
 arch/arm/boot/dts/sun5i.dtsi                    | 284 +++++-
 arch/arm/boot/dts/sun6i-a31-app4-evb1.dts       |   1 -
 arch/arm/boot/dts/sun6i-a31-colombus.dts        |   1 -
 arch/arm/boot/dts/sun6i-a31-hummingbird.dts     |   1 -
 arch/arm/boot/dts/sun6i-a31-i7.dts              |   1 -
 arch/arm/boot/dts/sun6i-a31-m9.dts              |   1 -
 .../arm/boot/dts/sun6i-a31-mele-a1000g-quad.dts |   1 -
 arch/arm/boot/dts/sun6i-a31.dtsi                |   1 -
 arch/arm/boot/dts/sun6i-a31s-cs908.dts          |   2 -
 arch/arm/boot/dts/sun6i-a31s-primo81.dts        |   1 -
 arch/arm/boot/dts/sun6i-a31s-sina31s-core.dtsi  |   1 -
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts        |  23 +
 .../arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts |  57 ++
 .../dts/sun6i-a31s-yones-toptech-bs1078-v2.dts  |   1 -
 .../boot/dts/sun6i-reference-design-tablet.dtsi |   1 -
 arch/arm/boot/dts/sun7i-a20-bananapi.dts        |   1 -
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     |   1 -
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      |   9 +-
 arch/arm/boot/dts/sun7i-a20-hummingbird.dts     |   1 -
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       |   1 -
 arch/arm/boot/dts/sun7i-a20-icnova-swac.dts     |   1 -
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts       |   1 -
 arch/arm/boot/dts/sun7i-a20-m3.dts              |   1 -
 arch/arm/boot/dts/sun7i-a20-mk808c.dts          |   1 -
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts  |   1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime.dts  |   1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |   1 -
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts |  36 +-
 arch/arm/boot/dts/sun7i-a20-orangepi-mini.dts   |   1 -
 arch/arm/boot/dts/sun7i-a20-orangepi.dts        |   1 -
 arch/arm/boot/dts/sun7i-a20-pcduino3.dts        |   1 -
 arch/arm/boot/dts/sun7i-a20.dtsi                |  46 +-
 arch/arm/boot/dts/sun8i-a23-a33.dtsi            |   2 +-
 arch/arm/boot/dts/sun8i-a23-evb.dts             |   1 -
 arch/arm/boot/dts/sun8i-a23-q8-tablet.dts       |  10 -
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts  |  23 +-
 arch/arm/boot/dts/sun8i-a33.dtsi                | 155 +++
 arch/arm/boot/dts/sun8i-a83t.dtsi               |   2 -
 .../boot/dts/sun8i-h2-plus-orangepi-zero.dts    |  21 +-
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts |   1 -
 arch/arm/boot/dts/sun8i-h3-beelink-x2.dts       |  11 +-
 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts   |  96 ++
 arch/arm/boot/dts/sun8i-h3-nanopi.dtsi          |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-2.dts       |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-lite.dts    |   1 -
 arch/arm/boot/dts/sun8i-h3-orangepi-one.dts     |  23 +-
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts      |   1 -
 arch/arm/boot/dts/sun8i-h3.dtsi                 | 602 +-----------
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts     |   1 -
 arch/arm/boot/dts/sun9i-a80-optimus.dts         |   1 -
 arch/arm/boot/dts/sun9i-a80.dtsi                |   2 -
 arch/arm/boot/dts/sunxi-common-regulators.dtsi  |   1 -
 arch/arm/boot/dts/sunxi-h3-h5.dtsi              | 618 ++++++++++++
 .../boot/dts/sunxi-reference-design-tablet.dtsi |   1 -
 arch/arm/boot/dts/uniphier-ld4-ref.dts          |  10 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi             |   4 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts         |  10 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi         |   2 +-
 arch/arm/boot/dts/uniphier-pro4-ace.dts         |  11 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts         |  10 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts       |  11 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi            |   4 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi            |   4 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts      |  11 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts       |  10 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi            |   4 +-
 arch/arm/boot/dts/uniphier-ref-daughter.dtsi    |   4 +-
 arch/arm/boot/dts/uniphier-sld3-ref.dts         |  12 +-
 arch/arm/boot/dts/uniphier-sld3.dtsi            |   4 +-
 arch/arm/boot/dts/uniphier-sld8-ref.dts         |  10 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi            |   4 +-
 arch/arm/boot/dts/uniphier-support-card.dtsi    |   5 +-
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi         |  24 +-
 arch/arm/boot/dts/vexpress-v2m.dtsi             |  24 +-
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts     |   2 +-
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts      |  18 +-
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts         |   2 +-
 arch/arm/boot/dts/vexpress-v2p-ca9.dts          |   2 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts       |  14 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-c.dts       |  77 ++
 arch/arm/boot/dts/vf610-zii-dev.dtsi            |  12 +
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi  |  43 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts   |  17 +
 arch/arm64/boot/dts/exynos/exynos5433-tm2e.dts  |  18 +
 arch/arm64/boot/dts/include/arm                 |   1 +
 arch/arm64/boot/dts/include/arm64               |   1 +
 include/dt-bindings/clock/r7s72100-clock.h      |   9 +-
 include/dt-bindings/clock/r8a73a4-clock.h       |   1 +
 include/dt-bindings/clock/r8a7790-clock.h       |   1 +
 include/dt-bindings/clock/r8a7791-clock.h       |   1 +
 include/dt-bindings/clock/r8a7792-clock.h       |   2 +-
 include/dt-bindings/clock/r8a7793-clock.h       |   5 +-
 include/dt-bindings/clock/r8a7794-clock.h       |   2 +
 include/dt-bindings/mfd/stm32f7-rcc.h           | 112 +++
 378 files changed, 13121 insertions(+), 2800 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/gemini.txt
 create mode 100644 Documentation/devicetree/bindings/arm/i2se.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/cortina,gemini-watchdog.txt
 create mode 100644 arch/arm/boot/dts/am335x-baltos-leds.dtsi
 create mode 100644 arch/arm/boot/dts/armada-385-linksys-shelby.dts
 create mode 100644 arch/arm/boot/dts/armada-385-synology-ds116.dts
 create mode 100644 arch/arm/boot/dts/bcm4708-linksys-ea6300-v1.dts
 create mode 100644 arch/arm/boot/dts/bcm47081-tplink-archer-c5-v2.dts
 create mode 100644 arch/arm/boot/dts/bcm4709-linksys-ea9200.dts
 create mode 100644 arch/arm/boot/dts/bcm47094-linksys-panamera.dts
 create mode 100644 arch/arm/boot/dts/bcm953012hr.dts
 create mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/gemini-nas4220b.dts
 create mode 100644 arch/arm/boot/dts/gemini-rut1xx.dts
 create mode 100644 arch/arm/boot/dts/gemini-sq201.dts
 create mode 100644 arch/arm/boot/dts/gemini-wbd111.dts
 create mode 100644 arch/arm/boot/dts/gemini-wbd222.dts
 create mode 100644 arch/arm/boot/dts/gemini.dtsi
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-485.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-enocean.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2-spi.dts
 create mode 100644 arch/arm/boot/dts/imx28-duckbill-2.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5903.dts
 create mode 100644 arch/arm/boot/dts/imx6dl-gw5904.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5903.dts
 create mode 100644 arch/arm/boot/dts/imx6q-gw5904.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap10.dts
 create mode 100644 arch/arm/boot/dts/imx6q-icore-ofcap12.dts
 create mode 100644 arch/arm/boot/dts/imx6q-zii-rdu2.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5903.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-gw5904.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qp-nitrogen6_som2.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-zii-rdu2.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-isiot-common.dtsi
 create mode 100644 arch/arm/boot/dts/imx7d-sdb-sht11.dts
 create mode 120000 arch/arm/boot/dts/include/arm
 create mode 120000 arch/arm/boot/dts/include/arm64
 create mode 100644 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
 create mode 100644 arch/arm/boot/dts/omap3-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-phycore-rdk.dts
 create mode 100644 arch/arm/boot/dts/rk3288-phycore-som.dtsi
 create mode 100644 arch/arm/boot/dts/rk3288-tinker.dts
 create mode 100644 arch/arm/boot/dts/stm32h743-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h743.dtsi
 create mode 100644 arch/arm/boot/dts/stm32h743i-eval.dts
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-neo-air.dts
 create mode 100644 arch/arm/boot/dts/sunxi-h3-h5.dtsi
 create mode 120000 arch/arm64/boot/dts/include/arm
 create mode 120000 arch/arm64/boot/dts/include/arm64
 create mode 100644 include/dt-bindings/mfd/stm32f7-rcc.h
