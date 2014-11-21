From: julien.chauveau@neo-technologies.fr (Julien CHAUVEAU)
Date: Fri, 21 Nov 2014 11:57:16 +0100
Subject: [PATCH] ARM: dts: rockchip: enable I2C0, SPI and SARADC on Radxa Rock
Message-ID: <1416567436-26706-1-git-send-email-julien.chauveau@neo-technologies.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables user space access to the I2C0 bus, SPI0 bus, SPI1 bus
and the 3 Analog-to-digital inputs available on the Radxa Rock headers.

We have to disable UART1 because SPI0 and UART1 are multiplexed together.

Signed-off-by: Julien CHAUVEAU <julien.chauveau@neo-technologies.fr>
---
 arch/arm/boot/dts/rk3188-radxarock.dts | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3188-radxarock.dts b/arch/arm/boot/dts/rk3188-radxarock.dts
index 6eb62c0..06b2256 100644
--- a/arch/arm/boot/dts/rk3188-radxarock.dts
+++ b/arch/arm/boot/dts/rk3188-radxarock.dts
@@ -122,6 +122,10 @@
 	cpu0-supply = <&vdd_arm>;
 };
 
+&i2c0 {
+	status = "okay";
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <400000>;
@@ -294,14 +298,22 @@
 	};
 };
 
+&saradc {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&spi1 {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
 
-&uart1 {
-	status = "okay";
-};
-
 &uart2 {
 	status = "okay";
 };
-- 
2.1.0
