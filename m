From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 22 Jun 2016 12:43:39 +0900
Subject: [PATCH v3 01/13] ARM: dts: lager: rename and reindex i2cexio
In-Reply-To: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
References: <1466567031-20381-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1466567031-20381-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rename from i2cexio to i2cexio0 is in in preparation for adding
i2cexio1 which will use the dmuxer for IIC1/I2C1.

The reindexing from i2c8 to i2c10 is to allow space for grouping of
additional GPIO buses to added by follow-up patches to support demuxing of
other i2c buses.

Also note that fallback to GPIO is not provided by the hardware for IIC1/I2C1.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v2:
* Reindex i2c
* Add note that GPIO fallback is not provided by hardware
---
 arch/arm/boot/dts/r8a7790-lager.dts | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 52b56fcaddf2..6b25d9e7d21b 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -50,7 +50,7 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scifa1;
-		i2c8 = "i2cexio";
+		i2c10 = "i2cexio0";
 	};
 
 	chosen {
@@ -262,11 +262,13 @@
 	 * bus with IIC3 on pins 110 (SCL) + 112 (SDA), select I2C0 at runtime, and
 	 * instantiate the slave device at runtime according to the documentation.
 	 * You can then communicate with the slave via IIC3.
+	 *
+	 * IIC0/I2C0 does not appear to support fallback to GPIO.
 	 */
-	i2cexio: i2c-8 {
+	i2cexio0: i2c-10 {
 		compatible = "i2c-demux-pinctrl";
 		i2c-parent = <&iic0>, <&i2c0>;
-		i2c-bus-name = "i2c-exio";
+		i2c-bus-name = "i2c-exio0";
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -580,12 +582,12 @@
 
 &i2c0	{
 	pinctrl-0 = <&i2c0_pins>;
-	pinctrl-names = "i2c-exio";
+	pinctrl-names = "i2c-exio0";
 };
 
 &iic0	{
 	pinctrl-0 = <&iic0_pins>;
-	pinctrl-names = "i2c-exio";
+	pinctrl-names = "i2c-exio0";
 };
 
 &iic1	{
-- 
2.1.4
