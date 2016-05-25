From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 25 May 2016 11:49:17 +0200
Subject: [PATCH v2 3/4] ARM64: dts: amlogic: Enable Reset Controller on
 GXBB-based platforms
In-Reply-To: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
References: <1464169758-26975-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464169758-26975-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DTSI file to add the reset controller node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..45e9c55 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
 
 / {
 	compatible = "amlogic,meson-gxbb";
@@ -129,6 +130,12 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xc1100000 0x0 0x100000>;
 
+			reset: reset-controller at 4404 {
+				compatible = "amlogic,meson-gxbb-reset";
+				reg = <0x0 0x04404 0x0 0x20>;
+				#reset-cells = <1>;
+			};
+
 			uart_A: serial at 84c0 {
 				compatible = "amlogic,meson-uart";
 				reg = <0x0 0x084c0 0x0 0x14>;
-- 
2.7.0
