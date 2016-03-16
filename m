From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Thu, 17 Mar 2016 00:10:53 +0100
Subject: [PATCH] ARM64: dts: amlogic: Clean up Vega S95 /memory nodes
Message-ID: <1458169854-26127-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Resolve the following warnings from new dtc by adding the unit address:

    DTC     arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dtb
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
    DTC     arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dtb
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
    DTC     arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dtb
  Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name

Fixes: cc733bc90636 ("ARM64: dts: amlogic: Add Tronsmart Vega S95 configs")
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
index 399aff9e7975..62fb4968d680 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts
@@ -48,7 +48,7 @@
 	compatible = "tronsmart,vega-s95-meta", "tronsmart,vega-s95", "amlogic,meson-gxbb";
 	model = "Tronsmart Vega S95 Meta";
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
index ac5a241b5ec2..9a9663abdf5c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts
@@ -48,7 +48,7 @@
 	compatible = "tronsmart,vega-s95-pro", "tronsmart,vega-s95", "amlogic,meson-gxbb";
 	model = "Tronsmart Vega S95 Pro";
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x40000000>;
 	};
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
index fff7bfa2aa39..2fe167b2609d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts
@@ -48,7 +48,7 @@
 	compatible = "tronsmart,vega-s95-telos", "tronsmart,vega-s95", "amlogic,meson-gxbb";
 	model = "Tronsmart Vega S95 Telos";
 
-	memory {
+	memory at 0 {
 		device_type = "memory";
 		reg = <0x0 0x0 0x0 0x80000000>;
 	};
-- 
2.6.2
