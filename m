From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 17 Mar 2017 18:18:40 +0100
Subject: [PATCH v2 6/6] ARM: dts: rockchip: rename RK1108-evb to RV1108-evb
In-Reply-To: <20170317171840.4683-1-heiko@sntech.de>
References: <20170317171840.4683-1-heiko@sntech.de>
Message-ID: <20170317171840.4683-7-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andy Yan <andy.yan@rock-chips.com>

Rockchip finally named the SOC as RV1108, so change it
for compatible.

The rk1108/rv1108 is completely new to the market, so there no real
devices exist in the wild, only the Rockchip internal evaluation
board. Therefore we're not breaking any existing devices when
changing compatible values.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Acked-by: Rob Herring <robh@kernel.org>

[added paragraph about no real devices existing]
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/devicetree/bindings/arm/rockchip.txt   | 4 ++--
 arch/arm/boot/dts/Makefile                           | 2 +-
 arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/boot/dts/{rk1108-evb.dts => rv1108-evb.dts} (95%)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
index cc4ace6397ab..9901cbd6d11a 100644
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
index 011808490fed..d0d37d028790 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -674,7 +674,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 	arm-realview-pba8.dtb \
 	arm-realview-pbx-a9.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += \
-	rk1108-evb.dtb \
+	rv1108-evb.dtb \
 	rk3036-evb.dtb \
 	rk3036-kylin.dtb \
 	rk3066a-bqcurie2.dtb \
diff --git a/arch/arm/boot/dts/rk1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
similarity index 95%
rename from arch/arm/boot/dts/rk1108-evb.dts
rename to arch/arm/boot/dts/rv1108-evb.dts
index 88fe0a8c4faa..58cf4ac079c3 100644
--- a/arch/arm/boot/dts/rk1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -43,8 +43,8 @@
 #include "rv1108.dtsi"
 
 / {
-	model = "Rockchip RK1108 Evaluation board";
-	compatible = "rockchip,rk1108-evb", "rockchip,rk1108";
+	model = "Rockchip RV1108 Evaluation board";
+	compatible = "rockchip,rv1108-evb", "rockchip,rv1108";
 
 	memory at 60000000 {
 		device_type = "memory";
-- 
2.11.0
