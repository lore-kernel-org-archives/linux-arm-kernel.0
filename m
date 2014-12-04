From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:01:58 -0600
Subject: [PATCH 5/6] arm: boot: dts: am437x-sk: remove internal i2c pullups
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Message-ID: <1417712519-4615-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM437x Starter Kit already has discrete pullups
for all I2C buses, so we can (and should) remove
internal pulls.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 5ca9ee7..f8db9b9 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -153,15 +153,15 @@
 
 	i2c0_pins: i2c0_pins {
 		pinctrl-single,pins = <
-			0x188 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
-			0x18c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
+			0x188 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_sda.i2c0_sda */
+			0x18c (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE0)  /* i2c0_scl.i2c0_scl */
 		>;
 	};
 
 	i2c1_pins: i2c1_pins {
 		pinctrl-single,pins = <
-			0x15c (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
-			0x158 (PIN_INPUT_PULLUP | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
+			0x15c (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_cs0.i2c1_scl */
+			0x158 (PIN_INPUT | SLEWCTRL_FAST | MUX_MODE2)  /* spi0_d1.i2c1_sda  */
 		>;
 	};
 
-- 
2.1.0.GIT
