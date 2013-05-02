From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu,  2 May 2013 10:21:00 -0700
Subject: [PATCH] ARM: iop13xx: change type of ioremap function
Message-ID: <1367515260-32364-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cd024d4245b2bfbd824b911f11a9756d1d6c167d
(ARM: 7704/1: mm: Use phys_addr_t properly for ioremap functions)
changed the type of the ioremap functions to actually use phys_addr_t
instead of unsigned long. Change the type of the arch_ioremap function
to use phys_addr_t as well.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

diff --git a/arch/arm/mach-iop13xx/io.c b/arch/arm/mach-iop13xx/io.c
index 183dc8b..faaf7d4 100644
--- a/arch/arm/mach-iop13xx/io.c
+++ b/arch/arm/mach-iop13xx/io.c
@@ -23,7 +23,7 @@
 
 #include "pci.h"
 
-static void __iomem *__iop13xx_ioremap_caller(unsigned long cookie,
+static void __iomem *__iop13xx_ioremap_caller(phys_addr_t cookie,
 	size_t size, unsigned int mtype, void *caller)
 {
 	void __iomem * retval;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
