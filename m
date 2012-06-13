From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 13 Jun 2012 13:01:45 +0200
Subject: [PATCHv3 2/3] mm: vmalloc: add VM_DMA flag to indicate areas used by
 dma-mapping framework
In-Reply-To: <1339585306-7147-1-git-send-email-m.szyprowski@samsung.com>
References: <1339585306-7147-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1339585306-7147-3-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add new type of vm_area intented to be used for mappings created by
dma-mapping framework.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 include/linux/vmalloc.h |    1 +
 mm/vmalloc.c            |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 2e28f4d..e725b7b 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -14,6 +14,7 @@ struct vm_area_struct;		/* vma defining user mapping in mm_types.h */
 #define VM_USERMAP	0x00000008	/* suitable for remap_vmalloc_range */
 #define VM_VPAGES	0x00000010	/* buffer for pages was vmalloc'ed */
 #define VM_UNLIST	0x00000020	/* vm_struct is not listed in vmlist */
+#define VM_DMA		0x00000040	/* used by dma-mapping framework */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 11308f0..e04d59b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2575,6 +2575,9 @@ static int s_show(struct seq_file *m, void *p)
 	if (v->flags & VM_IOREMAP)
 		seq_printf(m, " ioremap");
 
+	if (v->flags & VM_DMA)
+		seq_printf(m, " dma");
+
 	if (v->flags & VM_ALLOC)
 		seq_printf(m, " vmalloc");
 
-- 
1.7.1.569.g6f426
