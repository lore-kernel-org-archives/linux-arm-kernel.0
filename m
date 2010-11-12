From: davidb@codeaurora.org (David Brown)
Date: Fri, 12 Nov 2010 13:49:51 -0800
Subject: [PATCH 1/3] msm: sirc: warning fix
Message-ID: <1289598593-8974-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Eliminate some unreferenced variables.

arch/arm/mach-msm/sirc.c:43: warning: 'save_type' defined but not used
arch/arm/mach-msm/sirc.c:44: warning: 'save_polarity' defined but not used

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/sirc.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-msm/sirc.c b/arch/arm/mach-msm/sirc.c
index b079452..152eefd 100644
--- a/arch/arm/mach-msm/sirc.c
+++ b/arch/arm/mach-msm/sirc.c
@@ -40,9 +40,6 @@ static struct sirc_cascade_regs sirc_reg_table[] = {
 	}
 };
 
-static unsigned int save_type;
-static unsigned int save_polarity;
-
 /* Mask off the given interrupt. Keep the int_enable mask in sync with
    the enable reg, so it can be restored after power collapse. */
 static void sirc_irq_mask(unsigned int irq)
-- 
1.7.3.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
