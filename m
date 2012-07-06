From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri,  6 Jul 2012 15:19:12 +0200
Subject: [PATCH v2 2/2] ARM: OMAP: board-omap4panda: MUX configuration for
 sys_nirq2
In-Reply-To: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
References: <1341580752-5501-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1341580752-5501-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sys_nirq2 is used for twl6040, make sure the pin is configured
correctly.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 982fb26..b627cdc 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -379,6 +379,9 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP4_MUX(DPM_EMU18, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
 	/* dispc2_data0 */
 	OMAP4_MUX(DPM_EMU19, OMAP_PIN_OUTPUT | OMAP_MUX_MODE5),
+	/* NIRQ2 for twl6040 */
+	OMAP4_MUX(SYS_NIRQ2, OMAP_MUX_MODE0 |
+		  OMAP_PIN_INPUT_PULLUP | OMAP_PIN_OFF_WAKEUPENABLE),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 
-- 
1.7.8.6
