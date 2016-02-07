From: smoch@web.de (Soeren Moch)
Date: Sun,  7 Feb 2016 19:34:31 +0100
Subject: [PATCH 2/4] ARM: dts: imx6q-tbs2910: avoid sdhci boot warnings
In-Reply-To: <1454870073-6506-1-git-send-email-smoch@web.de>
References: <1454870073-6506-1-git-send-email-smoch@web.de>
Message-ID: <1454870073-6506-2-git-send-email-smoch@web.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid the following warnings (example for usdhc2):
/soc/aips-bus at 02100000/usdhc at 02194000: voltage-ranges unspecified
sdhci-esdhc-imx 2194000.usdhc: could not get ultra high speed state,
                               work on normal mode
sdhci-esdhc-imx 2194000.usdhc: No vqmmc regulator found

Signed-off-by: Soeren Moch <smoch@web.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/boot/dts/imx6q-tbs2910.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-tbs2910.dts b/arch/arm/boot/dts/imx6q-tbs2910.dts
index d8155d0..3b4360a 100644
--- a/arch/arm/boot/dts/imx6q-tbs2910.dts
+++ b/arch/arm/boot/dts/imx6q-tbs2910.dts
@@ -257,6 +257,9 @@
 	bus-width = <4>;
 	cd-gpios = <&gpio2 2 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	status = "okay";
 };
 
@@ -267,6 +270,9 @@
 	cd-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio2 1 GPIO_ACTIVE_HIGH>;
 	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	voltage-ranges = <3300 3300>;
+	no-1-8-v;
 	status = "okay";
 };
 
@@ -274,6 +280,9 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc4>;
 	bus-width = <8>;
+	vmmc-supply = <&reg_3p3v>;
+	vqmmc-supply = <&reg_3p3v>;
+	voltage-ranges = <3300 3300>;
 	non-removable;
 	no-1-8-v;
 	status = "okay";
-- 
1.9.1
