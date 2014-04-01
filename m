From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue,  1 Apr 2014 09:42:20 +0200
Subject: [PATCH] fixup! i2c: efm32: new bus driver
In-Reply-To: <1395744526-3706-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1395744526-3706-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1396338140-22332-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix dt compatible string in the binding document which was changed
during review in the driver, but it seem I messed up to adapt the
documentation accordingly.

Also change status from "disabled" to "ok" which makes more sense for an
example.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 Documentation/devicetree/bindings/i2c/i2c-efm32.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
index ead4dd33ab66..fc15ac519437 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-efm32.txt
@@ -3,7 +3,7 @@
 Required properties :
 
  - reg : Offset and length of the register set for the device
- - compatible : should be "efm32,i2c"
+ - compatible : should be "energymicro,efm32-i2c"
  - interrupts : the interrupt number
  - clocks : reference to the module clock
 
@@ -17,12 +17,12 @@ Example:
 	i2c0: i2c at 4000a000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		compatible = "efm32,i2c";
+		compatible = "energymicro,efm32-i2c";
 		reg = <0x4000a000 0x400>;
 		interrupts = <9>;
 		clocks = <&cmu clk_HFPERCLKI2C0>;
 		clock-frequency = <100000>;
-		status = "disabled";
+		status = "ok";
 		efm32,location = <3>;
 
 		eeprom at 50 {
-- 
1.9.1
