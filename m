From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 24 Feb 2011 10:44:42 -0800
Subject: [PATCH 1/4] msm: scm: Mark inline asm as volatile
In-Reply-To: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
References: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1298573085-23217-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We don't want the compiler to remove these asm statements or
reorder them in any way. Mark them as volatile to be sure.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/scm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/scm.c b/arch/arm/mach-msm/scm.c
index f4b9bc9..ba57b5a 100644
--- a/arch/arm/mach-msm/scm.c
+++ b/arch/arm/mach-msm/scm.c
@@ -174,7 +174,7 @@ static u32 smc(u32 cmd_addr)
 	register u32 r0 asm("r0") = 1;
 	register u32 r1 asm("r1") = (u32)&context_id;
 	register u32 r2 asm("r2") = cmd_addr;
-	asm(
+	asm volatile(
 		__asmeq("%0", "r0")
 		__asmeq("%1", "r0")
 		__asmeq("%2", "r1")
@@ -271,7 +271,7 @@ u32 scm_get_version(void)
 		return version;
 
 	mutex_lock(&scm_lock);
-	asm(
+	asm volatile(
 		__asmeq("%0", "r1")
 		__asmeq("%1", "r0")
 		__asmeq("%2", "r1")
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
