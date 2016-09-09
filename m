From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  9 Sep 2016 10:28:58 +0200
Subject: [PATCH v2 4/4] ARM64: dts: meson-gxbb: Add SPIFC node
In-Reply-To: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com>
References: <1473409738-27175-1-git-send-email-jbrunet@baylibre.com>
Message-ID: <1473409738-27175-5-git-send-email-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 49e803e42e10..8d3bf3c7345e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -193,6 +193,15 @@
 				reg = <0x0 0x098d0 0x0 0x10>;
 				clocks = <&xtal>;
 			};
+
+			spifc: spi at 8c80 {
+				compatible = "amlogic,meson-gxbb-spifc";
+				reg = <0x0 0x08c80 0x0 0x80>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				clocks = <&clkc CLKID_SPI>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller at c4301000 {
-- 
2.7.4
