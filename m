From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Mar 2016 14:58:43 +0100
Subject: [PATCH v4 5/8] arm64: dts: rockchip: Clean up gpio-keys nodes
In-Reply-To: <1458136727-32075-1-git-send-email-afaerber@suse.de>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
Message-ID: <1458136727-32075-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop superfluous #address-cells and #size-cells.
Use KEY_POWER define for 116.
Rename sub-nodes to avoid new dtc warnings.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Cc: Julien Chauveau <chauveau.julien@gmail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4:
 * Renamed sub-node names (Julien)
 
 v3: New (Julien)
 
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi | 7 +++----
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts  | 7 +++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index e4c91e86e9b6..bd4f2cf326b2 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -40,6 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3368.dtsi"
 
@@ -105,16 +106,14 @@
 
 	keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		button at 0 {
+		power {
 			wakeup-source;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 5c63f8982128..5ea68c493400 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -42,6 +42,7 @@
 
 /dts-v1/;
 #include "rk3368.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Rockchip R88";
@@ -65,16 +66,14 @@
 
 	keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
-		button at 0 {
+		power {
 			wakeup-source;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 		};
 	};
 
-- 
2.6.2
