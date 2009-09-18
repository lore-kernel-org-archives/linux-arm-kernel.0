From: akpm@linux-foundation.org (akpm at linux-foundation.org)
Date: Fri, 18 Sep 2009 12:44:18 -0700
Subject: [patch 2/3] STMP3xxx: deallocation with negative index of
	descriptors[]
Message-ID: <200909181944.n8IJiI6k008786@imap1.linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roel Kluin <roel.kluin@gmail.com>

The last deallocation is invalid. In the last iteration, i is -1.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Acked-by: dmitry pervushin <dpervushin@embeddedalley.com>
Cc: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/plat-stmp3xxx/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/arm/plat-stmp3xxx/dma.c~stmp3xxx-deallocation-with-negative-index-of-descriptors arch/arm/plat-stmp3xxx/dma.c
--- a/arch/arm/plat-stmp3xxx/dma.c~stmp3xxx-deallocation-with-negative-index-of-descriptors
+++ a/arch/arm/plat-stmp3xxx/dma.c
@@ -264,7 +264,7 @@ int stmp3xxx_dma_make_chain(int ch, stru
 					stmp3xxx_dma_free_command(ch,
 								  &descriptors
 								  [i]);
-				} while (i-- >= 0);
+				} while (i-- > 0);
 			}
 			return err;
 		}
_
