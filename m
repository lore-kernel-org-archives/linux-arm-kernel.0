From: dianders@chromium.org (Doug Anderson)
Date: Wed, 13 Mar 2013 13:40:01 -0700
Subject: [PATCH v2 3/4] ARM: dts: Add adc to exynos5250 device tree file
In-Reply-To: <1363207202-10858-1-git-send-email-dianders@chromium.org>
References: <1363129994-10438-1-git-send-email-dianders@chromium.org>
 <1363207202-10858-1-git-send-email-dianders@chromium.org>
Message-ID: <1363207202-10858-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree entry for the device-tree enabled ADC driver that
recently landed in the iio tree.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v2: None

 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 3acf594..1642062 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -69,6 +69,17 @@
 			     <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
 	};
 
+	adc: adc at 12D10000 {
+		compatible = "samsung,exynos-adc-v1";
+		reg = <0x12D10000 0x100>, <0x10040718 0x4>;
+		interrupts = <0 106 0>;
+		#io-channel-cells = <1>;
+		io-channel-ranges;
+
+		clocks = <&clock 303>;
+		clock-names = "adc";
+	};
+
 	watchdog {
 		compatible = "samsung,s3c2410-wdt";
 		reg = <0x101D0000 0x100>;
-- 
1.8.1.3
