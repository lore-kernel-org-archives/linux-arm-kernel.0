From: ccaione@baylibre.com (Carlo Caione)
Date: Fri, 23 Nov 2018 14:05:52 +0000
Subject: [PATCH] arm64: dts: meson-axg: Enable watchdog on Meson AXG SoCs
Message-ID: <20181123140552.5420-1-ccaione@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the watchdog node also on the AXG platforms.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index df017dbd2e57..e8cd580665bc 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -1422,6 +1422,12 @@
 				status = "disabled";
 			};
 
+			watchdog at f0d0 {
+				compatible = "amlogic,meson-axg-wdt", "amlogic,meson-gxbb-wdt";
+				reg = <0x0 0xf0d0 0x0 0x10>;
+				clocks = <&xtal>;
+			};
+
 			pwm_ab: pwm at 1b000 {
 				compatible = "amlogic,meson-axg-ee-pwm";
 				reg = <0x0 0x1b000 0x0 0x20>;
-- 
2.19.1
