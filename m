From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 16:00:13 -0700
Subject: [PATCH 1/2] ARM: MSM: Add handle_irq handler for 8660 DT machine
In-Reply-To: <1345676414-16635-1-git-send-email-sboyd@codeaurora.org>
References: <1345676414-16635-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1345676414-16635-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 041f777 (ARM: msm: convert SMP platforms to
CONFIG_MULTI_IRQ_HANDLER, 2011-09-06) forgot to add the
.handle_irq for the DT machine record. Add it so we get
interrupts instead of panics on DT enabled bootloaders.

Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8x60.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index e37a724..13ca9bb 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -158,6 +158,7 @@ MACHINE_END
 DT_MACHINE_START(MSM_DT, "Qualcomm MSM (Flattened Device Tree)")
 	.map_io = msm8x60_map_io,
 	.init_irq = msm8x60_init_irq,
+	.handle_irq = gic_handle_irq,
 	.init_machine = msm8x60_dt_init,
 	.init_late = msm8x60_init_late,
 	.timer = &msm_timer,
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
