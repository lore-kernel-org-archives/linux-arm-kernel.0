From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu, 18 Aug 2016 12:08:48 +0200
Subject: [PATCH v2 3/3] ARM64: dts: meson-gxbb: Add GXBB AO Clock and Reset
 node
In-Reply-To: <1471514928-3341-1-git-send-email-narmstrong@baylibre.com>
References: <1471514928-3341-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1471514928-3341-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AO clock controller node for the AmLogic GXBB SoC.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index e502c24..c81e1ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -45,6 +45,8 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/gpio/meson-gxbb-gpio.h>
 #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
+#include <dt-bindings/clock/gxbb-aoclkc.h>
+#include <dt-bindings/reset/gxbb-aoclkc.h>
 
 / {
 	compatible = "amlogic,meson-gxbb";
@@ -205,6 +207,13 @@
 				};
 			};
 
+			clkc_AO: clock-controller at 040 {
+				compatible = "amlogic,gxbb-aoclkc";
+				reg = <0x0 0x00040 0x0 0x4>;
+				#clock-cells = <1>;
+				#reset-cells = <1>;
+			};
+
 			uart_AO: serial at 4c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x004c0 0x0 0x14>;
-- 
2.7.0
