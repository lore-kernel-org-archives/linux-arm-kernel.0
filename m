From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 30 May 2016 15:27:18 +0200
Subject: [PATCH v3 4/4] ARM: dts: amlogic: Enable Reset Controller on Meson8b
 platforms
In-Reply-To: <1464614838-28107-1-git-send-email-narmstrong@baylibre.com>
References: <1464614838-28107-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1464614838-28107-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update DTSI file to add the reset controller node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 2bfe401..fc4080d 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -46,6 +46,7 @@
 
 #include <dt-bindings/clock/meson8b-clkc.h>
 #include <dt-bindings/gpio/meson8b-gpio.h>
+#include <dt-bindings/reset/amlogic,meson8b-reset.h>
 #include "skeleton.dtsi"
 
 / {
@@ -105,6 +106,12 @@
 			#interrupt-cells = <3>;
 		};
 
+		reset: reset-controller at c1104404 {
+			compatible = "amlogic,meson8b-reset";
+			reg = <0xc1104404 0x20>;
+			#reset-cells = <1>;
+		};
+
 		wdt: watchdog at c1109900 {
 			compatible = "amlogic,meson8b-wdt";
 			reg = <0xc1109900 0x8>;
-- 
2.7.0
