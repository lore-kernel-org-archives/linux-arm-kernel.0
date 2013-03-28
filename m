From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Thu, 28 Mar 2013 09:08:26 +0100
Subject: [PATCH] arm/dts: OMAP3: fix pinctrl-single configuration
Message-ID: <1364458106.3757.11.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Fix 'function-mask' referring to TRM Section 7.4.4:
  "Pad Functional Multiplexing and Configuration".
- Fix 'omap3_pmx_core' referring to TRM Table 7-4:
  "Core Control Module Pad Configuration Register Fields"
- Fix 'omap3_pmx_wkup' referring to TRM Table 7-6:
  "Wake-Up Control Module Pad Configuration Register Fields".

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..6ce3b5c 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -27,7 +27,7 @@
 	};
 
 	/*
-	 * The soc node represents the soc top level view. It is uses for IPs
+	 * The soc node represents the soc top level view. It is used for IPs
 	 * that are not memory mapped in the MPU view or for the MPU itself.
 	 */
 	soc {
@@ -77,20 +77,20 @@
 
 		omap3_pmx_core: pinmux at 48002030 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002030 0x05cc>;
+			reg = <0x48002030 0x234>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			pinctrl-single,function-mask = <0x7f1f>;
 		};
 
-		omap3_pmx_wkup: pinmux at 0x48002a58 {
+		omap3_pmx_wkup: pinmux at 0x48002a00 {
 			compatible = "ti,omap3-padconf", "pinctrl-single";
-			reg = <0x48002a58 0x5c>;
+			reg = <0x48002a00 0x54>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			pinctrl-single,function-mask = <0x7f1f>;
 		};
 
 		gpio1: gpio at 48310000 {
-- 
1.7.10.4
