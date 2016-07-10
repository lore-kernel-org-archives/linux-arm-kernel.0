From: narmstrong@baylibre.com (Neil Armstrong)
Date: Sun, 10 Jul 2016 11:11:06 +0200
Subject: [PATCH v3 3/3] ARM64: dts: amlogic: meson-gxbb: Add watchdog node
In-Reply-To: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
References: <1468141867-4172-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1468141867-4172-4-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 832815d..bcca82f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -136,6 +136,12 @@
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			watchdog at 98d0 {
+				compatible = "amlogic,meson-gxbb-wdt";
+				reg = <0x0 0x098d0 0x0 0x10>;
+				clocks = <&xtal>;
+			};
 		};
 
 		gic: interrupt-controller at c4301000 {
-- 
2.7.0
