From: tony@atomide.com (Tony Lindgren)
Date: Tue, 17 Mar 2015 17:19:19 -0700
Subject: [PATCH 2/4] ARM: dts: Fix typo for dm816x usb0_pins
In-Reply-To: <1426637961-4197-1-git-send-email-tony@atomide.com>
References: <1426637961-4197-1-git-send-email-tony@atomide.com>
Message-ID: <1426637961-4197-3-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a54879a00859 ("ARM: dts: Fix USB dts configuration for dm816x")
attempted to fix the USB features introduced by commit 7800064ba507
("ARM: dts: Add basic dm816x device tree configuration") but obviously
I did not read the dmesg as more USB issues still keep trickling in.

It should be usb1_pins instead not usb0_pins for the second interface
to avoid warnings from pinctrl framework.

Cc: Brian Hutchinson <b.hutchman@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dm8168-evm.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/dm8168-evm.dts b/arch/arm/boot/dts/dm8168-evm.dts
index afe678f..b520a8b 100644
--- a/arch/arm/boot/dts/dm8168-evm.dts
+++ b/arch/arm/boot/dts/dm8168-evm.dts
@@ -52,13 +52,13 @@
 
 	usb0_pins: pinmux_usb0_pins {
 		pinctrl-single,pins = <
-			DM816X_IOPAD(0x0d00, MUX_MODE0)			/* USB0_DRVVBUS */
+			DM816X_IOPAD(0x0d04, MUX_MODE0)			/* USB0_DRVVBUS */
 		>;
 	};
 
-	usb1_pins: pinmux_usb0_pins {
+	usb1_pins: pinmux_usb1_pins {
 		pinctrl-single,pins = <
-			DM816X_IOPAD(0x0d04, MUX_MODE0)			/* USB1_DRVVBUS */
+			DM816X_IOPAD(0x0d08, MUX_MODE0)			/* USB1_DRVVBUS */
 		>;
 	};
 };
-- 
2.1.4
