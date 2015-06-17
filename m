From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 18 Jun 2015 01:33:38 +0800
Subject: [PATCH 5/5] dts: imx7: fix sd card gpio polarity specified in device
 tree
In-Reply-To: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
References: <1434562418-24090-1-git-send-email-aisheng.dong@freescale.com>
Message-ID: <1434562418-24090-6-git-send-email-aisheng.dong@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cd-gpios polarity should be changed to GPIO_ACTIVE_LOW and wp-gpios
should be changed to GPIO_ACTIVE_HIGH.
Otherwise, the SD may not work properly due to wrong polarity inversion
specified in DT after switch to common parsing function mmc_of_parse().

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 4d1a4b9..fdd1d7c 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -234,8 +234,8 @@
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-	cd-gpios = <&gpio5 0 0>;
-	wp-gpios = <&gpio5 1 0>;
+	cd-gpios = <&gpio5 0 GPIO_ACTIVE_LOW>;
+	wp-gpios = <&gpio5 1 GPIO_ACTIVE_HIGH>;
 	enable-sdio-wakeup;
 	keep-power-in-suspend;
 	status = "okay";
-- 
1.9.1
