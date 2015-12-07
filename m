From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:34 +0200
Subject: [PATCH 3/8] ARM: dts: imx7d: cl-som-imx7: add eMMC support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-4-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for eMMC as a main storage.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index a8f52cf..44849ab 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -154,6 +154,17 @@
 	status = "okay";
 };
 
+&usdhc3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3>;
+	assigned-clocks = <&clks IMX7D_USDHC3_ROOT_CLK>;
+	assigned-clock-rates = <400000000>;
+	bus-width = <8>;
+	fsl,tuning-step = <2>;
+	non-removable;
+	status = "okay";
+};
+
 &iomuxc {
 	cl-som-imx7 {
 		pinctrl_i2c2: i2c2grp {
@@ -175,5 +186,21 @@
 				MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14 /* OTG PWREN */
 			>;
 		};
+
+		pinctrl_usdhc3: usdhc3grp {
+			fsl,pins = <
+				MX7D_PAD_SD3_CMD__SD3_CMD		0x59
+				MX7D_PAD_SD3_CLK__SD3_CLK		0x19
+				MX7D_PAD_SD3_DATA0__SD3_DATA0		0x59
+				MX7D_PAD_SD3_DATA1__SD3_DATA1		0x59
+				MX7D_PAD_SD3_DATA2__SD3_DATA2		0x59
+				MX7D_PAD_SD3_DATA3__SD3_DATA3		0x59
+				MX7D_PAD_SD3_DATA4__SD3_DATA4		0x59
+				MX7D_PAD_SD3_DATA5__SD3_DATA5		0x59
+				MX7D_PAD_SD3_DATA6__SD3_DATA6		0x59
+				MX7D_PAD_SD3_DATA7__SD3_DATA7		0x59
+				MX7D_PAD_SD3_STROBE__SD3_STROBE		0x19
+			>;
+		};
 	};
 };
-- 
1.9.1
