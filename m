From: jbrunet@baylibre.com (Jerome Brunet)
Date: Fri,  4 Aug 2017 20:08:13 +0200
Subject: [PATCH 3/6] ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
In-Reply-To: <20170804180816.18737-1-jbrunet@baylibre.com>
References: <20170804180816.18737-1-jbrunet@baylibre.com>
Message-ID: <20170804180816.18737-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdcard Ultra High Speed mode on the p20x. While the s905 should
support sdr104, the pcb of the p200 does not and is limited to an sdcard
clock rate of 100Mhz (SDR50)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 58b32f272a0e..900a13cc24ee 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -217,6 +217,9 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.9.4
