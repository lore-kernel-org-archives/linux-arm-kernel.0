From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 17 Sep 2013 13:46:23 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: SDHC ports are 8 bit-wide
Message-ID: <1379436383-29428-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On imx6qdl-sabresd the SDHC2 and SDHC3 are 8 bit-wide, so pass the bus-width
property to reflect that.

Otherwise the mmc driver will operate with the default bus-width value of 4.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 39eafc2..64e454b 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -229,6 +229,7 @@
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2_1>;
+	bus-width = <8>;
 	cd-gpios = <&gpio2 2 0>;
 	wp-gpios = <&gpio2 3 0>;
 	status = "okay";
@@ -237,6 +238,7 @@
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3_1>;
+	bus-width = <8>;
 	cd-gpios = <&gpio2 0 0>;
 	wp-gpios = <&gpio2 1 0>;
 	status = "okay";
-- 
1.8.1.2
