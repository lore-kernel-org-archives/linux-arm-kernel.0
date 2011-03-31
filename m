From: davidb@codeaurora.org (David Brown)
Date: Thu, 31 Mar 2011 13:04:22 -0700
Subject: [PATCH 1/2] msm: Remove extraneous ffa device check
Message-ID: <1301601863-19554-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The qsd8x50 board file contains a few references to machine_is_...
macros that are otherwise unused, and contain no machine definition.
The recent purge of unused machine definitions breaks the compilation
of this target.

Since the machine cannot ever be used, just remove the bogus checks.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/board-qsd8x50.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-msm/board-qsd8x50.c b/arch/arm/mach-msm/board-qsd8x50.c
index 7f56861..6a96911 100644
--- a/arch/arm/mach-msm/board-qsd8x50.c
+++ b/arch/arm/mach-msm/board-qsd8x50.c
@@ -160,10 +160,7 @@ static struct msm_mmc_platform_data qsd8x50_sdc1_data = {
 
 static void __init qsd8x50_init_mmc(void)
 {
-	if (machine_is_qsd8x50_ffa() || machine_is_qsd8x50a_ffa())
-		vreg_mmc = vreg_get(NULL, "gp6");
-	else
-		vreg_mmc = vreg_get(NULL, "gp5");
+	vreg_mmc = vreg_get(NULL, "gp5");
 
 	if (IS_ERR(vreg_mmc)) {
 		pr_err("vreg get for vreg_mmc failed (%ld)\n",
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
