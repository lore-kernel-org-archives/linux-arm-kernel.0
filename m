From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:28:25 +0200
Subject: [PATCH 5/5] ARM64: dts: meson-gxl: Add SPI pinctrl nodes
In-Reply-To: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
References: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614505-4437-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SPICC Controller pins nodes for Amlogic GXL SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 300dfad..30d4dea 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -281,6 +281,22 @@
 			};
 		};
 
+		spi_pins: spi {
+			mux {
+				groups = "spi_miso",
+					"spi_mosi",
+					"spi_sclk";
+				function = "spi";
+			};
+		};
+
+		spi_ss0_pins: spi-ss0 {
+			mux {
+				groups = "spi_ss0";
+				function = "spi";
+			};
+		};
+
 		sdcard_pins: sdcard {
 			mux {
 				groups = "sdcard_d0",
-- 
1.9.1
