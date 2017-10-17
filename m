From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 11:17:57 +0200
Subject: [PATCHv3 06/12] ARM: dts: imx6-tx6: specify ethernet phy reset
 post-delay
In-Reply-To: <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
 <1508231883-12067-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508231883-12067-7-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Under certain circumstances the ethernet PHY cannot be detected on
Ka-Ro electronics TX6 modules. Using a phy-reset-post-delay of at least
2ms alleviates this problem. Define it to 10ms to be on the safe side.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index f2cd3e7..f1655b3 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -249,6 +249,7 @@
 	clock-names = "ipg", "ahb", "ptp", "enet_out";
 	phy-mode = "rmii";
 	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+	phy-reset-post-delay = <10>;
 	phy-handle = <&etnphy>;
 	phy-supply = <&reg_3v3_etn>;
 	status = "okay";
-- 
2.1.4
