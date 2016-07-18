From: jun.li@nxp.com (Li Jun)
Date: Mon, 18 Jul 2016 19:15:46 +0800
Subject: [PATCH 3/4] ARM: dts: imx7d-sdb: Set OTG2 oc polarity to be active low
In-Reply-To: <1468840547-17899-1-git-send-email-jun.li@nxp.com>
References: <1468840547-17899-1-git-send-email-jun.li@nxp.com>
Message-ID: <1468840547-17899-3-git-send-email-jun.li@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set OTG2 over current flag to be active low, OTG1 OC is not used
by default.

Signed-off-by: Li Jun <jun.li@nxp.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index b267f79..44ed399 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -287,7 +287,9 @@
 
 &usbotg2 {
 	vbus-supply = <&reg_usb_otg2_vbus>;
+	pinctrl-0 = <&pinctrl_usbotg2>;
 	dr_mode = "host";
+	over-current-polarity = <0>;
 	status = "okay";
 };
 
@@ -415,6 +417,12 @@
 			>;
 		};
 
+		pinctrl_usbotg2: usbotg2grp {
+			fsl,pins = <
+				MX7D_PAD_GPIO1_IO06__USB_OTG2_OC	0x59
+			>;
+		};
+
 		pinctrl_usdhc1: usdhc1grp {
 			fsl,pins = <
 				MX7D_PAD_SD1_CMD__SD1_CMD		0x59
-- 
1.9.1
