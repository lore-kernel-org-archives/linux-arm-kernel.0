From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Tue,  5 Jan 2016 17:39:00 +0100
Subject: [PATCH v2 0/2] ARM: dts: imx6: Add support for Toradex Apalis iMX6Q/D
 SoM/Ixora carrier board
Message-ID: <1452011942-11940-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds support for Toradex Apalis iMX6Q/D SoM module [1] and
Ixora carrier board [2].

Petr ?tetiar has simply taken content of DTSes from Toradex's Git tree [3],
removed not mainlined stuff and fixed all errors returned by checkpatch script.

Please note that RESET_MOCI# used as mini-PCIe PERST# is not directly
GPIO1_IO28 but rather inverted (e.g. active-high and ored with RESETBMCU coming
off the PMIC but that is not relevant in this context). As changing the
reset-gpio polarity wasn't previously supported Petr ?tetiar's
"PCI: imx6: Fix reset-gpio to work with active low GPIO" fix [4] is needed.

1. https://www.toradex.com/computer-on-modules/apalis-arm-family/freescale-imx-6
2. https://www.toradex.com/products/carrier-boards/ixora-carrier-board
3. https://git.toradex.com/cgit/linux-toradex.git/log/?h=toradex_imx_3.14.28_1.0.0_ga
4. https://patchwork.ozlabs.org/patch/552886/

Changes in v2:
- clarify exact Apalis iMX6Q/D SoM type in cover letter
- clarify exact Apalis iMX6Q/D module type and Ixora carrier board in model
  node
- got rid of obsolete mmc aliases
- working SGTL5000 audio/sound integration
- working STMPE811 touch screen controller integration
- integrated review feedback from Lucas
- left and even added some more comments as I don't see why putting any
  explanatory comments in dts' should be such a bad thing to do
- completely got rid of the memory node as that is something typically filled
  in by the boot loader e.g. U-Boot
- without the regulators simple-bus it no longer boots
- even though we supposedly shipped a few hundred V1.0a modules drop DCE UART
  support for now and simplify file layout
- replaced obsolete no-1-8-v by mainline supported voltage-ranges = <3300 3300>
  usdhc property and yes card detects are indeed active low (;-p)
- integrated review feedback from Stefan
- fixed Ethernet PHY reset & interrupt (requires Micrel PHY driver to be
  enabled)
- fixed HDMI DDC (requires GPIO-based bitbanging I2C to be enabled)
- fixed SPDIF

Petr ?tetiar (2):
  ARM: dts: imx6: Add support for Toradex Apalis iMX6Q/D SoM
  ARM: dts: imx6: Add support for Toradex Ixora carrier board

 arch/arm/boot/dts/Makefile               |    1 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts |  256 ++++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi    | 1040 ++++++++++++++++++++++++++++++
 3 files changed, 1297 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apalis.dtsi

-- 
2.5.0
