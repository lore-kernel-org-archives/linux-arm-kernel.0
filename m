From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:40 +0900
Subject: [PATCH v2 01/11] ARM: dts: exynos: Fix DTC unit name warnings in
 cros-adc-thermistors
Message-ID: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in cros-adc-thermistors:

Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /adc at 12D10000/ncp15wb473 at 6 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/cros-adc-thermistors.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/cros-adc-thermistors.dtsi b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
index acd4fe1833f2..ce7fca76b0d6 100644
--- a/arch/arm/boot/dts/cros-adc-thermistors.dtsi
+++ b/arch/arm/boot/dts/cros-adc-thermistors.dtsi
@@ -13,28 +13,28 @@
 */
 
 &adc {
-	ncp15wb473 at 3 {
+	thermistor3 {
 		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <47000>;
 		pulldown-ohm = <0>;
 		io-channels = <&adc 3>;
 	};
-	ncp15wb473 at 4 {
+	thermistor4 {
 		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <47000>;
 		pulldown-ohm = <0>;
 		io-channels = <&adc 4>;
 	};
-	ncp15wb473 at 5 {
+	thermistor5 {
 		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <47000>;
 		pulldown-ohm = <0>;
 		io-channels = <&adc 5>;
 	};
-	ncp15wb473 at 6 {
+	thermistor6 {
 		compatible = "murata,ncp15wb473";
 		pullup-uv = <1800000>;
 		pullup-ohm = <47000>;
-- 
2.5.0
