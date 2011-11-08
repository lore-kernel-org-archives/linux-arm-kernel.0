From: davidb@codeaurora.org (David Brown)
Date: Tue,  8 Nov 2011 09:40:07 -0800
Subject: [PATCH] ARM: msm: Remove call to missing FPGA init on 8660
Message-ID: <1320774007-6448-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A previous patch[1] added code to initialize an FPGA register on the
8660 "SURF" development platform.  Since this development platform is
not widely available, and there is now a more available device "the
Dragonboard" based on the same core SOC, this change was dropped.

However, the DT code kept a lingering call to this FPGA init function.
Remove it.

[1] https://lkml.org/lkml/2011/8/12/357

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8x60.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 44bf716..5876292 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -87,11 +87,6 @@ static void __init msm8x60_dt_init(void)
 	if (node)
 		irq_domain_add_simple(node, GIC_SPI_START);
 
-	if (of_machine_is_compatible("qcom,msm8660-surf")) {
-		printk(KERN_INFO "Init surf UART registers\n");
-		msm8x60_init_uart12dm();
-	}
-
 	of_platform_populate(NULL, of_default_bus_match_table,
 			msm_auxdata_lookup, NULL);
 }
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
