From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  6 Mar 2016 20:53:54 +0100
Subject: [PATCH v3 5/8] arm64: dts: rockchip: Clean up gpio-keys nodes
In-Reply-To: <1457294038-14243-1-git-send-email-afaerber@suse.de>
References: <1457294038-14243-1-git-send-email-afaerber@suse.de>
Message-ID: <1457294038-14243-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop superfluous #address-cells and #size-cells.
Use KEY_POWER define for 116.

Reported-by: Julien Chauveau <chauveau.julien@gmail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: New (Julien)
 
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi | 5 ++---
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts  | 5 ++---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
index 06bbe421db37..b62035436d38 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi
@@ -40,6 +40,7 @@
  *     OTHER DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/pwm/pwm.h>
 #include "rk3368.dtsi"
 
@@ -105,8 +106,6 @@
 
 	keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
@@ -114,7 +113,7 @@
 			wakeup-source;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index a1d1aa9c16fe..efb5fa32ecac 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -42,6 +42,7 @@
 
 /dts-v1/;
 #include "rk3368.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "Rockchip R88";
@@ -65,8 +66,6 @@
 
 	keys: gpio-keys {
 		compatible = "gpio-keys";
-		#address-cells = <1>;
-		#size-cells = <0>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pwr_key>;
 
@@ -74,7 +73,7 @@
 			wakeup-source;
 			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
 			label = "GPIO Power";
-			linux,code = <116>;
+			linux,code = <KEY_POWER>;
 		};
 	};
 
-- 
2.6.2
