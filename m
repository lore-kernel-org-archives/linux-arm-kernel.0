From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:47 +0900
Subject: [PATCH v2 08/11] ARM: dts: exynos: Fix DTC unit name warnings in Peach
 Pit
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-8-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in Exynos5420 Peach Pit:

Warning (unit_address_vs_reg): Node /dp-controller at 145B0000/ports/port at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 48/ports/port at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 48/ports/port at 1 has a unit name, but no reg property

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's tag.
---
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index 3981ddb25036..e36975b6f625 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -165,7 +165,7 @@
 	samsung,hpd-gpio = <&gpx2 6 GPIO_ACTIVE_HIGH>;
 
 	ports {
-		port at 0 {
+		port0 {
 			dp_out: endpoint {
 				remote-endpoint = <&bridge_in>;
 			};
@@ -633,13 +633,13 @@
 		use-external-pwm;
 
 		ports {
-			port at 0 {
+			port0 {
 				bridge_out: endpoint {
 					remote-endpoint = <&panel_in>;
 				};
 			};
 
-			port at 1 {
+			port1 {
 				bridge_in: endpoint {
 					remote-endpoint = <&dp_out>;
 				};
-- 
2.5.0
