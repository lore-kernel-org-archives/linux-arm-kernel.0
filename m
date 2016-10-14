From: jteki@openedev.com (Jagan Teki)
Date: Fri, 14 Oct 2016 14:57:21 +0530
Subject: [PATCH v7 3/5] ARM: dts: imx6qdl-icore: Add usbhost support
In-Reply-To: <1476437243-13297-1-git-send-email-jteki@openedev.com>
References: <1476437243-13297-1-git-send-email-jteki@openedev.com>
Message-ID: <1476437243-13297-4-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jagan Teki <jagan@amarulasolutions.com>

Add usbhost support for Engicam i.CoreM6 dql modules.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v7:
        - none
Changes for v6:
        - none
Changes for v5:
        - none
Changes for v4:
        - new patch

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index f424cd5..ffec879 100644
--- a/arch/arm/boot/dts/imx6qdl-icore.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-icore.dtsi
@@ -56,6 +56,15 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	reg_usb_h1_vbus: usb_h1_vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb_h1_vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
 };
 
 &can1 {
@@ -109,6 +118,12 @@
 	status = "okay";
 };
 
+&usbh1 {
+	vbus-supply = <&reg_usb_h1_vbus>;
+	disable-over-current;
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
2.7.4
