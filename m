From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Mon, 12 Sep 2016 00:00:40 +0530
Subject: [PATCH v4 4/5] ARM: dts: imx6qdl-icore: Add usbhost support
In-Reply-To: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
References: <1473618641-10159-1-git-send-email-jagan@amarulasolutions.com>
Message-ID: <1473618641-10159-5-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add usbhost support for Engicam i.CoreM6 dql modules.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v4:
	- Newly added patch

 arch/arm/boot/dts/imx6qdl-icore.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-icore.dtsi b/arch/arm/boot/dts/imx6qdl-icore.dtsi
index b99ee0b..b4f7e64 100644
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
@@ -110,6 +119,12 @@
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
