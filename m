From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 13:57:03 +0100
Subject: [PATCH 3/6] ARM: dts: imx6qdl-tx6: add ENET_OUT clock to fec node
In-Reply-To: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
References: <1453294626-17608-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453294626-17608-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ENET_OUT is used as reference clock for the ethernet PHY on the Ka-Ro
TX6 modules. Specify this clock in DTB to let it be managed correctly
by the driver.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index 9404668..5e0afc8 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -227,6 +227,11 @@
 &fec {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
+	clocks = <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET>,
+		 <&clks IMX6QDL_CLK_ENET_REF>,
+		 <&clks IMX6QDL_CLK_ENET_REF>;
+	clock-names = "ipg", "ahb", "ptp", "enet_out";
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_HIGH>;
 	phy-supply = <&reg_3v3_etn>;
-- 
2.1.4
