From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:35 +0200
Subject: [PATCH 11/14] arm64: dts: meson-axg: add lineout codec
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-12-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the es7154 digital to analog converter which supplies the
lienout jack of the s400

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index fb101a1c6660..d318647c86a7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -188,6 +188,15 @@
 		status = "okay";
 		sound-name-prefix = "Linein";
 	};
+
+	lineout: audio-codec at 1 {
+		#sound-dai-cells = <0>;
+		compatible = "everest,es7154";
+		VDD-supply = <&vcc_3v3>;
+		PVDD-supply = <&vcc_5v>;
+		status = "okay";
+		sound-name-prefix = "Lineout";
+	};
 };
 
 &ethmac {
-- 
2.17.1
