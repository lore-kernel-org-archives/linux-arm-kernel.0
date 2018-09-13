From: robh@kernel.org (Rob Herring)
Date: Thu, 13 Sep 2018 13:12:41 -0500
Subject: [PATCH] arm64: dts: meson: Fix erroneous SPI bus warnings
Message-ID: <20180913181245.25484-17-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dtc has new checks for SPI buses. The meson dts files have a node named
spi' which causes false positive warnings. As the node is a pinctrl child
node, change the node name to be 'spi-pins' to fix the warnings.

arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dtb: Warning (spi_bus_bridge): /soc/periphs at c8834000/pinctrl at 4b0/spi: incorrect #address-cells for SPI bus

Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: linux-amlogic at lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Please apply to the sub-arch tree. The dtc changes haven't landed, but 
will for 4.20.

 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 98cbba6809ca..1ade7e486828 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -390,7 +390,7 @@
 			};
 		};
 
-		spi_pins: spi {
+		spi_pins: spi-pins {
 			mux {
 				groups = "spi_miso",
 					"spi_mosi",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index c87a80e9bcc6..8f0bb3c44bd6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -337,7 +337,7 @@
 			};
 		};
 
-		spi_pins: spi {
+		spi_pins: spi-pins {
 			mux {
 				groups = "spi_miso",
 					"spi_mosi",
-- 
2.17.1
