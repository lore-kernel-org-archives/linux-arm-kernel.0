From: peter.chen@nxp.com (Peter Chen)
Date: Mon, 31 Oct 2016 10:58:28 +0800
Subject: [PATCH 1/2] ARM: dts: imx6sx-sdb: update TX D_CAL for USBPHY
Message-ID: <1477882709-2518-1-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to change trimming value (as a percentage) of the 17.78mA TX
reference current for better signal quality. With this change, we
can patch the eye-diagram test on this board.

Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6sx-sdb.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 85f56a5..4933c56 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -317,6 +317,14 @@
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
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc2>;
-- 
2.7.4
