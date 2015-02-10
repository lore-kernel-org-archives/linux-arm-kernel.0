From: josh.wu@atmel.com (Josh Wu)
Date: Tue, 10 Feb 2015 14:14:44 +0800
Subject: [PATCH 2/3] ARM: at91: sama5/dts: move hsmc_clk out of nfc node
In-Reply-To: <1423548885-27589-1-git-send-email-josh.wu@atmel.com>
References: <1423548885-27589-1-git-send-email-josh.wu@atmel.com>
Message-ID: <1423548885-27589-2-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In sama5d3, sama5d4 chips, pmecc will use the hsmc clock. As pmecc is
part of HSMC. So move out hsmc_clk from nfc node to nand node.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 arch/arm/boot/dts/sama5d3.dtsi | 2 +-
 arch/arm/boot/dts/sama5d4.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 5f4144d..c0c3597 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -1413,6 +1413,7 @@
 			atmel,nand-has-dma;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand0_ale_cle>;
+			clocks = <&hsmc_clk>;
 			atmel,pmecc-lookup-table-offset = <0x0 0x8000>;
 			status = "disabled";
 
@@ -1425,7 +1426,6 @@
 					0xffffc000 0x00000070	/* NFC HSMC regs */
 					0x00200000 0x00100000	/* NFC SRAM banks */
 					>;
-				clocks = <&hsmc_clk>;
 			};
 		};
 	};
diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index c3b07d9..9b2139a 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -281,6 +281,7 @@
 			atmel,nand-has-dma;
 			pinctrl-names = "default";
 			pinctrl-0 = <&pinctrl_nand>;
+			clocks = <&hsmc_clk>;
 			status = "disabled";
 
 			nfc at 90000000 {
@@ -292,7 +293,6 @@
 					0xfc05c000 0x00000070	/* NFC HSMC regs */
 					0x00100000 0x00100000	/* NFC SRAM banks */
                                          >;
-				clocks = <&hsmc_clk>;
 				atmel,write-by-sram;
 			};
 		};
-- 
1.9.1
