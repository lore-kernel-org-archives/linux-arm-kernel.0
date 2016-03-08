From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  8 Mar 2016 09:04:00 +0100
Subject: [PATCHv2 4/8] ARM: dts: imx6-tx6: disable the spi node by default
In-Reply-To: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
References: <1457424244-14549-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1457424244-14549-5-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The spidev driver doesn't like to be instantiated via a naked 'spidev'
compatible, though it is very convenient to invoke it this way without
a dedicated SPI device for basic functional testing.
Disable the spi node by default to silence the WARN_ON() from the
spidev driver, but leave the configuration intact otherwise.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6qdl-tx6.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-tx6.dtsi b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
index ec374f5..9509b44 100644
--- a/arch/arm/boot/dts/imx6qdl-tx6.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-tx6.dtsi
@@ -224,7 +224,7 @@
 		&gpio2 30 GPIO_ACTIVE_HIGH
 		&gpio3 19 GPIO_ACTIVE_HIGH
 	>;
-	status = "okay";
+	status = "disabled";
 
 	spidev0: spi at 0 {
 		compatible = "spidev";
-- 
2.1.4
