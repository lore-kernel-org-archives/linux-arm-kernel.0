From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 8 May 2014 11:10:56 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Add USDHC4 support
Message-ID: <1399558256-32502-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USDHC4 is connected to a DDR MMC. Add support for it.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index dbbd35b..0c0e589 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -444,6 +444,21 @@
 				MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x17059
 			>;
 		};
+
+		pinctrl_usdhc4: usdhc4grp {
+			fsl,pins = <
+				MX6QDL_PAD_SD4_CMD__SD4_CMD		0x17059
+				MX6QDL_PAD_SD4_CLK__SD4_CLK		0x10059
+				MX6QDL_PAD_SD4_DAT0__SD4_DATA0		0x17059
+				MX6QDL_PAD_SD4_DAT1__SD4_DATA1		0x17059
+				MX6QDL_PAD_SD4_DAT2__SD4_DATA2		0x17059
+				MX6QDL_PAD_SD4_DAT3__SD4_DATA3		0x17059
+				MX6QDL_PAD_SD4_DAT4__SD4_DATA4		0x17059
+				MX6QDL_PAD_SD4_DAT5__SD4_DATA5		0x17059
+				MX6QDL_PAD_SD4_DAT6__SD4_DATA6		0x17059
+				MX6QDL_PAD_SD4_DAT7__SD4_DATA7		0x17059
+			>;
+		};
 	};
 
 	gpio_leds {
@@ -535,3 +550,12 @@
 	wp-gpios = <&gpio2 1 0>;
 	status = "okay";
 };
+
+&usdhc4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc4>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	status = "okay";
+};
-- 
1.8.3.2
