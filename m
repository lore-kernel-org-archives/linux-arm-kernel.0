From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 13 Sep 2018 09:12:27 +0200
Subject: [PATCH RESEND] arm64: dts: meson: Switch simple-mfd and syscon order
Message-ID: <1536822747-13918-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The order between "syscon" and "simple-mfd" is important because in these
particular cases, the node needs to be first a "simple-mfd" to expose
it's sub-nodes, and later on a "syscon" to permit other nodes to access
this register space through the "syscon" mechanism.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
Hi Kevin,

I rebased the patch on top of your v4.20/dt64 branch.

Neil

 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 4 ++--
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 9f61407..df017db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -965,7 +965,7 @@
 
 			sysctrl: system-controller at 0 {
 				compatible = "amlogic,meson-axg-hhi-sysctrl",
-					     "syscon", "simple-mfd";
+					     "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 
 				clkc: clock-controller {
@@ -1209,7 +1209,7 @@
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl at 0 {
-				compatible = "amlogic,meson-axg-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-axg-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				clkc_AO: clock-controller {
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 49c22f2..f1e5cdb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -344,7 +344,7 @@
 			ranges = <0x0 0x0 0x0 0xc8100000 0x0 0x100000>;
 
 			sysctrl_AO: sys-ctrl at 0 {
-				compatible = "amlogic,meson-gx-ao-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-ao-sysctrl", "simple-mfd", "syscon";
 				reg =  <0x0 0x0 0x0 0x100>;
 
 				pwrc_vpu: power-controller-vpu {
@@ -444,7 +444,7 @@
 			ranges = <0x0 0x0 0x0 0xc883c000 0x0 0x2000>;
 
 			sysctrl: system-controller at 0 {
-				compatible = "amlogic,meson-gx-hhi-sysctrl", "syscon", "simple-mfd";
+				compatible = "amlogic,meson-gx-hhi-sysctrl", "simple-mfd", "syscon";
 				reg = <0 0 0 0x400>;
 			};
 
-- 
2.7.4
