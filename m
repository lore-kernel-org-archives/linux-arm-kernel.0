From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 10 Nov 2017 16:46:59 +0800
Subject: [PATCH 3/3] arm64: dts: meson-axg: add new reset DT node
Message-ID: <20171110084659.31641-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add reset DT node for Amlogic's Meson-AXG SoC.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index e0fb860e12c5..65945c6c8b65 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -123,6 +123,12 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
 
+			reset: reset-controller at 1004 {
+				compatible = "amlogic,meson-axg-reset";
+				reg = <0x0 0x01004 0x0 0x9c>;
+				#reset-cells = <1>;
+			};
+
 			uart_A: serial at 24000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-uart";
 				reg = <0x0 0x24000 0x0 0x14>;
-- 
2.14.1
