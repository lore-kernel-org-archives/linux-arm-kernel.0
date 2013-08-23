From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Fri, 23 Aug 2013 13:33:15 +0530
Subject: [PATCH v2] arm: dts: fix NTC thermistor device nodes for cros5250
In-Reply-To: <1377172114-8312-1-git-send-email-ch.naveen@samsung.com>
References: <1377172114-8312-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1377244995-25568-1-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes NTC devices nodes connected to ADC channel 3, 4, 5 and 6
on exynos5250 based snow device.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Signed-off-by: Doug Anderson <dianders@chromium.org>
---

Added recipients accordingly,
./scripts/get_maintainer.pl  -f of the modified files

 arch/arm/boot/dts/cros5250-common.dtsi |   33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
index dc259e8b..26bc25a 100644
--- a/arch/arm/boot/dts/cros5250-common.dtsi
+++ b/arch/arm/boot/dts/cros5250-common.dtsi
@@ -313,4 +313,37 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	adc at 12D10000 {
+		vdd-supply = <&buck5_reg>;
+
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
1.7.9.5
