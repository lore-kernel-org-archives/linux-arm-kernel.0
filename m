From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 18 Jun 2015 01:33:34 +0800
Subject: [PATCH 1/5] dts: imx51: fix sd card gpio polarity specified in device
 tree
In-Reply-To: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
References: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1434562418-24090-2-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx51-apf51dev.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx51-apf51dev.dts b/arch/arm/boot/dts/imx51-apf51dev.dts
index 93d3ea1..0f3fe29 100644
--- a/arch/arm/boot/dts/imx51-apf51dev.dts
+++ b/arch/arm/boot/dts/imx51-apf51dev.dts
@@ -98,7 +98,7 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio2 29 GPIO_ACTIVE_LOW>;
 	bus-width = <4>;
 	status = "okay";
 };
-- 
1.9.1
