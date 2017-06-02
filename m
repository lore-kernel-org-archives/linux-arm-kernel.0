From: stefan@agner.ch (Stefan Agner)
Date: Thu,  1 Jun 2017 19:11:10 -0700
Subject: [PATCH v4 2/2] ARM: dts: imx7-colibri: add NAND support
In-Reply-To: <cover.9cbefd91387aefe2522dbb3e6338e4e4efdb5e41.1496369342.git-series.stefan@agner.ch>
References: <cover.9cbefd91387aefe2522dbb3e6338e4e4efdb5e41.1496369342.git-series.stefan@agner.ch>
Message-ID: <415320ef413f5eb5dcba236aa69a0b644d7e7469.1496369342.git-series.stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Colibri iMX7 modules come with 512MB on-module SLC NAND flash
populated. Make use of it by enabling the GPMI controller.

Signed-off-by: Stefan Agner <stefan@agner.ch>
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
