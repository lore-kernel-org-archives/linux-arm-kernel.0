From: jnair@caviumnetworks.com (Jayachandran C)
Date: Mon, 22 May 2017 07:01:46 +0000
Subject: [PATCH 1/2] arm64: add PROT_DEVICE_GRE for Device GRE mapping
In-Reply-To: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
References: <1495436507-81890-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <1495436507-81890-2-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MAIR is programmed with attribute "Device GRE" (0x0C) at index 3,
but there is no corresponding page protection value defined. Make the
page attribute available for use by defining PROT_DEVICE_GRE.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/include/asm/pgtable-prot.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 2142c77..216f9f9 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -39,6 +39,7 @@
 
 #define PROT_DEVICE_nGnRnE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRnE))
 #define PROT_DEVICE_nGnRE	(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_nGnRE))
+#define PROT_DEVICE_GRE		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_DEVICE_GRE))
 #define PROT_NORMAL_NC		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_NC))
 #define PROT_NORMAL_WT		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL_WT))
 #define PROT_NORMAL		(PROT_DEFAULT | PTE_PXN | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_ATTRINDX(MT_NORMAL))
-- 
2.7.4
