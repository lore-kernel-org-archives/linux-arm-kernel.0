From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:01:59 -0600
Subject: [PATCH 6/6] arm: boot: dts: am437x-sk: remove DSS pulls
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Message-ID: <1417712519-4615-7-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DSS data lines don't need pulls, it's best
to remove them to guarantee signal integrity.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index f8db9b9..b459bd3 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -272,34 +272,34 @@
 
 	dss_pins: dss_pins {
 		pinctrl-single,pins = <
-			0x020 (PIN_OUTPUT_PULLUP | MUX_MODE1)	/* gpmc ad 8 -> DSS DATA 23 */
-			0x024 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x028 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x02c (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x030 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x034 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x038 (PIN_OUTPUT_PULLUP | MUX_MODE1)
-			0x03c (PIN_OUTPUT_PULLUP | MUX_MODE1)	/* gpmc ad 15 -> DSS DATA 16 */
-			0x0a0 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS DATA 0 */
-			0x0a4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0a8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0ac (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0b0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0b4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0b8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0bc (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0c0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0c4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0c8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0cc (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0d0 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0d4 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0d8 (PIN_OUTPUT_PULLUP | MUX_MODE0)
-			0x0dc (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS DATA 15 */
-			0x0e0 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS VSYNC */
-			0x0e4 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS HSYNC */
-			0x0e8 (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS PCLK */
-			0x0ec (PIN_OUTPUT_PULLUP | MUX_MODE0)	/* DSS AC BIAS EN */
+			0x020 (PIN_OUTPUT | MUX_MODE1)	/* gpmc ad 8 -> DSS DATA 23 */
+			0x024 (PIN_OUTPUT | MUX_MODE1)
+			0x028 (PIN_OUTPUT | MUX_MODE1)
+			0x02c (PIN_OUTPUT | MUX_MODE1)
+			0x030 (PIN_OUTPUT | MUX_MODE1)
+			0x034 (PIN_OUTPUT | MUX_MODE1)
+			0x038 (PIN_OUTPUT | MUX_MODE1)
+			0x03c (PIN_OUTPUT | MUX_MODE1)	/* gpmc ad 15 -> DSS DATA 16 */
+			0x0a0 (PIN_OUTPUT | MUX_MODE0)	/* DSS DATA 0 */
+			0x0a4 (PIN_OUTPUT | MUX_MODE0)
+			0x0a8 (PIN_OUTPUT | MUX_MODE0)
+			0x0ac (PIN_OUTPUT | MUX_MODE0)
+			0x0b0 (PIN_OUTPUT | MUX_MODE0)
+			0x0b4 (PIN_OUTPUT | MUX_MODE0)
+			0x0b8 (PIN_OUTPUT | MUX_MODE0)
+			0x0bc (PIN_OUTPUT | MUX_MODE0)
+			0x0c0 (PIN_OUTPUT | MUX_MODE0)
+			0x0c4 (PIN_OUTPUT | MUX_MODE0)
+			0x0c8 (PIN_OUTPUT | MUX_MODE0)
+			0x0cc (PIN_OUTPUT | MUX_MODE0)
+			0x0d0 (PIN_OUTPUT | MUX_MODE0)
+			0x0d4 (PIN_OUTPUT | MUX_MODE0)
+			0x0d8 (PIN_OUTPUT | MUX_MODE0)
+			0x0dc (PIN_OUTPUT | MUX_MODE0)	/* DSS DATA 15 */
+			0x0e0 (PIN_OUTPUT | MUX_MODE0)	/* DSS VSYNC */
+			0x0e4 (PIN_OUTPUT | MUX_MODE0)	/* DSS HSYNC */
+			0x0e8 (PIN_OUTPUT | MUX_MODE0)	/* DSS PCLK */
+			0x0ec (PIN_OUTPUT | MUX_MODE0)	/* DSS AC BIAS EN */
 
 		>;
 	};
-- 
2.1.0.GIT
