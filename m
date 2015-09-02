From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  2 Sep 2015 15:16:22 -0300
Subject: [PATCH 3/3] ARM: dts: imx7d-sdb: Add USB support
In-Reply-To: <1441217782-6304-1-git-send-email-festevam@gmail.com>
References: <1441217782-6304-1-git-send-email-festevam@gmail.com>
Message-ID: <1441217782-6304-3-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Add support for USBOTG1 and USBOTG2.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index fdd1d7c..3c6cf52 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -231,6 +231,17 @@
 	status = "okay";
 };
 
+&usbotg1 {
+	vbus-supply = <&reg_usb_otg1_vbus>;
+	status = "okay";
+};
+
+&usbotg2 {
+	vbus-supply = <&reg_usb_otg2_vbus>;
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-- 
1.9.1
