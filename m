From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Jul 2013 13:54:27 -0700
Subject: [PATCH v2 2/9] ARM: msm: Don't compile __msm_ioremap_caller() unless
 used
In-Reply-To: <1374699274-18388-1-git-send-email-sboyd@codeaurora.org>
References: <1374699274-18388-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1374699274-18388-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is only used on MSM7x00A so only compile the
function if the build includes support for that platform.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 3dc04cc..4a1a222 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -168,6 +168,7 @@ void __init msm_map_msm7x30_io(void)
 }
 #endif /* CONFIG_ARCH_MSM7X30 */
 
+#ifdef CONFIG_ARCH_MSM7X00A
 void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
 {
@@ -182,3 +183,4 @@ void __iomem *__msm_ioremap_caller(phys_addr_t phys_addr, size_t size,
 
 	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
 }
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
