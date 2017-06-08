From: stefan@agner.ch (Stefan Agner)
Date: Thu,  8 Jun 2017 15:34:49 -0700
Subject: [PATCH v6 3/3] ARM: dts: imx7-colibri: add NAND support
In-Reply-To: <cover.9fab78eaa869dbad4c9ad7e8578c9cef3e49daa8.1496961128.git-series.stefan@agner.ch>
References: <cover.9fab78eaa869dbad4c9ad7e8578c9cef3e49daa8.1496961128.git-series.stefan@agner.ch>
Message-ID: <eed2e4bdf1823ac6548b2a21fb7c49fb123f467c.1496961128.git-series.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri iMX7 modules come with 512MB on-module SLC NAND flash
populated. Make use of it by enabling the GPMI controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7-colibri.dtsi |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
index 2d87489..ad4ce19 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -106,6 +106,15 @@
 	fsl,magic-packet;
 };
 
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	fsl,use-minimum-ecc;
+	nand-on-flash-bbt;
+	nand-ecc-mode = "hw";
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
-- 
git-series 0.9.1
