From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 31 Aug 2017 15:52:24 +0200
Subject: [PATCH v3 7/9] ARM64: dts: meson-gxbb: p20x: enable sdcard UHS modes
In-Reply-To: <20170831135226.19784-1-jbrunet@baylibre.com>
References: <20170831135226.19784-1-jbrunet@baylibre.com>
Message-ID: <20170831135226.19784-8-jbrunet@baylibre.com>
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
index 704b214e8894..23c08c3afd0a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
@@ -226,6 +226,9 @@
 
 	bus-width = <4>;
 	cap-sd-highspeed;
+	sd-uhs-sdr12;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
 	max-frequency = <100000000>;
 	disable-wp;
 
-- 
2.9.5
