From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 29 May 2017 10:09:55 +0200
Subject: [PATCH] ARM64: dts: meson-gx: Add SPICC nodes
Message-ID: <1496045395-5702-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the SPICC controller on GX common dtsi, GXBB and
GXL dtsi files.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 9 +++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 7 +++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 436b875..613719d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -304,6 +304,15 @@
 				status = "disabled";
 			};
 
+			spicc: spi at 8d80 {
+				compatible = "amlogic,meson-gx-spicc";
+				reg = <0x0 0x08d80 0x0 0x80>;
+				interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+				status = "disabled";
+			};
+
 			spifc: spi at 8c80 {
 				compatible = "amlogic,meson-gx-spifc", "amlogic,meson-gxbb-spifc";
 				reg = <0x0 0x08c80 0x0 0x80>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 95a5d57..1734974 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -657,6 +657,13 @@
 	clock-names = "core", "clkin0", "clkin1";
 };
 
+&spicc {
+	clocks = <&clkc CLKID_SPICC>;
+	clock-names = "core";
+	resets = <&reset RESET_PERIPHS_SPICC>;
+	num-cs = <1>;
+};
+
 &spifc {
 	clocks = <&clkc CLKID_SPI>;
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 42d78f0..567dde4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -584,6 +584,13 @@
 	clock-names = "core", "clkin0", "clkin1";
 };
 
+&spicc {
+	clocks = <&clkc CLKID_SPICC>;
+	clock-names = "core";
+	resets = <&reset RESET_PERIPHS_SPICC>;
+	num-cs = <1>;
+};
+
 &spifc {
 	clocks = <&clkc CLKID_SPI>;
 };
-- 
1.9.1
