From: Anson.Huang@nxp.com (Anson Huang)
Date: Wed, 25 Apr 2018 13:36:07 +0800
Subject: [PATCH V4 2/6] ARM: dts: imx6sx-sabreauto: add max7322 IO expander
 support
In-Reply-To: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <1524634571-5914-2-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MAX7322 IO expander support.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no changes.
 arch/arm/boot/dts/imx6sx-sabreauto.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
index 2caca934..d59084f 100644
--- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
+++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
@@ -163,6 +163,13 @@
 	pinctrl-0 = <&pinctrl_i2c2_1>;
 	status = "okay";
 
+	max7322: gpio at 68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	pmic: pfuze100 at 08 {
 		compatible = "fsl,pfuze100";
 		reg = <0x08>;
-- 
2.7.4
