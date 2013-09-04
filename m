From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 4 Sep 2013 14:55:40 +0100
Subject: [PATCH v2 02/11] ARM: ux500: Enable the LPS001WP Pressure &
 Temperature sensor from DT
In-Reply-To: <1378287103-21765-3-git-send-email-lee.jones@linaro.org>
References: <1378287103-21765-1-git-send-email-lee.jones@linaro.org>
 <1378287103-21765-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20130904135540.GK20150@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After applying this node the LPS001WP sensor chip should probe
successfully once the driver support has also been applied.
    
Signed-off-by: Lee Jones <lee.jones@linaro.org>

diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index cf9b16e..dc556d1 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -153,6 +153,16 @@
                        status = "okay";
                };
 
+               i2c at 80128000 {
+                       lps001wp at 5c {
+                               compatible = "st,lps001wp";
+                               reg = <0x5c>;
+
+                               vdd-supply = <&ab8500_ldo_aux1_reg>;
+                               vms-supply = <&db8500_vsmps2_reg>;
+                       };
+               };
+
                uart at 80120000 {
                        status = "okay";
                };
