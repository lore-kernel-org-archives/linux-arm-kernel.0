From: dianders@chromium.org (Doug Anderson)
Date: Wed, 13 Mar 2013 13:40:02 -0700
Subject: [PATCH v2 4/4] ARM: dts: Add adc and thermistors for exynos5250-snow
In-Reply-To: <1363207202-10858-1-git-send-email-dianders@chromium.org>
References: <1363129994-10438-1-git-send-email-dianders@chromium.org>
 <1363207202-10858-1-git-send-email-dianders@chromium.org>
Message-ID: <1363207202-10858-5-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the exynos5250-snow thermistors via the device tree now that
there's a driver available to use them.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
Changes in v2:
- Match 'uV' -> 'uv' change in Naveen's bindings.

 arch/arm/boot/dts/cros5250-common.dtsi |  4 ++++
 arch/arm/boot/dts/exynos5250-snow.dts  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index 46c0980..f7cc835 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -167,6 +167,10 @@
 		status = "disabled";
 	};
 
+	adc at 12D10000 {
+		vdd-supply = <&buck5_reg>;
+	};
+
 	hdmi {
 		hpd-gpio = <&gpx3 7 0xf 1 3>;
 	};
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 17dd951..b78da7c 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -40,4 +40,35 @@
 				<&gpc4 5 2 3 0>, <&gpc4 6 2 3 0>;
 		};
 	};
+
+	adc at 12D10000 {
+		ncp15wb473 at 3 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 3>;
+		};
+		ncp15wb473 at 4 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 4>;
+		};
+		ncp15wb473 at 5 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 5>;
+		};
+		ncp15wb473 at 6 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uv = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 6>;
+		};
+	};
 };
-- 
1.8.1.3
