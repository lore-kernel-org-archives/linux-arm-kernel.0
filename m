From: baruch@tkos.co.il (Baruch Siach)
Date: Wed,  7 Feb 2018 17:12:50 +0200
Subject: [PATCH v2 2/2] arm64: dts: fsl: imx8mq-evk: enable watchdog
In-Reply-To: <57855fb372ae19aad54c39c0e18a54cb12ed6915.1518016370.git.baruch@tkos.co.il>
References: <57855fb372ae19aad54c39c0e18a54cb12ed6915.1518016370.git.baruch@tkos.co.il>
Message-ID: <ae093f95bae9f4f92c5bbc6fc06cdeb8cfc1d1e1.1518016370.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The external nWDOG signal connects to the EVK board reset circuit.

Tested on the i.MX8MQ EVK rev B3.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
v2:
  * Rename the fsl,pins to pinmux
  * Drop input-schmitt-enable
---
 arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
index c0e5ee5d6243..15be7ee9c9e4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
@@ -170,6 +170,13 @@
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
 	pinctrl_fec1_mdc: fec1mdcgrp {
 		pinmux = <MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC>;
@@ -402,4 +409,11 @@
 		bias-pull-up;
 		input-schmitt-enable;
 	};
+
+	pinctrl_wdog: wdoggrp {
+		pinmux = <MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B>;
+		drive-strength = <6>;
+		slew-rate = <0>;
+		bias-pull-up;
+	};
 };
-- 
2.15.1
