From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  5 Dec 2016 17:28:39 -0200
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: Pass the 'phy-reset-duration'
 property
Message-ID: <1480966119-17350-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

imx6sx-udoo-neo has a KSZ8091 Ethernet PHY, which requires the reset
signal to be low for at least 10ms.

Pass the 'phy-reset-duration' property to reflect such requirement.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx-udoo-neo.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
index 2b65d26..d1ce9af 100644
--- a/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
+++ b/arch/arm/boot/dts/imx6sx-udoo-neo.dtsi
@@ -86,6 +86,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet1>;
 	phy-mode = "rmii";
+	phy-reset-duration = <10>;
 	phy-reset-gpios = <&gpio2 1 GPIO_ACTIVE_LOW>;
 };
 
-- 
2.7.4
