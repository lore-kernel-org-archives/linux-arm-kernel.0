From: jbrunet@baylibre.com (Jerome Brunet)
Date: Tue, 24 Jul 2018 14:52:36 +0200
Subject: [PATCH 12/14] arm64: dts: meson-axg: add spdif-dit codec
In-Reply-To: <20180724125238.14567-1-jbrunet@baylibre.com>
References: <20180724125238.14567-1-jbrunet@baylibre.com>
Message-ID: <20180724125238.14567-13-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SPDIF playback codec to the axg s400 board

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index d318647c86a7..d5c01427a5ca 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -197,6 +197,13 @@
 		status = "okay";
 		sound-name-prefix = "Lineout";
 	};
+
+	spdif_dit: audio-codec at 2 {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+		status = "okay";
+		sound-name-prefix = "DIT";
+	};
 };
 
 &ethmac {
-- 
2.17.1
