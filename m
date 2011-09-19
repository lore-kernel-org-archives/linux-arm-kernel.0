From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 19 Sep 2011 10:54:04 -0700
Subject: [PATCH] msm: platsmp: Mark ioremapped memory as __iomem
Message-ID: <1316454844-32733-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes a handful of sparse warnings.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/platsmp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/platsmp.c b/arch/arm/mach-msm/platsmp.c
index 1a1af9e..365ef3f 100644
--- a/arch/arm/mach-msm/platsmp.c
+++ b/arch/arm/mach-msm/platsmp.c
@@ -79,7 +79,7 @@ static __cpuinit void prepare_cold_cpu(unsigned int cpu)
 	ret = scm_set_boot_addr(virt_to_phys(msm_secondary_startup),
 				SCM_FLAG_COLDBOOT_CPU1);
 	if (ret == 0) {
-		void *sc1_base_ptr;
+		void __iomem *sc1_base_ptr;
 		sc1_base_ptr = ioremap_nocache(0x00902000, SZ_4K*2);
 		if (sc1_base_ptr) {
 			writel(0, sc1_base_ptr + VDD_SC1_ARRAY_CLAMP_GFS_CTL);
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
