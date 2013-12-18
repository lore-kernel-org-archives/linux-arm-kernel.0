From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 18 Dec 2013 19:50:55 +0100
Subject: [PATCH 1/2] ARM: dts: mxs: Add iio-hwmon to mx28 soc
Message-ID: <1387392656-28037-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This allows to read the SoC on-die temperature sensor available on the LRADC by
using:
 cat /sys/class/hwmon/hwmon0/device/temp1_input

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 92d9f9e33bf1..3036241c4d57 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -1130,4 +1130,9 @@
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
