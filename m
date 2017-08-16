From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Wed, 16 Aug 2017 02:38:47 +0200
Subject: [PATCH 5/5] arm64: dts: realtek: Adopt RTD1295 reset constants
In-Reply-To: <20170816003847.6208-1-afaerber@suse.de>
References: <20170816003847.6208-1-afaerber@suse.de>
Message-ID: <20170816003847.6208-6-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace reset controller indices with constants.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/realtek/rtd1295.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/realtek/rtd1295.dtsi b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
index e777200d84b9..2d2d84b573e3 100644
--- a/arch/arm64/boot/dts/realtek/rtd1295.dtsi
+++ b/arch/arm64/boot/dts/realtek/rtd1295.dtsi
@@ -7,6 +7,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/realtek,rtd1295.h>
 
 / {
 	compatible = "realtek,rtd1295";
@@ -123,7 +124,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <27000000>;
-			resets = <&iso_reset 8>;
+			resets = <&iso_reset RTD1295_ISO_RSTN_UR0>;
 			status = "disabled";
 		};
 
@@ -133,7 +134,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
-			resets = <&reset2 28>;
+			resets = <&reset2 RTD1295_RSTN_UR1>;
 			status = "disabled";
 		};
 
@@ -143,7 +144,7 @@
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <432000000>;
-			resets = <&reset2 27>;
+			resets = <&reset2 RTD1295_RSTN_UR2>;
 			status = "disabled";
 		};
 
-- 
2.12.3
