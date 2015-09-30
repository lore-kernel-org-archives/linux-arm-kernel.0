From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 30 Sep 2015 10:47:11 +0200
Subject: [PATCH 2/2] i2c: at91: update documentation for new "atmel,
 twd-hold-cycles" property
In-Reply-To: <1443602831-27069-1-git-send-email-ludovic.desroches@atmel.com>
References: <1443602831-27069-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1443602831-27069-2-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wenyou Yang <wenyou.yang@atmel.com>

Add a DT property "atmel,twd-hold-cycles" to specify the HOLD
field of TWIHS_CWGR register to increase the TWD hold time.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/devicetree/bindings/i2c/i2c-at91.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-at91.txt b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
index 6e81dc1..f14c0b2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-at91.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-at91.txt
@@ -17,6 +17,8 @@ Optional properties:
 - dma-names: should contain "tx" and "rx".
 - atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
   capable I2C controllers.
+- atmel,twd-hold-cycles: increase the TWD hold time by
+  (atmel,twd-hold-cycles + 3) x t_periperal_clk, maximum value is 0x1f.
 - Child nodes conforming to i2c bus binding
 
 Examples :
@@ -29,6 +31,7 @@ i2c0: i2c at fff84000 {
 	#size-cells = <0>;
 	clocks = <&twi0_clk>;
 	clock-frequency = <400000>;
+	atmel,twd-hold-cycles = <2>;
 
 	24c512 at 50 {
 		compatible = "24c512";
-- 
2.5.0
