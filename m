From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 21 Jul 2010 20:33:38 +0300
Subject: [PATCH v2 04/20] omap zoom2: wlan board muxing
In-Reply-To: <1279733634-21974-1-git-send-email-ohad@wizery.com>
References: <1279733634-21974-1-git-send-email-ohad@wizery.com>
Message-ID: <1279733634-21974-5-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add board muxing to support the wlan wl1271 chip that is
hardwired to mmc2 (third mmc controller) on the ZOOM2.

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 arch/arm/mach-omap2/board-zoom2.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 803ef14..1520a2c 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -71,6 +71,19 @@ static struct twl4030_platform_data zoom2_twldata = {
 
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
