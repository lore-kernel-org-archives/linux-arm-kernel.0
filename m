From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 17 Nov 2014 17:05:32 -0800
Subject: [PATCH] ARM: Update processor_modes for hyp and monitor mode
Message-ID: <1416272732-20573-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the kernel is running in hypervisor mode or monitor mode we'll
print UK6_32 or UK10_32 if we call into __show_regs(). Let's
update these strings to indicate the new modes that didn't exist
when this code was written.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/kernel/process.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fe972a2f3df3..fdfa3a78ec8c 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -51,8 +51,8 @@ EXPORT_SYMBOL(__stack_chk_guard);
 static const char *processor_modes[] __maybe_unused = {
   "USER_26", "FIQ_26" , "IRQ_26" , "SVC_26" , "UK4_26" , "UK5_26" , "UK6_26" , "UK7_26" ,
   "UK8_26" , "UK9_26" , "UK10_26", "UK11_26", "UK12_26", "UK13_26", "UK14_26", "UK15_26",
-  "USER_32", "FIQ_32" , "IRQ_32" , "SVC_32" , "UK4_32" , "UK5_32" , "UK6_32" , "ABT_32" ,
-  "UK8_32" , "UK9_32" , "UK10_32", "UND_32" , "UK12_32", "UK13_32", "UK14_32", "SYS_32"
+  "USER_32", "FIQ_32" , "IRQ_32" , "SVC_32" , "UK4_32" , "UK5_32" , "MON_32" , "ABT_32" ,
+  "UK8_32" , "UK9_32" , "HYP_32", "UND_32" , "UK12_32", "UK13_32", "UK14_32", "SYS_32"
 };
 
 static const char *isa_modes[] __maybe_unused = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
