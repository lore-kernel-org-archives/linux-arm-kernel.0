From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 16 Sep 2013 17:02:09 +0100
Subject: [PATCH 03/20] ARM: ux500: Enable the LSM303DLH Accelerator sensor
 from DT
In-Reply-To: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
References: <1379347346-823-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1379347346-823-4-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying this node the LSM303DLH sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index ab173eb..61b33a0 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -161,6 +161,14 @@
 				vdd-supply = <&ab8500_ldo_aux1_reg>;
 				vddio-supply = <&db8500_vsmps2_reg>;
 			};
+
+			lsm303dlhc_accel at 19 {
+				compatible = "st,lsm303dlhc_accel";
+				reg = <0x19>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
 		};
 
 		uart at 80120000 {
-- 
1.8.1.2
