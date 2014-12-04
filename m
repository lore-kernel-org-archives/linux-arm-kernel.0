From: balbi@ti.com (Felipe Balbi)
Date: Thu, 4 Dec 2014 09:10:21 -0600
Subject: [PATCH] arm: boot: dts: am437x-sk: fix lcd enable pin mux data
In-Reply-To: <20141204144325.GA17269@saruman>
References: <20141204144325.GA17269@saruman>
Message-ID: <1417705821-21847-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caused by a copy & paste error. Note that even with
this bug AM437x SK display still works because GPIO
mux mode is always enabled. It's still wrong to mux
somebody else's pin.

Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
isn't used for anything.

While at that, also replace a pullup with a pulldown
as that gpio should be normally low, not high.

Cc: <stable@vger.kernel.org> # v3.17+
Acked-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index f7f77a7..0eceb8a 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -320,8 +320,7 @@
 
 	lcd_pins: lcd_pins {
 		pinctrl-single,pins = <
-			/* GPIO 5_8 to select LCD / HDMI */
-			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			0x1c (PIN_OUTPUT_PULLDOWN | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
 		>;
 	};
 };
-- 
2.1.0.GIT
