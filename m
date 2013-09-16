From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 17:02:11 +0100
Subject: [PATCH 05/20] ARM: ux500: Enable the L3G4200D Gyroscope sensor from DT
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379347346-823-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying this node the L3G4200D sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b851713..7bc157f 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -162,6 +162,14 @@
 				vddio-supply = <&db8500_vsmps2_reg>;
 			};
 
+			l3g4200d at 68 {
+				compatible = "st,l3g4200d";
+				reg = <0x68>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+
 			lsm303dlhc_accel at 19 {
 				compatible = "st,lsm303dlhc_accel";
 				reg = <0x19>;
-- 
1.8.1.2
