From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 23 Feb 2016 14:04:36 +0800
Subject: [PATCH v2 2/2] ARM: at91: sama5/dts: move hsmc_clk out of nfc node
In-Reply-To: <1456207477-7946-1-git-send-email-wenyou.yang@atmel.com>
References: <1456207477-7946-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1456207477-7946-3-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

For SAMA5D3, SAMA5D4 SoC family, as PMECC is a part of HSMC, PMECC
needs the HSMC clock, so move out hsmc_clk from the nfc node to
the nand node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---

Changes in v2:
 - add a patch to change SAMA5D3 nand node's compatible string
   to "atmel,sama5d3-nand".
 - revert the mail address of Josh's Signed-off to the original.

 arch/arm/boot/dts/sama5d3.dtsi |    2 +-
 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index ee1b1a8..d20a38b 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1474,6 +1474,7 @@
 			atmel,nand-has-dma;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
+			clocks = <&hsmc_clk>;
 			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
 			status = "disabled";
 
@@ -1486,7 +1487,6 @@
 					0xffffc000 0x00000070	/* NFC HSMC regs */
 					0x00200000 0x00100000	/* NFC SRAM banks */
 					>;
-				clocks = <&hsmc_clk>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index b8032bc..1499b33 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -295,6 +295,7 @@
 			atmel,nand-has-dma;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&hsmc_clk>;
 			status = "disabled";
 
 			nfc at 90000000 {
@@ -306,7 +307,6 @@
 					0xfc05c000 0x00000070	/* NFC HSMC regs */
 					0x00100000 0x00100000	/* NFC SRAM banks */
                                          >;
-				clocks = <&hsmc_clk>;
 				atmel,write-by-sram;
 			};
 		};
-- 
1.7.9.5
