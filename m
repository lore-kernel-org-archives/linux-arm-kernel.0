From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  9 Sep 2014 16:54:30 +0200
Subject: [RFC 4/4] ARM: shmobile: r8a7790: adapt DTS for I2C slave support
In-Reply-To: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
References: <1410274470-12712-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1410274470-12712-5-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Not for upstream!

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 856b4236b674..12aa2f21e6fa 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -205,9 +205,9 @@
 		renesas,function = "msiof1";
 	};
 
-	iic1_pins: iic1 {
-		renesas,groups = "iic1";
-		renesas,function = "iic1";
+	i2c1_pins: i2c1 {
+		renesas,groups = "i2c1";
+		renesas,function = "i2c1";
 	};
 
 	iic2_pins: iic2 {
@@ -356,10 +356,15 @@
 	status = "ok";
 };
 
-&iic1	{
+&i2c1	{
 	status = "ok";
-	pinctrl-0 = <&iic1_pins>;
+	pinctrl-0 = <&i2c1_pins>;
 	pinctrl-names = "default";
+
+	eeprom at 64 {
+		compatible = "slave-24c02";
+		reg = <0x64>;
+	};
 };
 
 &iic2	{
-- 
2.0.0
