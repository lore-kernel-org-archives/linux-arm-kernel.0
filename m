From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 14 Nov 2018 18:52:42 +0100
Subject: [PATCH v4 6/6] arm64: dts: imx8mq-evk: enable watchdog
In-Reply-To: <20181114175242.12468-1-l.stach@pengutronix.de>
References: <20181114175242.12468-1-l.stach@pengutronix.de>
Message-ID: <20181114175242.12468-6-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Baruch Siach <baruch@tkos.co.il>

The external nWDOG signal connects to the EVK board reset circuit.

Tested on the i.MX8MQ EVK rev B3.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
v4:
 - added patch to series
 - rebased pinctrl to upstream accepted driver binding
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index 04ce13f855c2..64acccc4bfcb 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -160,6 +160,13 @@
 	status = "okay";
 };
 
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+	status = "okay";
+};
+
 &iomuxc {
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
@@ -287,4 +294,10 @@
 			MX8MQ_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0xc1
 		>;
 	};
+
+	pinctrl_wdog: wdog1grp {
+		fsl,pins = <
+			MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B		0xc6
+		>;
+	};
 };
-- 
2.19.1
