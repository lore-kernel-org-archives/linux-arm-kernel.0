From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  9 Sep 2014 13:26:00 +0200
Subject: [PATCH 1/4] ARM: dts: imx28-tx28: remove spidev labels and add third
 instance of spidev
In-Reply-To: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
References: <1410261963-27956-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1410261963-27956-2-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The labels on the spidev nodes are not used and not required, so
remove them. The TX28 supports 3 chipselects on the SPI
interface. Make all those chipselects available to the user.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28-tx28.dts |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index f947fbb..4e790c2 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -619,17 +619,23 @@
 	clock-frequency = <57600000>;
 	status = "okay";
 
-	spidev0: spi at 0 {
+	spi at 0 {
 		compatible = "spidev";
 		reg = <0>;
 		spi-max-frequency = <57600000>;
 	};
 
-	spidev1: spi at 1 {
+	spi at 1 {
 		compatible = "spidev";
 		reg = <1>;
 		spi-max-frequency = <57600000>;
 	};
+
+	spi at 2 {
+		compatible = "spidev";
+		reg = <2>;
+		spi-max-frequency = <57600000>;
+	};
 };
 
 &usb0 {
-- 
1.7.10.4
