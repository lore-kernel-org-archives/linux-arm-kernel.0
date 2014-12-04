From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 11:01:55 -0600
Subject: [PATCH 2/6] arm: boot: dts: am437x-sk: add explicit MMC0 pinmux
In-Reply-To: <1417712519-4615-1-git-send-email-balbi@ti.com>
References: <1417712519-4615-1-git-send-email-balbi@ti.com>
Message-ID: <1417712519-4615-3-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By don't relying on implicit MMC0 pulldown we
make sure that pins are marked busy and even
if we have a broken bootloader, MMC0 will
remain functional.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index d0ce2d4..5d872f6 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -167,6 +167,12 @@
 
 	mmc1_pins: pinmux_mmc1_pins {
 		pinctrl-single,pins = <
+			0x0f0 (PIN_INPUT | MUX_MODE0) /* mmc0_dat3.mmc0_dat3 */
+			0x0f4 (PIN_INPUT | MUX_MODE0) /* mmc0_dat2.mmc0_dat2 */
+			0x0f8 (PIN_INPUT | MUX_MODE0) /* mmc0_dat1.mmc0_dat1 */
+			0x0fc (PIN_INPUT | MUX_MODE0) /* mmc0_dat0.mmc0_dat0 */
+			0x100 (PIN_INPUT | MUX_MODE0) /* mmc0_clk.mmc0_clk */
+			0x104 (PIN_INPUT | MUX_MODE0) /* mmc0_cmd.mmc0_cmd */
 			0x160 (PIN_INPUT | MUX_MODE7) /* spi0_cs1.gpio0_6 */
 		>;
 	};
-- 
2.1.0.GIT
