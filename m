From: yixun.lan@amlogic.com (Yixun Lan)
Date: Sun, 8 Apr 2018 15:10:45 +0000
Subject: [PATCH] ARM64: dts: meson-axg: add GPIO interrupt controller support
Message-ID: <20180408151045.1138-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the GPIO interrupt controller driver which found in the Amlogic's
Meson-AXG SoC, the controller share the similar ASIC IP as other meson SoCs.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Hi Kevin
 Please note this patch depend on the GPIO interrupt driver here[0]

[0] http://lkml.kernel.org/r/20180408145700.23520-1-yixun.lan at amlogic.com
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b58808eb3cc8..c1105065de99 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -120,6 +120,15 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x25000>;
 
+			gpio_intc: interrupt-controller at f080 {
+				compatible = "amlogic,meson-gpio-intc";
+				reg = <0x0 0xf080 0x0 0x10>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				amlogic,channel-interrupts = <64 65 66 67 68 69 70 71>;
+				status = "disabled";
+			};
+
 			pwm_ab: pwm at 1b000 {
 				compatible = "amlogic,meson-axg-ee-pwm";
 				reg = <0x0 0x1b000 0x0 0x20>;
-- 
2.16.2
