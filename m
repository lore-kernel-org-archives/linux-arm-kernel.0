From: ynezz@true.cz (=?UTF-8?q?Petr=20=C5=A0tetiar?=)
Date: Thu, 19 Nov 2015 13:24:58 +0100
Subject: [PATCH 0/2] ARM: dts: imx6: Add support for Toradex Apalis SoM/Ixora
Message-ID: <1447935900-13635-1-git-send-email-ynezz@true.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for Toradex Apalis SoM module[1] and Ixora
carrier board[2].

I've simply taken taken content of DTSes from Toradex's Git tree[3], removed
not mainlined stuff and fixed all errors returned by checkpatch script, some
warnings about 80 line length limit still remains, though.

PCIe slot on Ixora board uses reset-gpio which is active low, which isn't
currently supported, so "PCI: imx6: Fix reset-gpio to work with active low
GPIO" fix [4] is needed.

1. https://www.toradex.com/computer-on-modules/apalis-arm-family/freescale-imx-6
2. https://www.toradex.com/products/carrier-boards/ixora-carrier-board
3. https://git.toradex.com/cgit/linux-toradex.git/log/?h=toradex_imx_3.14.28_1.0.0_ga
4. https://patchwork.kernel.org/patch/7628361/

Petr ?tetiar (2):
  ARM: dts: imx6: Add support for Toradex Apalis SoM
  ARM: dts: imx6: Add support for Toradex Apalis Ixora board

 arch/arm/boot/dts/Makefile                    |    2 +
 arch/arm/boot/dts/imx6q-apalis-ixora.dts      |   25 +
 arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts |   33 +
 arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi   |  211 ++++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi         |  951 +++++++++++++++++++++++++
 5 files changed, 1222 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6q-apalis-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6q-apalis_v1_0-ixora.dts
 create mode 100644 arch/arm/boot/dts/imx6qdl-apalis-ixora.dtsi
 create mode 100644 arch/arm/boot/dts/imx6qdl-apalis.dtsi

-- 
1.7.9.5
