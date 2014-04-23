From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 23 Apr 2014 20:09:19 +0100
Subject: [PATCH 37/38] ARM: cubox-i: add support for SD UHS-1 cards
In-Reply-To: <20140423185534.GA26756@n2100.arm.linux.org.uk>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
Message-ID: <E1Wd2Xn-0003wm-Ei@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index c2a24888a276..c928c0a5e3cc 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -111,6 +111,28 @@
 				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x13059
 			>;
 		};
+
+		pinctrl_cubox_i_usdhc2_100mhz: cubox-i-usdhc2-100mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170b9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100b9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170b9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170b9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170b9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x130b9
+			>;
+		};
+
+		pinctrl_cubox_i_usdhc2_200mhz: cubox-i-usdhc2-200mhz {
+			fsl,pins = <
+				MX6QDL_PAD_SD2_CMD__SD2_CMD    0x170f9
+				MX6QDL_PAD_SD2_CLK__SD2_CLK    0x100f9
+				MX6QDL_PAD_SD2_DAT0__SD2_DATA0 0x170f9
+				MX6QDL_PAD_SD2_DAT1__SD2_DATA1 0x170f9
+				MX6QDL_PAD_SD2_DAT2__SD2_DATA2 0x170f9
+				MX6QDL_PAD_SD2_DAT3__SD2_DATA3 0x130f9
+			>;
+		};
 	};
 };
 
@@ -131,8 +153,10 @@
 };
 
 &usdhc2 {
-	pinctrl-names = "default";
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2>;
+	pinctrl-1 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2_100mhz>;
+	pinctrl-2 = <&pinctrl_cubox_i_usdhc2_aux &pinctrl_cubox_i_usdhc2_200mhz>;
 	vmmc-supply = <&reg_3p3v>;
 	cd-gpios = <&gpio1 4 0>;
 	status = "okay";
-- 
1.8.3.1
