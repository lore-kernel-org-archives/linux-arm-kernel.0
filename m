From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 26 Jul 2018 16:13:58 +0200
Subject: [PATCH] arm64: dts: meson: Switch simple-mfd and syscon order
Message-ID: <1532614438-7207-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The order between "syscon" and "simple-mfd" is important because in these
particular cases, the node needs to be first a "simple-mfd" to expose
it's sub-nodes, and later on a "syscon" to permit other nodes to access
this register space through the "syscon" mechanism.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
This also has a consequence for U-Boot since the U-Boot DM is much simpler
and can only associate a single device to a node, thus here we want these
nodes to be an mfd bus to be able to probe the sub-nodes.

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 6adc8d3..3f0de9d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -342,7 +342,7 @@
 			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
 
 			sysctrl: system-controller at 0 {
-				compatible = "amlogic,meson-axg-hhi-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-axg-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 
 				clkc: clock-controller {
@@ -1180,7 +1180,7 @@
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl at 0 {
-				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index b8dc4db..d88699f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -344,7 +344,7 @@
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl at 0 {
-				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				pwrc_vpu: power-controller-vpu {
@@ -431,7 +431,7 @@
 			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
 
 			sysctrl: system-controller at 0 {
-				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 			};
 
-- 
2.7.4
