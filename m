From: felipe.contreras@gmail.com (Felipe Contreras)
Date: Fri, 15 Oct 2010 15:46:23 +0300
Subject: [PATCH 1/2] video: omap: vram: remove from normal memory
In-Reply-To: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
Message-ID: <1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So that we can ioremap happily.

Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 drivers/video/omap2/vram.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/vram.c b/drivers/video/omap2/vram.c
index f6fdc20..1a99777 100644
--- a/drivers/video/omap2/vram.c
+++ b/drivers/video/omap2/vram.c
@@ -575,6 +575,8 @@ void __init omap_vram_reserve_sdram_memblock(void)
 		}
 	} else {
 		paddr = memblock_alloc_base(size, PAGE_SIZE, MEMBLOCK_REAL_LIMIT);
+		memblock_free(paddr, size);
+		memblock_remove(paddr, size);
 	}
 
 	omap_vram_add_region(paddr, size);
-- 
1.7.3.1.2.g7fe2b
