From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Thu, 21 Oct 2010 02:25:45 -0700
Subject: [PATCH] msm: timer: Decrease shift on timer clocksource
Message-ID: <1287653148-1103-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shift of 24 causes the shift and multiply operation to sometimes
overflow, resulting in incorrect timer values and poor performance.

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/timer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/timer.c b/arch/arm/mach-msm/timer.c
index 7689848..950100f 100644
--- a/arch/arm/mach-msm/timer.c
+++ b/arch/arm/mach-msm/timer.c
@@ -137,7 +137,7 @@ static struct msm_clock msm_clocks[] = {
 			.rating         = 200,
 			.read           = msm_gpt_read,
 			.mask           = CLOCKSOURCE_MASK(32),
-			.shift          = 24,
+			.shift          = 17,
 			.flags          = CLOCK_SOURCE_IS_CONTINUOUS,
 		},
 		.irq = {
-- 
1.7.3.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
