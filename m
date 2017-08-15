From: scott.branden@broadcom.com (Scott Branden)
Date: Tue, 15 Aug 2017 10:25:59 -0700
Subject: [PATCH 2/6] ARM: dts: cygnus: place v3d in proper address ordered
 location
In-Reply-To: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
References: <1502817964-8221-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1502817964-8221-3-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move v3d devicetree node to proper address ordered location in Cygnus
dtsi.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index e4d07f4..2077fee 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -366,6 +366,19 @@
 			brcm,nand-has-wp;
 		};
 
+		v3d: v3d at 180a2000 {
+			compatible = "brcm,cygnus-v3d";
+			reg = <0x180a2000 0x1000>;
+			clocks = <&mipipll BCM_CYGNUS_MIPIPLL_CH2_V3D>;
+			clock-names = "v3d_clk";
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		vc4: gpu {
+			compatible = "brcm,cygnus-vc4";
+		};
+
 		gpio_asiu: gpio at 180a5000 {
 			compatible = "brcm,cygnus-asiu-gpio";
 			reg = <0x180a5000 0x668>;
@@ -444,19 +457,6 @@
 			status = "disabled";
 		};
 
-		v3d: v3d at 180a2000 {
-			compatible = "brcm,cygnus-v3d";
-			reg = <0x180a2000 0x1000>;
-			clocks = <&mipipll BCM_CYGNUS_MIPIPLL_CH2_V3D>;
-			clock-names = "v3d_clk";
-			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>;
-			status = "disabled";
-		};
-
-		vc4: gpu {
-			compatible = "brcm,cygnus-vc4";
-		};
-
 		adc: adc at 180a6000 {
 			compatible = "brcm,iproc-static-adc";
 			#io-channel-cells = <1>;
-- 
2.5.0
