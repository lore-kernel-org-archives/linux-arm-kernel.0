From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Mar 2013 15:21:39 -0800
Subject: [PATCH] ARM: proc: Add Krait proc info
Message-ID: <1362439299-29617-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stepan Moskovchenko <stepanm@codeaurora.org>

Add processor info for the Qualcomm, Inc. Krait family of
processors, to use the generic ARMv7 initialisation
procedure but explicitly enable the IDIV hardware
capability flag.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mm/proc-v7.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3a3c015..81adeb3 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -434,6 +434,16 @@ __v7_ca15mp_proc_info:
 	.size	__v7_ca15mp_proc_info, . - __v7_ca15mp_proc_info
 
 	/*
+	 * Qualcomm Inc. Krait processors.
+	 */
+	.type	__krait_proc_info, #object
+__krait_proc_info:
+	.long	0x510f0400		@ Required ID value
+	.long	0xff0ffc00		@ Mask for ID
+	__v7_proc __v7_setup, hwcaps = HWCAP_IDIV
+	.size	__krait_proc_info, . - __krait_proc_info
+
+	/*
 	 * Match any ARMv7 processor core.
 	 */
 	.type	__v7_proc_info, #object
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
