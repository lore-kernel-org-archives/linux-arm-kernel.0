From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu,  2 Jan 2014 13:53:24 -0800
Subject: [RFC PATCHv3 06/11] arm: use is_vmalloc_addr
In-Reply-To: <1388699609-18214-1-git-send-email-lauraa@codeaurora.org>
References: <1388699609-18214-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1388699609-18214-7-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

is_vmalloc_addr already does the range checking against VMALLOC_START and
VMALLOC_END. Use it.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm/mm/iomap.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/iomap.c b/arch/arm/mm/iomap.c
index 4614208..4bf5457 100644
--- a/arch/arm/mm/iomap.c
+++ b/arch/arm/mm/iomap.c
@@ -34,8 +34,7 @@ EXPORT_SYMBOL(pcibios_min_mem);
 
 void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 {
-	if ((unsigned long)addr >= VMALLOC_START &&
-	    (unsigned long)addr < VMALLOC_END)
+	if (is_vmalloc_addr(addr))
 		iounmap(addr);
 }
 EXPORT_SYMBOL(pci_iounmap);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
