From: B38611@freescale.com (Fugang Duan)
Date: Thu, 22 Aug 2013 18:47:47 +0800
Subject: [PATCH] ARM: dts: add fec phy reset for imx6sl evk board
Message-ID: <1377168467-8575-1-git-send-email-B38611@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add fec phy reset for imx6sl evk board.
Add iomux gpr device node, which used for fec to clear gpr1[14],
gpr1[18-17] bit to select the fec clock source from internal anatop PLL.

Signed-off-by: Fugang Duan  <B38611@freescale.com>
---
 arch/arm/boot/dts/imx6sl-evk.dts |    3 +++
 arch/arm/boot/dts/imx6sl.dtsi    |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 2886a59..c4d32a5 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -23,6 +23,8 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec_1>;
 	phy-mode = "rmii";
+	phy-reset-gpios = <&gpio4 21 0>; /* GPIO4_21 */
+	phy-reset-duration = <1>;
 	status = "okay";
 };
 
@@ -38,6 +40,7 @@
 				MX6SL_PAD_SD2_DAT7__GPIO5_IO00    0x17059
 				MX6SL_PAD_SD2_DAT6__GPIO4_IO29    0x17059
 				MX6SL_PAD_REF_CLK_32K__GPIO3_IO22 0x17059
+				MX6SL_PAD_FEC_TX_CLK__GPIO4_IO21  0x80000000
 			>;
 		};
 	};
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index c5e5da0..abd1eb9 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -504,6 +504,11 @@
 				interrupts = <0 89 0x04>;
 			};
 
+			gpr: iomuxc-gpr at 020e0000 {
+				compatible = "fsl,imx6sl-iomuxc-gpr", "syscon";
+				reg = <0x020e0000 0x38>;
+			};
+
 			iomuxc: iomuxc at 020e0000 {
 				compatible = "fsl,imx6sl-iomuxc";
 				reg = <0x020e0000 0x4000>;
-- 
1.7.1
