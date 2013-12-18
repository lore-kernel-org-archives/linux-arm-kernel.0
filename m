From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 18 Dec 2013 19:50:56 +0100
Subject: [PATCH 2/2] ARM: dts: mxs: Add iio-hwmon to mx23 soc
In-Reply-To: <1387392656-28037-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1387392656-28037-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1387392656-28037-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to read the SoC on-die temperature sensor available on the LRADC by
using:
 cat /sys/class/hwmon/hwmon0/device/temp1_input

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx23.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index c96ceaef7ddf..cd5e662d72f1 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -426,7 +426,7 @@
 				status = "disabled";
 			};
 
-			lradc at 80050000 {
+			lradc: lradc at 80050000 {
 				compatible = "fsl,imx23-lradc";
 				reg = <0x80050000 0x2000>;
 				interrupts = <36 37 38 39 40 41 42 43 44>;
@@ -524,4 +524,9 @@
 			status = "disabled";
 		};
 	};
+
+	iio_hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&lradc 8>;
+	};
 };
-- 
1.8.3.2
