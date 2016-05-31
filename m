From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 31 May 2016 12:32:05 +0900
Subject: [RFC 1/4] ARM: dts: r8a7790: lager: rename i2cexio as i2cexio0
In-Reply-To: <1464665528-11398-1-git-send-email-horms+renesas@verge.net.au>
References: <1464665528-11398-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1464665528-11398-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is in preparation for adding i2cexio1 which will use the
dmuxer for IIC1/I2C0.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9d20ace33b01..71d62ca282ea 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -50,7 +50,7 @@
 	aliases {
 		serial0 = &scif0;
 		serial1 = &scifa1;
-		i2c8 = "i2cexio";
+		i2c8 = "i2cexio0";
 	};
 
 	chosen {
@@ -263,10 +263,10 @@
 	 * instantiate the slave device at runtime according to the documentation.
 	 * You can then communicate with the slave via IIC3.
 	 */
-	i2cexio: i2c-8 {
+	i2cexio0: i2c-8 {
 		compatible = "i2c-demux-pinctrl";
 		i2c-parent = <&iic0>, <&i2c0>;
-		i2c-bus-name = "i2c-exio";
+		i2c-bus-name = "i2c-exio0";
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -580,12 +580,12 @@
 
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
