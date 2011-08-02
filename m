From: julia@diku.dk (Julia Lawall)
Date: Tue,  2 Aug 2011 12:34:56 +0200
Subject: [PATCH 3/11] arch/arm/mach-s3c64xx/dma.c: trivial: use BUG_ON
In-Reply-To: <1312281304-11847-1-git-send-email-julia@diku.dk>
References: <1312281304-11847-1-git-send-email-julia@diku.dk>
Message-ID: <1312281304-11847-4-git-send-email-julia@diku.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <julia@diku.dk>

Use BUG_ON(x) rather than if(x) BUG();

The semantic patch that fixes this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@ identifier x; @@
-if (x) BUG();
+BUG_ON(x);

@@ identifier x; @@
-if (!x) BUG();
+BUG_ON(!x);
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 arch/arm/mach-s3c64xx/dma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -u -p a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -603,8 +603,7 @@ static irqreturn_t s3c64xx_dma_irq(int i
 				&& buff->next != chan->next)
 			buff = buff->next;
 
-		if (!buff)
-			BUG();
+		BUG_ON(!buff);
 
 		if (buff == chan->next)
 			buff = chan->end;
