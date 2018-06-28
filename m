From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 28 Jun 2018 11:50:53 +0200
Subject: [PATCH 2/3] ARM64: dts: meson-axg: add s400 main 12v supply
In-Reply-To: <20180628095054.13433-1-jbrunet@baylibre.com>
References: <20180628095054.13433-1-jbrunet@baylibre.com>
Message-ID: <20180628095054.13433-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a fixed regulator for the main 12v which is the main power supply
of the board.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d926f8956db8..0b655570b7c2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -16,6 +16,13 @@
 		serial1 = &uart_A;
 	};
 
+	main_12v: regulator-main_12v {
+		compatible = "regulator-fixed";
+		regulator-name = "12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	vddio_boot: regulator-vddio_boot {
 		compatible = "regulator-fixed";
 		regulator-name = "VDDIO_BOOT";
-- 
2.14.4
