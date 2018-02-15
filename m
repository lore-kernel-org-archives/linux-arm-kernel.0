From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Feb 2018 11:12:07 +0100
Subject: [PATCH] ARM64: dts: meson-axg: add sec_AO system controller
Message-ID: <20180215101207.19186-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the secure AO system controller with chipid enabled

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 880e25b113c1..7f4c00216b82 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -836,6 +836,12 @@
 				};
 			};
 
+			sec_AO: ao-secure at 140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			pwm_AO_ab: pwm at 7000 {
 				compatible = "amlogic,meson-axg-ao-pwm";
 				reg = <0x0 0x07000 0x0 0x20>;
-- 
2.14.3
