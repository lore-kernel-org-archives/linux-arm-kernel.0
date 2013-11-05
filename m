From: lisovy@gmail.com (Rostislav Lisovy)
Date: Tue,  5 Nov 2013 13:49:20 +0100
Subject: [PATCH] ARM: dts: voipac: Improve fixed voltage regulator definition
Message-ID: <1383655760-28206-1-git-send-email-lisovy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rostislav Lisovy <lisovy@gmail.com>
---
 arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
index a7d03ad..4f1d8fa 100644
--- a/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
+++ b/arch/arm/boot/dts/imx53-voipac-dmm-668.dtsi
@@ -27,9 +27,12 @@
 
 	regulators {
 		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
 
-		reg_3p3v: 3p3v {
+		reg_3p3v: regulator at 0 {
 			compatible = "regulator-fixed";
+			reg = <0>;
 			regulator-name = "3P3V";
 			regulator-min-microvolt = <3300000>;
 			regulator-max-microvolt = <3300000>;
-- 
1.7.10.4
