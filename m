From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  9 Sep 2013 11:09:58 +0100
Subject: [PATCH 02/14] ARM: ux500: Enable the LPS001WP Pressure & Temperature
 sensor from DT
In-Reply-To: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
References: <1378721410-30937-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1378721410-30937-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying this node the LPS001WP sensor chip should probe
successfully once the driver support has also been applied.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/ste-snowball.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index f1fc128..2b43c26 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -153,6 +153,16 @@
 			status = "okay";
 		};
 
+		i2c at 80128000 {
+			lps001wp at 5c {
+				compatible = "st,lps001wp";
+				reg = <0x5c>;
+
+				vdd-supply = <&ab8500_ldo_aux1_reg>;
+				vddio-supply = <&db8500_vsmps2_reg>;
+			};
+		};
+
 		uart at 80120000 {
 			status = "okay";
 		};
-- 
1.8.1.2
