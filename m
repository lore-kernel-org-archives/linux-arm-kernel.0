From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Aug 2018 17:16:03 +0100
Subject: [PATCH 3/7] arm64: ssbd: Drop #ifdefs for PR_SPEC_STORE_BYPASS
In-Reply-To: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
References: <1535645767-9901-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535645767-9901-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we're all merged nicely into mainline, there's no need to check
to see if PR_SPEC_STORE_BYPASS is defined.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/ssbd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/kernel/ssbd.c b/arch/arm64/kernel/ssbd.c
index 3432e5ef9f41..07b12c034ec2 100644
--- a/arch/arm64/kernel/ssbd.c
+++ b/arch/arm64/kernel/ssbd.c
@@ -11,9 +11,7 @@
 
 /*
  * prctl interface for SSBD
- * FIXME: Drop the below ifdefery once merged in 4.18.
  */
-#ifdef PR_SPEC_STORE_BYPASS
 static int ssbd_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	int state = arm64_get_ssbd_state();
@@ -107,4 +105,3 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return -ENODEV;
 	}
 }
-#endif	/* PR_SPEC_STORE_BYPASS */
-- 
2.1.4
