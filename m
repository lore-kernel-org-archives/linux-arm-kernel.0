From: sdu.liu@huawei.com (Liu Hua)
Date: Fri, 11 Apr 2014 16:00:51 +0800
Subject: [PATCH v2 1/2] ARM : DMA : remove useless information about DMA
In-Reply-To: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
References: <1397203252-22977-1-git-send-email-sdu.liu@huawei.com>
Message-ID: <1397203252-22977-2-git-send-email-sdu.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because commit e9da6e9905e6 has remove custom consistent dma
region. So the related variable and document should be removed

Signed-off-by: Liu Hua <sdu.liu@huawei.com>
---
 Documentation/arm/memory.txt  | 4 ----
 arch/arm/include/asm/memory.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/Documentation/arm/memory.txt b/Documentation/arm/memory.txt
index 4bfb9ff..8a361c0 100644
--- a/Documentation/arm/memory.txt
+++ b/Documentation/arm/memory.txt
@@ -44,10 +44,6 @@ fffe0000	fffe7fff	ITCM mapping area for platforms with
 fff00000	fffdffff	Fixmap mapping region.  Addresses provided
 				by fix_to_virt() will be located here.
 
-ffc00000	ffefffff	DMA memory mapping region.  Memory returned
-				by the dma_alloc_xxx functions will be
-				dynamically mapped here.
-
 ff000000	ffbfffff	Reserved for future expansion of DMA
 				mapping region.
 
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 02fa255..2b75146 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -83,8 +83,6 @@
  */
 #define IOREMAP_MAX_ORDER	24
 
-#define CONSISTENT_END		(0xffe00000UL)
-
 #else /* CONFIG_MMU */
 
 /*
-- 
1.9.0
