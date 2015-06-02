From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue,  2 Jun 2015 22:03:28 +0000
Subject: [PATCH] ARM: dts: mx23: fix iio-hwmon support
Message-ID: <1433282608-16257-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to get iio-hwmon support, the lradc must be declared as an
iio provider. So fix this issue by adding the #io-channel-cells property.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: bd798f9c7b30 ("ARM: dts: mxs: Add iio-hwmon to mx23 soc")
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index c892d58..b995333 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -468,6 +468,7 @@
 				interrupts = <36 37 38 39 40 41 42 43 44>;
 				status = "disabled";
 				clocks = <&clks 26>;
+				#io-channel-cells = <1>;
 			};
 
 			spdif at 80054000 {
-- 
1.7.9.5
