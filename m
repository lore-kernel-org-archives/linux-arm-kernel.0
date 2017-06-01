From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 22:50:06 +0200
Subject: [PATCH 3/5] ARM: OMAP1: DMA: Delete an unnecessary return statement
 in omap1_show_dma_caps()
In-Reply-To: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
References: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Message-ID: <3790e998-2d64-aef8-28ab-1bdad153738a@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 22:00:21 +0200

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap1/dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index c545b4e01d53..52d7eda1adec 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -240,7 +240,6 @@ static void omap1_show_dma_caps(void)
 		w |= 1 << 3;
 		dma_write(w, GSCR, 0);
 	}
-	return;
 }
 
 static unsigned configure_dma_errata(void)
-- 
2.13.0
