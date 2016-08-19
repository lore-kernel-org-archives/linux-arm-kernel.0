From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Fri, 19 Aug 2016 23:55:46 +0200
Subject: [PATCH v4 5/6] ARM64: dts: meson-gxbb: Add Infrared Remote Controller
 decoder
In-Reply-To: <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
References: <20160628191802.21227-1-martin.blumenstingl@googlemail.com>
 <20160819215547.20063-1-martin.blumenstingl@googlemail.com>
Message-ID: <20160819215547.20063-6-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

This adds the Infrared Remote Controller node so boards with an IR
remote can simply enable it.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 72df302..7070719 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -226,6 +226,13 @@
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			ir: ir at 580 {
+				compatible = "amlogic,meson-gxbb-ir";
+				reg = <0x0 0x00580 0x0 0x40>;
+				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
 		};
 
 		periphs: periphs at c8834000 {
-- 
2.9.3
