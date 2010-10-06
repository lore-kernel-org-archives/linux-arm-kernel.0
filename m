From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:52 -0700
Subject: [PATCH 13/20 v2] msm: 8x60: setup correct handlers for private
	interrupts
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-14-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@codeaurora.org>

Private Peripheral interrupts could be edge triggered or level triggered
depending on the platform. Initialize handlers for these in board file.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8x60.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index e7feb99..70087ca 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -44,7 +44,7 @@ static void __init msm8x60_init_irq(void)
 {
 	unsigned int i;
 
-	gic_dist_init(0, MSM_QGIC_DIST_BASE, 1);
+	gic_dist_init(0, MSM_QGIC_DIST_BASE, GIC_PPI_START);
 	gic_cpu_base_addr = (void *)MSM_QGIC_CPU_BASE;
 	gic_cpu_init(0, MSM_QGIC_CPU_BASE);
 
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
