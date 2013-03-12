From: dianders@chromium.org (Doug Anderson)
Date: Tue, 12 Mar 2013 16:13:13 -0700
Subject: [PATCH 3/4] ARM: dts: Add adc to exynos5250 device tree file
In-Reply-To: <1363129994-10438-1-git-send-email-dianders@chromium.org>
References: <1363129994-10438-1-git-send-email-dianders@chromium.org>
Message-ID: <1363129994-10438-4-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the device tree entry for the device-tree enabled ADC driver that
recently landed in the iio tree.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/exynos5250.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 24c52e6..3773feb 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -115,6 +115,17 @@
 		interrupts = <1 2>, <22 4>;
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
