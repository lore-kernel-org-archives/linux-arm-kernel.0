From: jassi.brar@samsung.com (Jassi)
Date: Tue, 15 Sep 2009 19:01:24 +0900
Subject: [PATCH 6/7] S3C64XX DMA: dbg_showbuffs cleanup
Message-ID: <1253008884-7657-1-git-send-email-jassi.brar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removed unused variable and cleaned up.

Signed-Off-by: Jassi <jassi.brar@samsung.com>
---
 arch/arm/plat-s3c64xx/dma.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/arch/arm/plat-s3c64xx/dma.c b/arch/arm/plat-s3c64xx/dma.c
index e68469d..727072b 100644
--- a/arch/arm/plat-s3c64xx/dma.c
+++ b/arch/arm/plat-s3c64xx/dma.c
@@ -71,20 +71,14 @@ static void show_lli(struct pl080s_lli *lli)
 static void dbg_showbuffs(struct s3c2410_dma_chan *chan)
 {
 	struct s3c64xx_dma_buff *ptr;
-	struct s3c64xx_dma_buff *end;
 
 	pr_debug("DMA%d: buffs next %p, curr %p, end %p\n",
 		 chan->number, chan->next, chan->curr, chan->end);
 
-	ptr = chan->next;
-	end = chan->end;
-
-	if (debug_show_buffs) {
-		for (; ptr != NULL; ptr = ptr->next) {
-			pr_debug("DMA%d: %08x ",
-				 chan->number, ptr->lli_dma);
-			show_lli(ptr->lli);
-		}
+	for (ptr = chan->curr; debug_show_buffs && ptr != NULL; ptr = ptr->next) {
+		pr_debug("DMA%d: %08x \n",
+			 chan->number, ptr->lli_dma);
+		show_lli(ptr->lli);
 	}
 }
 
-- 
1.6.2.5
