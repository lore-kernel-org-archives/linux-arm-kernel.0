From: shawnguo@kernel.org (Shawn Guo)
Date: Fri,  4 May 2018 17:27:10 +0800
Subject: [PATCH 2/2] ARM: dts: imx6sx-sabreauto: drop board specific pinctrl
 container node
In-Reply-To: <1525426030-17221-1-git-send-email-shawnguo@kernel.org>
References: <1525426030-17221-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1525426030-17221-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board specific pinctrl function container node 'imx6x-sabreauto' is
not really necessary, since commit 5fcdf6a7ed95 ("pinctrl: imx: Allow
parsing DT without function nodes").  Let's drop it to save one level of
indentation.

Signed-off-by: Shawn Guo <shawnguo@kernel.org>
---
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 134 ++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 68 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index e5c1d6daa5e0..87ffe2c820f7 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -66,78 +66,76 @@
 };
 
 &iomuxc {
-	imx6x-sabreauto {
-		pinctrl_uart1: uart1grp {
-			fsl,pins = <
-				MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
-				MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1
-			>;
-		};
+	pinctrl_uart1: uart1grp {
+		fsl,pins = <
+			MX6SX_PAD_GPIO1_IO04__UART1_TX		0x1b0b1
+			MX6SX_PAD_GPIO1_IO05__UART1_RX		0x1b0b1
+		>;
+	};
 
-		pinctrl_usdhc3: usdhc3grp {
-			fsl,pins = <
-				MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x17059
-				MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x10059
-				MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x17059
-				MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x17059
-				MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x17059
-				MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x17059
-				MX6SX_PAD_SD3_DATA4__USDHC3_DATA4	0x17059
-				MX6SX_PAD_SD3_DATA5__USDHC3_DATA5	0x17059
-				MX6SX_PAD_SD3_DATA6__USDHC3_DATA6	0x17059
-				MX6SX_PAD_SD3_DATA7__USDHC3_DATA7	0x17059
-				MX6SX_PAD_KEY_COL0__GPIO2_IO_10		0x17059 /* CD */
-				MX6SX_PAD_KEY_ROW0__GPIO2_IO_15		0x17059 /* WP */
-			>;
-		};
+	pinctrl_usdhc3: usdhc3grp {
+		fsl,pins = <
+			MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x17059
+			MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x10059
+			MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x17059
+			MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x17059
+			MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x17059
+			MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x17059
+			MX6SX_PAD_SD3_DATA4__USDHC3_DATA4	0x17059
+			MX6SX_PAD_SD3_DATA5__USDHC3_DATA5	0x17059
+			MX6SX_PAD_SD3_DATA6__USDHC3_DATA6	0x17059
+			MX6SX_PAD_SD3_DATA7__USDHC3_DATA7	0x17059
+			MX6SX_PAD_KEY_COL0__GPIO2_IO_10		0x17059 /* CD */
+			MX6SX_PAD_KEY_ROW0__GPIO2_IO_15		0x17059 /* WP */
+		>;
+	};
 
-		pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
-			fsl,pins = <
-				MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x170b9
-				MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x100b9
-				MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x170b9
-				MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x170b9
-				MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x170b9
-				MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x170b9
-				MX6SX_PAD_SD3_DATA4__USDHC3_DATA4	0x170b9
-				MX6SX_PAD_SD3_DATA5__USDHC3_DATA5	0x170b9
-				MX6SX_PAD_SD3_DATA6__USDHC3_DATA6	0x170b9
-				MX6SX_PAD_SD3_DATA7__USDHC3_DATA7	0x170b9
-			>;
-		};
+	pinctrl_usdhc3_100mhz: usdhc3grp-100mhz {
+		fsl,pins = <
+			MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x170b9
+			MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x100b9
+			MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x170b9
+			MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x170b9
+			MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x170b9
+			MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x170b9
+			MX6SX_PAD_SD3_DATA4__USDHC3_DATA4	0x170b9
+			MX6SX_PAD_SD3_DATA5__USDHC3_DATA5	0x170b9
+			MX6SX_PAD_SD3_DATA6__USDHC3_DATA6	0x170b9
+			MX6SX_PAD_SD3_DATA7__USDHC3_DATA7	0x170b9
+		>;
+	};
 
-		pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
-			fsl,pins = <
-				MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x170f9
-				MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x100f9
-				MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x170f9
-				MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x170f9
-				MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x170f9
-				MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x170f9
-				MX6SX_PAD_SD3_DATA4__USDHC3_DATA4	0x170f9
-				MX6SX_PAD_SD3_DATA5__USDHC3_DATA5	0x170f9
-				MX6SX_PAD_SD3_DATA6__USDHC3_DATA6	0x170f9
-				MX6SX_PAD_SD3_DATA7__USDHC3_DATA7	0x170f9
-			>;
-		};
+	pinctrl_usdhc3_200mhz: usdhc3grp-200mhz {
+		fsl,pins = <
+			MX6SX_PAD_SD3_CMD__USDHC3_CMD		0x170f9
+			MX6SX_PAD_SD3_CLK__USDHC3_CLK		0x100f9
+			MX6SX_PAD_SD3_DATA0__USDHC3_DATA0	0x170f9
+			MX6SX_PAD_SD3_DATA1__USDHC3_DATA1	0x170f9
+			MX6SX_PAD_SD3_DATA2__USDHC3_DATA2	0x170f9
+			MX6SX_PAD_SD3_DATA3__USDHC3_DATA3	0x170f9
+			MX6SX_PAD_SD3_DATA4__USDHC3_DATA4	0x170f9
+			MX6SX_PAD_SD3_DATA5__USDHC3_DATA5	0x170f9
+			MX6SX_PAD_SD3_DATA6__USDHC3_DATA6	0x170f9
+			MX6SX_PAD_SD3_DATA7__USDHC3_DATA7	0x170f9
+		>;
+	};
 
-		pinctrl_usdhc4: usdhc4grp {
-			fsl,pins = <
-				MX6SX_PAD_SD4_CMD__USDHC4_CMD		0x17059
-				MX6SX_PAD_SD4_CLK__USDHC4_CLK		0x10059
-				MX6SX_PAD_SD4_DATA0__USDHC4_DATA0	0x17059
-				MX6SX_PAD_SD4_DATA1__USDHC4_DATA1	0x17059
-				MX6SX_PAD_SD4_DATA2__USDHC4_DATA2	0x17059
-				MX6SX_PAD_SD4_DATA3__USDHC4_DATA3	0x17059
-				MX6SX_PAD_SD4_DATA7__GPIO6_IO_21	0x17059 /* CD */
-				MX6SX_PAD_SD4_DATA6__GPIO6_IO_20	0x17059 /* WP */
-			>;
-		};
+	pinctrl_usdhc4: usdhc4grp {
+		fsl,pins = <
+			MX6SX_PAD_SD4_CMD__USDHC4_CMD		0x17059
+			MX6SX_PAD_SD4_CLK__USDHC4_CLK		0x10059
+			MX6SX_PAD_SD4_DATA0__USDHC4_DATA0	0x17059
+			MX6SX_PAD_SD4_DATA1__USDHC4_DATA1	0x17059
+			MX6SX_PAD_SD4_DATA2__USDHC4_DATA2	0x17059
+			MX6SX_PAD_SD4_DATA3__USDHC4_DATA3	0x17059
+			MX6SX_PAD_SD4_DATA7__GPIO6_IO_21	0x17059 /* CD */
+			MX6SX_PAD_SD4_DATA6__GPIO6_IO_20	0x17059 /* WP */
+		>;
+	};
 
-		pinctrl_vcc_sd3: vccsd3grp {
-			fsl,pins = <
-				MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
-			>;
-		};
+	pinctrl_vcc_sd3: vccsd3grp {
+		fsl,pins = <
+			MX6SX_PAD_KEY_COL1__GPIO2_IO_11		0x17059
+		>;
 	};
 };
-- 
1.9.1
