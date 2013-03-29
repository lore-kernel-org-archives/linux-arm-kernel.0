From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Fri, 29 Mar 2013 17:32:05 +0100
Subject: [PATCH v2] arm/dts: OMAP3: fix pinctrl-single configuration
In-Reply-To: <20130329151759.GB10155@atomide.com>
References: <1364458106.3757.11.camel@mars>
 <20130328163854.GV10155@atomide.com> <1364549848.4634.13.camel@mars>
 <20130329151759.GB10155@atomide.com>
Message-ID: <1364574725.4634.51.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Fix 'function-mask' referring to TRM (Omap 36xx) Section 13.4.4:
   "Pad Functional Multiplexing and Configuration".
 - Fix 'omap3_pmx_wkup' referring to TRM Table 13-6:
   "Wkup Control Module Pad Configuration Register Fields".

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3.dtsi |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1acc261..1997b41 100644
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
@@ -81,16 +81,16 @@
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
+			reg = <0x48002a00 0x5c>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			pinctrl-single,register-width = <16>;
-			pinctrl-single,function-mask = <0x7fff>;
+			pinctrl-single,function-mask = <0x7f1f>;
 		};
 
 		gpio1: gpio at 48310000 {
-- 
1.7.10.4
