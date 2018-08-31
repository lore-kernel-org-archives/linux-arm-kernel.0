From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 31 Aug 2018 17:02:17 +0200
Subject: [PATCH 2/3] arm64: dts: meson-axg: s400: add dmic codec
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Message-ID: <20180831150218.8307-3-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 7 digital mics on the MIC daughter board attached
to the s400 board, so add the digital microphone codec to
its DTS

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index ff64c429d432..f3e16cbbc61e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -86,6 +86,15 @@
 		sound-name-prefix = "DIT";
 	};
 
+	dmics: audio-codec at 3 {
+		#sound-dai-cells = <0>;
+		compatible = "dmic-codec";
+		num-channels = <7>;
+		wakeup-delay-ms = <50>;
+		status = "okay";
+		sound-name-prefix = "MIC";
+	};
+
 	emmc_pwrseq: emmc-pwrseq {
 		compatible = "mmc-pwrseq-emmc";
 		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
-- 
2.17.1
