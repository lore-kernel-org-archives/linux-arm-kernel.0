From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 17:44:41 +0100
Subject: [PATCH 3/8] ARM64: dts: meson-gxl: Add clock nodes
In-Reply-To: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
References: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1477932286-27482-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock node for Amlogic Meson GXL.
The GXBB compatible is retained since the GXBB clock tree is used for now.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index ce7f550..33d0506 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -42,6 +42,7 @@
  */
 
 #include "meson-gx.dtsi"
+#include <dt-bindings/clock/gxbb-clkc.h>
 #include <dt-bindings/gpio/meson-gxl-gpio.h>
 
 / {
@@ -214,3 +215,11 @@
 		};
 	};
 };
+
+&hiubus {
+	clkc: clock-controller at 0 {
+		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
+		#clock-cells = <1>;
+		reg = <0x0 0x0 0x0 0x3db>;
+	};
+};
-- 
1.9.1
