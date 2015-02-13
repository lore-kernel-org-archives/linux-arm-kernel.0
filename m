From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 13 Feb 2015 18:12:47 +0200
Subject: [PATCHv2 28/33] ARM: dts: omap3: add syscon support to scrm node
In-Reply-To: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
References: <1423843973-6050-1-git-send-email-t-kristo@ti.com>
Message-ID: <1423843973-6050-26-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Control module will be converted to use syscon, thus add compatible
string for this. Also, remove the existing duplicate syscon entry
at the same time, and change the existing users of this to use the real
control module syscon.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 01b7111..969b4a1 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -122,8 +122,8 @@
 		};
 
 		scrm: scrm at 48002000 {
-			compatible = "ti,omap3-scrm";
-			reg = <0x48002000 0x2000>;
+			compatible = "ti,omap3-scrm", "syscon";
+			reg = <0x48002000 0x1000>;
 
 			scrm_clocks: clocks {
 				#address-cells = <1>;
@@ -181,15 +181,10 @@
 			pinctrl-single,function-mask = <0xff1f>;
 		};
 
-		omap3_scm_general: tisyscon at 48002270 {
-			compatible = "syscon";
-			reg = <0x48002270 0x2f0>;
-		};
-
 		pbias_regulator: pbias_regulator {
 			compatible = "ti,pbias-omap";
-			reg = <0x2b0 0x4>;
-			syscon = <&omap3_scm_general>;
+			reg = <0x520 0x4>;
+			syscon = <&scrm>;
 			pbias_mmc_reg: pbias_mmc_omap2430 {
 				regulator-name = "pbias_mmc_omap2430";
 				regulator-min-microvolt = <1800000>;
-- 
1.7.9.5
