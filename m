From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Tue, 23 Nov 2010 19:00:02 -0600
Subject: [PATCH] OMAP: ZOOM2: Change GPIO to enable LCD NEC NL8048HL11-01B on
	OMAP34x-II MDP
Message-ID: <1290560402-2507-1-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yanick Saugy <yanick.saugy@heig-vd.ch>

The PIN which controls LCD's reset signal (VGA_nRESET/h_GPIO_96) was not
configured as a GPIO. We had to modify the OMAP MUX, and select this PIN
(CAM_XCLKA) as an output GPIO (OMAP_MUX_MODE4). (kernel 2.6.35)

Be aware of changing this PIN will probably disable the camera, because
it was previously configured as a camera clock.

Signed-off-by: Yanick Saugy <yanick.saugy@heig-vd.ch>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---

I'm not sure if this patch was forgotten, hence resending. Without
it, a blanks screen is seen on zoom2 board.

Original patch:
http://patchwork.kernel.org/patch/196922/

 arch/arm/mach-omap2/board-zoom2.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-zoom2.c b/arch/arm/mach-omap2/board-zoom2.c
index 1cd6414..8fe578c 100644
--- a/arch/arm/mach-omap2/board-zoom2.c
+++ b/arch/arm/mach-omap2/board-zoom2.c
@@ -51,6 +51,8 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(ETK_D4, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
 	OMAP3_MUX(ETK_D5, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
 	OMAP3_MUX(ETK_D6, OMAP_MUX_MODE2 | OMAP_PIN_INPUT_PULLUP),
+	/* LCD Panel reset (PROD) - GPIO 96 */
+	OMAP3_MUX(CAM_XCLKA, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.7.1
