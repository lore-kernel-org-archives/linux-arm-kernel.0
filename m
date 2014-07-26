From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:21 +0200
Subject: [PATCH v2 05/15] ARM: dts: rockchip: add handles for shared nodes
 that don't have one yet
In-Reply-To: <1406416711-28006-1-git-send-email-heiko@sntech.de>
References: <1406416711-28006-1-git-send-email-heiko@sntech.de>
Message-ID: <1406416711-28006-6-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some nodes that are changed in the dtsi hierarchy do not have handles yet.
As it was suggested in the rk3288 submission to do subsequent nodes changes
through such handle-references, add the missing ones.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 2 +-
 arch/arm/boot/dts/rk3188.dtsi  | 2 +-
 arch/arm/boot/dts/rk3xxx.dtsi  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 4ad8f59..ecf722e 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -86,7 +86,7 @@
 		#reset-cells = <1>;
 	};
 
-	pinctrl at 20008000 {
+	pinctrl: pinctrl at 20008000 {
 		compatible = "rockchip,rk3066a-pinctrl";
 		rockchip,grf = <&grf>;
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 038d9d4..7b631ec 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -82,7 +82,7 @@
 		#reset-cells = <1>;
 	};
 
-	pinctrl at 20008000 {
+	pinctrl: pinctrl at 20008000 {
 		compatible = "rockchip,rk3188-pinctrl";
 		rockchip,grf = <&grf>;
 		rockchip,pmu = <&pmu>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index f70addd..10e7586 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -57,14 +57,14 @@
 		cache-level = <2>;
 	};
 
-	global-timer at 1013c200 {
+	global_timer: global-timer at 1013c200 {
 		compatible = "arm,cortex-a9-global-timer";
 		reg = <0x1013c200 0x20>;
 		interrupts = <GIC_PPI 11 0x304>;
 		clocks = <&cru CORE_PERI>;
 	};
 
-	local-timer at 1013c600 {
+	local_timer: local-timer at 1013c600 {
 		compatible = "arm,cortex-a9-twd-timer";
 		reg = <0x1013c600 0x20>;
 		interrupts = <GIC_PPI 13 0x304>;
@@ -111,7 +111,7 @@
 		status = "disabled";
 	};
 
-	dwmmc at 10214000 {
+	mmc0: dwmmc at 10214000 {
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10214000 0x1000>;
 		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
@@ -124,7 +124,7 @@
 		status = "disabled";
 	};
 
-	dwmmc at 10218000 {
+	mmc1: dwmmc at 10218000 {
 		compatible = "rockchip,rk2928-dw-mshc";
 		reg = <0x10218000 0x1000>;
 		interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.0.1
