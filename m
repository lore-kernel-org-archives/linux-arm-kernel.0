From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 21 Jul 2010 20:33:39 +0300
Subject: [PATCH v2 05/20] omap zoom3: wlan board muxing
In-Reply-To: <1279733634-21974-1-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
Message-ID: <1279733634-21974-6-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board muxing to support the wlan wl1271 chip that is
hardwired to mmc2 (third mmc controller) on the ZOOM3.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/board-zoom3.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom3.c b/arch/arm/mach-omap2/board-zoom3.c
index 3314704..7d17046 100644
--- a/arch/arm/mach-omap2/board-zoom3.c
+++ b/arch/arm/mach-omap2/board-zoom3.c
@@ -46,6 +46,19 @@ static void __init omap_zoom_init_irq(void)
 
 #ifdef CONFIG_OMAP_MUX
 static struct omap_board_mux board_mux[] __initdata = {
+	/* WLAN IRQ - GPIO 162 */
+	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN POWER ENABLE - GPIO 101 */
+	OMAP3_MUX(CAM_D2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/* WLAN SDIO: MMC3 CMD */
+	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE3 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC3 CLK */
+	OMAP3_MUX(ETK_CLK, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	/* WLAN SDIO: MMC3 DAT[0-3] */
+	OMAP3_MUX(ETK_D3, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(ETK_D4, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(ETK_D5, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.7.0.4
