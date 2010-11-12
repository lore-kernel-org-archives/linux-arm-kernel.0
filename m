From: davidb@codeaurora.org (David Brown)
Date: Fri, 12 Nov 2010 13:49:52 -0800
Subject: [PATCH 2/3] msm: smd: Warning cleanup
In-Reply-To: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
References: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1289598593-8974-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Put some variables inside of the same ifdef as the code that uses
them.

arch/arm/mach-msm/smd_debug.c: In function 'smsm_print_sleep_info':
arch/arm/mach-msm/smd_debug.c:274: warning: unused variable 'int_info'
arch/arm/mach-msm/smd_debug.c:273: warning: unused variable 'gpio'

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/smd_debug.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/smd_debug.c b/arch/arm/mach-msm/smd_debug.c
index f91c3b7..8736aff 100644
--- a/arch/arm/mach-msm/smd_debug.c
+++ b/arch/arm/mach-msm/smd_debug.c
@@ -270,8 +270,10 @@ void smsm_print_sleep_info(void)
 {
 	unsigned long flags;
 	uint32_t *ptr;
+#ifndef CONFIG_ARCH_MSM_SCORPION
 	struct tramp_gpio_smem *gpio;
 	struct smsm_interrupt_info *int_info;
+#endif
 
 
 	spin_lock_irqsave(&smem_lock, flags);
-- 
1.7.3.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
