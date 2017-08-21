From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 21 Aug 2017 18:06:35 +0200
Subject: [PATCH v2 7/9] ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
In-Reply-To: <20170821160637.22456-1-jbrunet@baylibre.com>
References: <20170821160637.22456-1-jbrunet@baylibre.com>
Message-ID: <20170821160637.22456-8-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable sdcard UHS modes, up to SDR50, on p20x based boards.
While the s905 supports SDR104 mode, it appears that the PCB of p20x
based boards can't cope with a rate as high as 200Mhz.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
index 99c409d1c8f8..d5dad8fa4993 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -219,6 +219,9 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.9.5
