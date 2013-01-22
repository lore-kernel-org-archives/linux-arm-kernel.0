From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 22 Jan 2013 18:50:41 +0100
Subject: [PATCH 1/6] ARM: at91/at91-pinctrl documentation: fix typo and add
 some details
In-Reply-To: <cover.1358876553.git.nicolas.ferre@atmel.com>
References: <cover.1358876553.git.nicolas.ferre@atmel.com>
Message-ID: <78cd1baa823719d7f07f051528eb83e0f902b6ed.1358876553.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

The relation between PIN_BANK numbers and pio letters wasn't made very
clear.

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

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
1.8.0
