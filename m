From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri, 31 Aug 2018 17:02:16 +0200
Subject: [PATCH 1/3] arm64: dts: meson-axg: add pdm
In-Reply-To: <20180831150218.8307-1-jbrunet@baylibre.com>
References: <20180831150218.8307-1-jbrunet@baylibre.com>
Message-ID: <20180831150218.8307-2-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the PDM device of the axg audio subsystem

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 36be63d69e7f..883ddfce2374 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -152,6 +152,18 @@
 			status = "disabled";
 		};
 
+		pdm: audio-controller at ff632000 {
+			compatible = "amlogic,axg-pdm";
+			reg = <0x0 0xff632000 0x0 0x34>;
+			#sound-dai-cells = <0>;
+			sound-name-prefix = "PDM";
+			clocks = <&clkc_audio AUD_CLKID_PDM>,
+				 <&clkc_audio AUD_CLKID_PDM_DCLK>,
+				 <&clkc_audio AUD_CLKID_PDM_SYSCLK>;
+			clock-names = "pclk", "dclk", "sysclk";
+			status = "disabled";
+		};
+
 		periphs: bus at ff634000 {
 			compatible = "simple-bus";
 			reg = <0x0 0xff634000 0x0 0x2000>;
-- 
2.17.1
