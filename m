From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 18 Jun 2015 01:33:37 +0800
Subject: [PATCH 4/5] dts: imx25: fix sd card gpio polarity specified in device
 tree
In-Reply-To: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
References: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1434562418-24090-5-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx25-pdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-pdk.dts b/arch/arm/boot/dts/imx25-pdk.dts
index dd45e69..faf252f 100644
--- a/arch/arm/boot/dts/imx25-pdk.dts
+++ b/arch/arm/boot/dts/imx25-pdk.dts
@@ -114,8 +114,8 @@
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
-	cd-gpios = <&gpio2 1 0>;
-	wp-gpios = <&gpio2 0 0>;
+	cd-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio2 0 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 };
 
-- 
1.9.1
