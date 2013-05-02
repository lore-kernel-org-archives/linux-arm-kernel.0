From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu,  2 May 2013 10:17:58 -0700
Subject: [PATCH] ARM: ebsa110: Change the type of ioremap function
Message-ID: <1367515078-32202-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit cd024d4245b2bfbd824b911f11a9756d1d6c167d
(ARM: 7704/1: mm: Use phys_addr_t properly for ioremap functions)
changed the type of the ioremap functions to actually use phys_addr_t
instead of unsigned long. Change the type of the arch_ioremap function
to use phys_addr_t as well.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

diff --git a/arch/arm/mach-ebsa110/core.c b/arch/arm/mach-ebsa110/core.c
index b13cc74..8a53f34 100644
--- a/arch/arm/mach-ebsa110/core.c
+++ b/arch/arm/mach-ebsa110/core.c
@@ -116,7 +116,7 @@ static void __init ebsa110_map_io(void)
 	iotable_init(ebsa110_io_desc, ARRAY_SIZE(ebsa110_io_desc));
 }
 
-static void __iomem *ebsa110_ioremap_caller(unsigned long cookie, size_t size,
+static void __iomem *ebsa110_ioremap_caller(phys_addr_t cookie, size_t size,
 					    unsigned int flags, void *caller)
 {
 	return (void __iomem *)cookie;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
