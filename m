From: richard.genoud@gmail.com (Richard Genoud)
Date: Fri, 18 Jan 2013 17:38:43 +0100
Subject: [PATCH] Documentation at91-pinctrl: fix typo and add some details
Message-ID: <1358527123-22751-1-git-send-email-richard.genoud@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The relation between PIN_BANK numbers and pio letters wasn't made very
clear.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 3a26812..bc50899 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -81,7 +81,8 @@ PA31	TXD4
 Required properties for pin configuration node:
 - atmel,pins: 4 integers array, represents a group of pins mux and config
   setting. The format is atmel,pins = <PIN_BANK PIN_BANK_NUM PERIPH CONFIG>.
-  The PERIPH 0 means gpio.
+  The PERIPH 0 means gpio, PERIPH 1 is periph A, PERIPH 2 is periph B...
+  PIN_BANK 0 is pioA, PIN_BANK 1 is pioB...
 
 Bits used for CONFIG:
 PULL_UP		(1 << 0): indicate this pin need a pull up.
@@ -126,7 +127,7 @@ pinctrl@fffff400 {
 		pinctrl_dbgu: dbgu-0 {
 			atmel,pins =
 				<1 14 0x1 0x0	/* PB14 periph A */
-				 1 15 0x1 0x1>;	/* PB15 periph with pullup */
+				 1 15 0x1 0x1>;	/* PB15 periph A with pullup */
 		};
 	};
 };
-- 
1.7.2.5
