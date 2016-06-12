From: christopher.spinrath@rwth-aachen.de (christopher.spinrath at rwth-aachen.de)
Date: Sun, 12 Jun 2016 15:20:46 +0200
Subject: [PATCH 2/2] ARM: dts: utilite-pro: add mmc card slot support
In-Reply-To: <20160612132046.1363-1-christopher.spinrath@rwth-aachen.de>
References: <20160612132046.1363-1-christopher.spinrath@rwth-aachen.de>
Message-ID: <30f2c9e9b50d47d893218811f3223b3f@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

The Utilite Pro has a mmc card slot connected to the usdhc3
controller. Add support for it.

Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
---
 arch/arm/boot/dts/imx6q-utilite-pro.dts | 44 +++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
index 7219745..6199063 100644
--- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
+++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
@@ -130,6 +130,39 @@
 			MX6QDL_PAD_SD4_DAT6__UART2_CTS_B 0x1b0b1
 		>;
 	};
+
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x17059
+			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x10059
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x17059
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x17059
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x17059
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x17059
+		>;
+	};
+
+	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170B9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100B9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170B9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170B9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170B9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170B9
+		>;
+	};
+
+	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
+		fsl,pins = <
+			MX6QDL_PAD_SD3_CMD__SD3_CMD	0x170F9
+			MX6QDL_PAD_SD3_CLK__SD3_CLK	0x100F9
+			MX6QDL_PAD_SD3_DAT0__SD3_DATA0	0x170F9
+			MX6QDL_PAD_SD3_DAT1__SD3_DATA1	0x170F9
+			MX6QDL_PAD_SD3_DAT2__SD3_DATA2	0x170F9
+			MX6QDL_PAD_SD3_DAT3__SD3_DATA3	0x170F9
+		>;
+	};
 };
 
 &pcie {
@@ -151,3 +184,14 @@
 	uart-has-rtscts;
 	status = "okay";
 };
+
+&usdhc3 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
+	no-1-8-v;
+	broken-cd;
+	keep-power-in-suspend;
+	status = "okay";
+};
-- 
2.8.3
