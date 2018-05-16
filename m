From: nikita.yoush@cogentembedded.com (Nikita Yushchenko)
Date: Wed, 16 May 2018 09:39:21 +0300
Subject: [PATCH] ARM: dts: vf610-zii-dev: enable vf610 builtin temp sensor
Message-ID: <20180516063921.10406-1-nikita.yoush@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vybrid has single internal temperature sensor connected to both internal
ADC modules.

vf610-zii-dev already has ADC0 enabled. Now, to get temperature sensor
captured by iio_hwmon driver, need to configure iio_hwmon node to use
that ADC.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm/boot/dts/vf610-zii-dev.dtsi | 4 ++++
 arch/arm/boot/dts/vfxxx.dtsi         | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/vf610-zii-dev.dtsi b/arch/arm/boot/dts/vf610-zii-dev.dtsi
index 4890b8a5aa44..5ae5abfe1d55 100644
--- a/arch/arm/boot/dts/vf610-zii-dev.dtsi
+++ b/arch/arm/boot/dts/vf610-zii-dev.dtsi
@@ -222,6 +222,10 @@
 	status = "okay";
 };
 
+&tempsensor {
+	io-channels = <&adc0 16>;
+};
+
 &iomuxc {
 	pinctrl_adc0_ad5: adc0ad5grp {
 		fsl,pins = <
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index c3f09b737924..d392794d9c13 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -84,7 +84,7 @@
 		mask = <0x1000>;
 	};
 
-	iio-hwmon {
+	tempsensor: iio-hwmon {
 		compatible = "iio-hwmon";
 		io-channels = <&adc0 16>, <&adc1 16>;
 	};
-- 
2.11.0
