From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 24 Aug 2010 21:57:46 -0700
Subject: [PATCH 17/24] msm: 8x60: setup correct handlers for private interrupts
In-Reply-To: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282712273-344-18-git-send-email-johlstei@codeaurora.org>
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
index c6bf8e3..e2e5a5c 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -46,7 +46,7 @@ static void __init msm8x60_init_irq(void)
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
