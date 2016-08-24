From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 24 Aug 2016 17:57:27 +0200
Subject: [PATCH] ARM: plat-pxa: Use kmalloc_array() in pxa_dma_init_debugfs()
Message-ID: <b10c8b2d-1cc7-1d81-3205-d84621791684@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 24 Aug 2016 17:45:51 +0200

A multiplication for the size determination of a memory allocation
indicated that an array data structure should be processed.
Thus reuse the corresponding function "kmalloc_array".

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/plat-pxa/dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-pxa/dma.c b/arch/arm/plat-pxa/dma.c
index de2b061..50aa995 100644
--- a/arch/arm/plat-pxa/dma.c
+++ b/arch/arm/plat-pxa/dma.c
@@ -237,8 +237,9 @@ static void pxa_dma_init_debugfs(void)
 	if (!dbgfs_state)
 		goto err_state;
 
-	dbgfs_chan = kmalloc(sizeof(*dbgfs_state) * num_dma_channels,
-			     GFP_KERNEL);
+	dbgfs_chan = kmalloc_array(num_dma_channels,
+				   sizeof(*dbgfs_state),
+				   GFP_KERNEL);
 	if (!dbgfs_chan)
 		goto err_alloc;
 
-- 
2.9.3
