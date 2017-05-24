From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 24 May 2017 10:28:24 +0200
Subject: [PATCH 4/5] ARM64: dts: meson-gxbb: Add SPI pinctrl nodes
In-Reply-To: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
References: <1495614505-4437-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1495614505-4437-5-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the SPICC Controller pins nodes for Amlogic GXBB SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index f0cfb02..16a9d45 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -393,6 +393,22 @@
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
