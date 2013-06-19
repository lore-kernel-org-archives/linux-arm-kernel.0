From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 18 Jun 2013 17:04:32 -0700
Subject: [PATCH 02/11] ARM: msm: Don't compile __msm_ioremap_caller() unless
 used
In-Reply-To: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
References: <1371600281-6118-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1371600281-6118-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function is only used on MSM7x00A so only compile the
function if the build includes support for that platform.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---

Unchanged from previous sends.

 arch/arm/mach-msm/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index efa113e..4729774 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -168,6 +168,7 @@ void __init msm_map_msm7x30_io(void)
 }
 #endif /* CONFIG_ARCH_MSM7X30 */
 
+#ifdef CONFIG_ARCH_MSM7X00A
 void __iomem *__msm_ioremap_caller(unsigned long phys_addr, size_t size,
 				   unsigned int mtype, void *caller)
 {
@@ -182,3 +183,4 @@ void __iomem *__msm_ioremap_caller(unsigned long phys_addr, size_t size,
 
 	return __arm_ioremap_caller(phys_addr, size, mtype, caller);
 }
+#endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
