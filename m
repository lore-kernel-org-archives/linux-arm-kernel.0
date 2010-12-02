From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu,  2 Dec 2010 14:11:18 -0800
Subject: [PATCH] arm: dma-mapping: move consistent_init to early_initcall
Message-ID: <1291327879-28073-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some machines require the use of coherent memory to bring up auxillary
cpus, and thus want to use dma_alloc_coherent prior to smp_init
completing.

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mm/dma-mapping.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index ac6a361..d46ce8d 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -177,7 +177,7 @@ static int __init consistent_init(void)
 	return ret;
 }
 
-core_initcall(consistent_init);
+early_initcall(consistent_init);
 
 static void *
 __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot)
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
