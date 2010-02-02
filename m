From: wellsk40@gmail.com (wellsk40 at gmail.com)
Date: Tue,  2 Feb 2010 15:59:28 -0800
Subject: [PATCH 16/16] ARM: LPC32XX: Fix sparse errors on LCD code
In-Reply-To: <LPC32XX architecture files (updated)>
References: <LPC32XX architecture files (updated)>
Message-ID: <1265155168-28909-17-git-send-email-wellsk40@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Wells <wellsk40@gmail.com>

Added __force and corrected line length to fix sparse errors
and meet coding requirements.

Signed-off-by: Kevin Wells <wellsk40@gmail.com>
---
 arch/arm/mach-lpc32xx/phy3250.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index 846bc33..c7a6d9f 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -88,7 +88,8 @@ static int lpc32xx_clcd_setup(struct clcd_fb *fb)
 	fb->fb.screen_base = (char __iomem *) NULL;
 #ifdef CONFIG_MACH_LPC32XX_IRAM_FOR_CLCD
 	if (PANEL_SIZE <= CONFIG_ARCH_LPC32XX_IRAM_SIZE) {
-		fb->fb.screen_base = (char __iomem *) io_p2v(LPC32XX_IRAM_BASE);
+		fb->fb.screen_base = (__force char __iomem *)
+			io_p2v(LPC32XX_IRAM_BASE);
 		fb->fb.fix.smem_start = (dma_addr_t) LPC32XX_IRAM_BASE;
 	}
 #endif
-- 
1.6.6
