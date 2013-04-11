From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 11 Apr 2013 17:00:20 +0200
Subject: [PATCH 6/8] ARM: at91: sam9263: add fb dt support
In-Reply-To: <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130411145741.GB25242@game.jcrosoft.org>
 <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1365692422-9565-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91sam9263.dtsi |   39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
index 271d4de..3d0effa 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91sam9263.dtsi
@@ -303,6 +303,34 @@
 					};
 				};
 
+				fb {
+					pinctrl_fb: fb-0 {
+						atmel,pins =
+							<2 1 0x1 0x0	/* PC1 periph A */
+							 2 2 0x1 0x0	/* PC2 periph A */
+							 2 3 0x1 0x0	/* PC3 periph A */
+							 1 9 0x2 0x0	/* PB9 periph B */
+							 2 6 0x1 0x0	/* PC6 periph A */
+							 2 7 0x1 0x0	/* PC7 periph A */
+							 2 8 0x1 0x0	/* PC8 periph A */
+							 2 9 0x1 0x0	/* PC9 periph A */
+							 2 10 0x1 0x0	/* PC10 periph A */
+							 2 11 0x1 0x0	/* PC11 periph A */
+							 2 14 0x1 0x0	/* PC14 periph A */
+							 2 15 0x1 0x0	/* PC15 periph A */
+							 2 16 0x1 0x0	/* PC16 periph A */
+							 2 12 0x2 0x0	/* PC12 periph B */
+							 2 18 0x1 0x0	/* PC18 periph A */
+							 2 19 0x1 0x0	/* PC19 periph A */
+							 2 22 0x1 0x0	/* PC22 periph A */
+							 2 23 0x1 0x0	/* PC23 periph A */
+							 2 24 0x1 0x0	/* PC24 periph A */
+							 2 17 0x2 0x0	/* PC17 periph B */
+							 2 26 0x1 0x0	/* PC26 periph A */
+							 2 27 0x1 0x0>;	/* PC27 periph A */
+					};
+				};
+
 				pioA: gpio at fffff200 {
 					compatible = "atmel,at91rm9200-gpio";
 					reg = <0xfffff200 0x200>;
@@ -464,6 +492,17 @@
 			};
 		};
 
+		fb0: fb at 0x00500000 {
+			compatible = "atmel,at91sam9263-lcdc";
+			reg = <0x00700000 0x1000>;
+			interrupts = <26 3 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_fb>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+
 		nand0: nand at 40000000 {
 			compatible = "atmel,at91rm9200-nand";
 			#address-cells = <1>;
-- 
1.7.10.4
