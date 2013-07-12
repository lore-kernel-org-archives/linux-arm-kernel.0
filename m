From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 12 Jul 2013 09:49:32 -0300
Subject: [PATCH v3 3/4] ARM: dts: imx6dl-wandboard: Add SDHC1 and SDHC2 ports
In-Reply-To: <1373633373-3352-1-git-send-email-festevam@gmail.com>
References: <1373633373-3352-1-git-send-email-festevam@gmail.com>
Message-ID: <1373633373-3352-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Wandboard has a SD card slot on the baseboard connected to SDHC1 and a
BCM4329 (Wifi + Bluetooth chip) connected to SDHC2.

Add support for these ports.

While at it, provide the card detect gpio on SDHC3 and also fix indentation on 
MX6QDL_PAD_GPIO_0__CCM_CLKO1 hog pin.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Rebased against imx-dt tree.
- Separate board changes from SoC changes
- Fix indentation of MX6QDL_PAD_GPIO_0__CCM_CLKO1
Changes since v1:
- Also add the usdhc pinmux groups to mx6q

 arch/arm/boot/dts/imx6dl-wandboard.dts | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl-wandboard.dts b/arch/arm/boot/dts/imx6dl-wandboard.dts
index fbe0f19..fe9a01d 100644
--- a/arch/arm/boot/dts/imx6dl-wandboard.dts
+++ b/arch/arm/boot/dts/imx6dl-wandboard.dts
@@ -82,7 +82,9 @@
 	hog {
 		pinctrl_hog: hoggrp {
 			fsl,pins = <
-				MX6QDL_PAD_GPIO_0__CCM_CLKO1 0x130b0
+				MX6QDL_PAD_GPIO_0__CCM_CLKO1 	0x130b0
+				MX6QDL_PAD_GPIO_2__GPIO1_IO02	0x80000000
+				MX6QDL_PAD_EIM_DA9__GPIO3_IO09	0x80000000
 			>;
 		};
 	};
@@ -110,8 +112,23 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc1_2>;
+	cd-gpios = <&gpio1 2 0>;
+	status = "okay";
+};
+
+&usdhc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc2_2>;
+	non-removable;
+	status = "okay";
+};
+
 &usdhc3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc3_2>;
+	cd-gpios = <&gpio3 9 0>;
 	status = "okay";
 };
-- 
1.8.1.2
