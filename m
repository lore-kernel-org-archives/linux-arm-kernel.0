From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 13 Feb 2017 19:10:34 +0800
Subject: [PATCH 7/7] ARM: rockchip: reanme RK1108 to RV1108
In-Reply-To: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
References: <1486983566-32265-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <1486984234-32693-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rockchip finally named the SOC as RV1108, so change it
for compatible.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
---

 Documentation/devicetree/bindings/arm/rockchip.txt   | 4 ++--
 arch/arm/boot/dts/Makefile                           | 2 +-
 arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} | 7 ++++---
 3 files changed, 7 insertions(+), 6 deletions(-)
 rename arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} (89%)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6..9901cbd 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.txt
+++ b/Documentation/devicetree/bindings/arm/rockchip.txt
@@ -111,9 +111,9 @@ Rockchip platforms device tree bindings
     Required root node properties:
       - compatible = "rockchip,px5-evb", "rockchip,px5", "rockchip,rk3368";
 
-- Rockchip RK1108 Evaluation board
+- Rockchip RV1108 Evaluation board
     Required root node properties:
-      - compatible = "rockchip,rk1108-evb", "rockchip,rk1108";
+      - compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
 
 - Rockchip RK3368 evb:
     Required root node properties:
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f10fe85..7100227 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -658,7 +658,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pba8.dtb \
 	arm-realview-pbx-a9.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
-	rk1108-evb.dtb \
+	rv1108-evb.dtb \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
 	rk3066a-bqcurie2.dtb \
diff --git a/arch/arm/boot/dts/rk1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
similarity index 89%
rename from arch/arm/boot/dts/rk1108-evb.dts
rename to arch/arm/boot/dts/rv1108-evb.dts
index 3956cff..2f5d46b 100644
--- a/arch/arm/boot/dts/rk1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -40,11 +40,11 @@
 
 /dts-v1/;
 
-#include "rk1108.dtsi"
+#include "rv1108.dtsi"
 
 / {
-	model = "Rockchip RK1108 Evaluation board";
-	compatible = "rockchip,rk1108-evb", "rockchip,rk1108";
+	model = "Rockchip RV1108 Evaluation board";
+	compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
 
 	memory at 60000000 {
 		device_type = "memory";
@@ -53,6 +53,7 @@
 
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 };
 
-- 
2.7.4
