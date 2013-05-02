From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu,  2 May 2013 10:09:26 -0700
Subject: [PATCH] ARM: ixp4xx: change type of ioremap function
Message-ID: <1367514566-30831-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cd024d4245b2bfbd824b911f11a9756d1d6c167d
(ARM: 7704/1: mm: Use phys_addr_t properly for ioremap functions)
changed the type of the ioremap functions to actually use phys_addr_t
instead of unsigned long. Change the type of the arch_ioremap function
to use phys_addr_t as well.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 1dbeb7c..659768b 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -558,7 +558,7 @@ void ixp4xx_restart(char mode, const char *cmd)
  * fallback to the default.
  */
 
-static void __iomem *ixp4xx_ioremap_caller(unsigned long addr, size_t size,
+static void __iomem *ixp4xx_ioremap_caller(phys_addr_t addr, size_t size,
 					   unsigned int mtype, void *caller)
 {
 	if (!is_pci_memory(addr))
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
