From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 17 Oct 2017 10:53:28 +0200
Subject: [PATCH 06/12] ARM: dts: imx6-tx6: specify ethernet phy reset
 post-delay
In-Reply-To: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
References: <1508230414-8090-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1508230414-8090-7-git-send-email-LW@KARO-electronics.de>
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
index aa32956..c6b2d63 100644
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
