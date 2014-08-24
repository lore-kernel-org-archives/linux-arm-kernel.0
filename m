From: mark.roszko@gmail.com (Marek Roszko)
Date: Sat, 23 Aug 2014 23:12:06 -0400
Subject: [PATCH v2 3/3] pinctrl: at91: update documentation for drive strength
 options and tweaks
In-Reply-To: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
References: <1408849926-9603-1-git-send-email-mark.roszko@gmail.com>
Message-ID: <1408849926-9603-3-git-send-email-mark.roszko@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The drive strength patched introduced the atmel,sama5d-pinctrl compatible string.
Drive strength is now an option for the CONFIG bits per pin. Also added note about
MULTIDRIVE being equivalent to open-drain output and added missing "s" at the
end of need everywhere in the bits descriptions.

Signed-off-by: Marek Roszko <mark.roszko@gmail.com>
---
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 02ab5ab..b7a93e8 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -19,6 +19,7 @@ such as pull-up, multi drive, etc.
 
 Required properties for iomux controller:
 - compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
+		or "atmel,sama5d3-pinctrl"
 - atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
   configured in this periph mode. All the periph and bank need to be describe.
 
@@ -85,13 +86,20 @@ Required properties for pin configuration node:
   PIN_BANK 0 is pioA, PIN_BANK 1 is pioB...
 
 Bits used for CONFIG:
-PULL_UP		(1 << 0): indicate this pin need a pull up.
-MULTIDRIVE	(1 << 1): indicate this pin need to be configured as multidrive.
-DEGLITCH	(1 << 2): indicate this pin need deglitch.
-PULL_DOWN	(1 << 3): indicate this pin need a pull down.
-DIS_SCHMIT	(1 << 4): indicate this pin need to disable schmit trigger.
-DEBOUNCE	(1 << 16): indicate this pin need debounce.
-DEBOUNCE_VAL	(0x3fff << 17): debounce val.
+PULL_UP		(1 << 0): indicate this pin needs a pull up.
+MULTIDRIVE	(1 << 1): indicate this pin needs to be configured as multi-drive.
+			Multi-drive is equivalent to open-drain type output.
+DEGLITCH	(1 << 2): indicate this pin needs deglitch.
+PULL_DOWN	(1 << 3): indicate this pin needs a pull down.
+DIS_SCHMIT	(1 << 4): indicate this pin needs to the disable schmitt trigger.
+DRIVE_STRENGTH (3 << 5): indicate the drive strength of the pin using the
+			following values:
+				00 - No change (reset state value kept)
+				01 - Low
+				10 - Medium
+				11 - High
+DEBOUNCE	(1 << 16): indicate this pin needs debounce.
+DEBOUNCE_VAL	(0x3fff << 17): debounce value.
 
 NOTE:
 Some requirements for using atmel,at91rm9200-pinctrl binding:
-- 
1.9.1
