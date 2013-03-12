From: dianders@chromium.org (Doug Anderson)
Date: Tue, 12 Mar 2013 16:13:14 -0700
Subject: [PATCH 4/4] ARM: dts: Add adc and thermistors for exynos5250-snow
In-Reply-To: <1363129994-10438-1-git-send-email-dianders@chromium.org>
References: <1363129994-10438-1-git-send-email-dianders@chromium.org>
Message-ID: <1363129994-10438-5-git-send-email-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hook up the exynos5250-snow thermistors via the device tree now that
there's a driver available to use them.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 arch/arm/boot/dts/cros5250-common.dtsi |  4 ++++
 arch/arm/boot/dts/exynos5250-snow.dts  | 31 +++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index 62eceb4..cb48981 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -305,6 +305,10 @@
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
index babd9f9..1cab5fd 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -51,4 +51,35 @@
 			clock-frequency = <24000000>;
 		};
 	};
+
+	adc at 12D10000 {
+		ncp15wb473 at 3 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uV = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 3>;
+		};
+		ncp15wb473 at 4 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uV = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 4>;
+		};
+		ncp15wb473 at 5 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uV = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 5>;
+		};
+		ncp15wb473 at 6 {
+			compatible = "ntc,ncp15wb473";
+			pullup-uV = <1800000>;
+			pullup-ohm = <47000>;
+			pulldown-ohm = <0>;
+			io-channels = <&adc 6>;
+		};
+	};
 };
-- 
1.8.1.3
