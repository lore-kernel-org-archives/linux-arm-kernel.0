From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 21 Jan 2014 18:13:29 +0200
Subject: [PATCH 1/4] ARM: dts: cm-fx6: rearrange the dts file
In-Reply-To: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1390320812-25100-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the iomuxc definition before the devices definitions
(e.g. gpmi, fec).

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx6q-cm-fx6.dts | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
index 1a8ee79..94cc6b5 100644
--- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
+++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
@@ -31,19 +31,8 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
-};
 
-&fec {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_enet>;
-	phy-mode = "rgmii";
-	status = "okay";
-};
 
-&gpmi {
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_gpmi_nand>;
-	status = "okay";
 };
 
 &iomuxc {
@@ -62,6 +51,19 @@
 	};
 };
 
+&fec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet>;
+	phy-mode = "rgmii";
+	status = "okay";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand>;
+	status = "okay";
+};
+
 &uart4 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart4>;
-- 
1.8.3.2
