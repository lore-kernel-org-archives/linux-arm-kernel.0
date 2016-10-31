From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 31 Oct 2016 10:58:29 +0800
Subject: [PATCH 2/2] ARM: dts: imx6ul-14x14-evk: update TX D_CAL for USBPHY
In-Reply-To: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
References: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1477882709-2518-2-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to change trimming value (as a percentage) of the 17.78mA TX
reference current for better signal quality. With this change, we
can patch the eye-diagram test on this board.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6ul-14x14-evk.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul-14x14-evk.dts b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
index 53f0cf8..1867c69 100644
--- a/arch/arm/boot/dts/imx6ul-14x14-evk.dts
+++ b/arch/arm/boot/dts/imx6ul-14x14-evk.dts
@@ -233,6 +233,14 @@
 	status = "okay";
 };
 
+&usbphy1 {
+	fsl,tx-d-cal = <106>;
+};
+
+&usbphy2 {
+	fsl,tx-d-cal = <106>;
+};
+
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
2.7.4
