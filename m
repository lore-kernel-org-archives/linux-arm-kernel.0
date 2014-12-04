From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  4 Dec 2014 23:30:13 +0100
Subject: [PATCH 3/4] ARM: at91/dt: sama5: move NFC nodes outside of NAND nodes
In-Reply-To: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1417732214-3292-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have updated the atmel-nand binding to get a better representation of
the NAND/NFC relationship.
Update the DTs defining those NFC nodes accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/sama5d3.dtsi | 19 ++++++++-----------
 arch/arm/boot/dts/sama5d4.dtsi | 21 +++++++++------------
 2 files changed, 17 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d..1749853 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1414,19 +1414,16 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
 			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
+			atmel,nfc = <&nfc>;
 			status = "disabled";
+		};
 
-			nfc at 70000000 {
-				compatible = "atmel,sama5d3-nfc";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <
-					0x70000000 0x10000000	/* NFC Command Registers */
-					0xffffc000 0x00000070	/* NFC HSMC regs */
-					0x00200000 0x00100000	/* NFC SRAM banks */
-					>;
-				clocks = <&hsmc_clk>;
-			};
+		nfc: nfc at 70000000 {
+			compatible = "atmel,sama5d3-nfc";
+			reg = <0x70000000 0x10000000	/* NFC Command Registers */
+			       0xffffc000 0x00000070	/* NFC HSMC regs */
+			       0x00200000 0x00100000>;	/* NFC SRAM banks */
+			clocks = <&hsmc_clk>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index e0157b0..3b5e9f1 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -280,20 +280,17 @@
 			atmel,nand-has-dma;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
+			atmel,nfc = <&nfc>;
 			status = "disabled";
+		};
 
-			nfc at 90000000 {
-				compatible = "atmel,sama5d3-nfc";
-				#address-cells = <1>;
-				#size-cells = <1>;
-				reg = <
-					0x90000000 0x10000000	/* NFC Command Registers */
-					0xfc05c000 0x00000070	/* NFC HSMC regs */
-					0x00100000 0x00100000	/* NFC SRAM banks */
-                                         >;
-				clocks = <&hsmc_clk>;
-				atmel,write-by-sram;
-			};
+		nfc: nfc at 90000000 {
+			compatible = "atmel,sama5d3-nfc";
+			reg = <0x90000000 0x10000000	/* NFC Command Registers */
+			       0xfc05c000 0x00000070	/* NFC HSMC regs */
+			       0x00100000 0x00100000>;	/* NFC SRAM banks */
+			clocks = <&hsmc_clk>;
+			atmel,write-by-sram;
 		};
 
 		apb {
-- 
1.9.1
