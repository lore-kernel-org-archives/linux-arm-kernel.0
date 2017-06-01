From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 1 Jun 2017 22:49:06 +0200
Subject: [PATCH 2/5] ARM: OMAP1: DMA: Delete an error message for a failed
 memory allocation in omap1_system_dma_init()
In-Reply-To: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
References: <85e2ec7f-f650-28a2-6cc5-0b4b52e44183@users.sourceforge.net>
Message-ID: <cda37778-b59c-ae5e-529d-b435750dcd8f@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 1 Jun 2017 21:54:36 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap1/dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap1/dma.c b/arch/arm/mach-omap1/dma.c
index 823dba3dc033..c545b4e01d53 100644
--- a/arch/arm/mach-omap1/dma.c
+++ b/arch/arm/mach-omap1/dma.c
@@ -343,6 +343,4 @@ static int __init omap1_system_dma_init(void)
 	if (!d) {
-		dev_err(&pdev->dev, "%s: Unable to allocate 'd' for %s\n",
-			__func__, pdev->name);
 		ret = -ENOMEM;
 		goto exit_iounmap;
 	}
-- 
2.13.0
