From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 21 Apr 2014 16:13:08 +0200
Subject: [PATCH 8/9] iommu/ipmmu-vmsa: Remove stage 2 PTE bits definitions
In-Reply-To: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1398089589-9181-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1398089589-9181-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't support stage 2 translation yet.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/ipmmu-vmsa.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 0e4d145..711e5c4 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -202,14 +202,6 @@ static LIST_HEAD(ipmmu_devices);
 #define ARM_VMSA_PTE_ATTRINDX_SHIFT	2
 #define ARM_VMSA_PTE_nG			(((pteval_t)1) << 11)
 
-/* Stage-2 PTE */
-#define ARM_VMSA_PTE_HAP_FAULT		(((pteval_t)0) << 6)
-#define ARM_VMSA_PTE_HAP_READ		(((pteval_t)1) << 6)
-#define ARM_VMSA_PTE_HAP_WRITE		(((pteval_t)2) << 6)
-#define ARM_VMSA_PTE_MEMATTR_OIWB	(((pteval_t)0xf) << 2)
-#define ARM_VMSA_PTE_MEMATTR_NC		(((pteval_t)0x5) << 2)
-#define ARM_VMSA_PTE_MEMATTR_DEV	(((pteval_t)0x1) << 2)
-
 #define ARM_VMSA_PTE_CONT_ENTRIES	16
 #define ARM_VMSA_PTE_CONT_SIZE		(PAGE_SIZE * ARM_VMSA_PTE_CONT_ENTRIES)
 
-- 
1.8.3.2
