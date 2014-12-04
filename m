From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:01:54 -0600
Subject: [PATCH 1/6] arm: boot: dts: am437x-sk: remove internal pulls from QSPI
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Message-ID: <1417712519-4615-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

QSPI doesn't need any pullups of any sort,
let's remove them.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 0eceb8a..d0ce2d4 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -300,12 +300,12 @@
 
 	qspi_pins: qspi_pins {
 		pinctrl-single,pins = <
-			0x7c (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
-			0x88 (PIN_OUTPUT | MUX_MODE2)		/* gpmc_csn3.qspi_clk */
-			0x90 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
-			0x94 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
-			0x98 (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
-			0x9c (PIN_INPUT_PULLUP | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
+			0x7c (PIN_OUTPUT | MUX_MODE3)	/* gpmc_csn0.qspi_csn */
+			0x88 (PIN_OUTPUT | MUX_MODE2)	/* gpmc_csn3.qspi_clk */
+			0x90 (PIN_INPUT | MUX_MODE3)	/* gpmc_advn_ale.qspi_d0 */
+			0x94 (PIN_INPUT | MUX_MODE3)	/* gpmc_oen_ren.qspi_d1 */
+			0x98 (PIN_INPUT | MUX_MODE3)	/* gpmc_wen.qspi_d2 */
+			0x9c (PIN_INPUT | MUX_MODE3)	/* gpmc_be0n_cle.qspi_d3 */
 		>;
 	};
 
-- 
2.1.0.GIT
