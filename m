From: nm@ti.com (Nishanth Menon)
Date: Thu, 9 Apr 2015 17:33:16 -0500
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Switch UART mux pins
In-Reply-To: <1428618797-17190-1-git-send-email-nm@ti.com>
References: <1428618797-17190-1-git-send-email-nm@ti.com>
Message-ID: <1428618797-17190-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BeagleBoard-X15 pre-production change includes switching over to UART
pins that now allow for UART download capability. All original boards
should either have been returned for modifications or already modified
for the required change and maintaining compatibility for older boards
are no longer needed.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 15f198e4864d..cea3be3a051c 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -130,8 +130,8 @@
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			0x248 (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd.rxd */
-			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd.txd */
+			0x3f8 (PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
+			0x3fc (PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
 		>;
 	};
 
-- 
1.7.9.5
