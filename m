From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Mon, 14 Mar 2011 22:01:13 -0700
Subject: [PATCH 10/11] msm: 8960: Split out common initialization code
In-Reply-To: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
References: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1300165274-8544-11-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stepan Moskovchenko <stepanm@codeaurora.org>

Move common initialization code into a separate function in
preparation for adding devices that are common to multiple
8960 targets.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/board-msm8960.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-msm/board-msm8960.c b/arch/arm/mach-msm/board-msm8960.c
index 052cb35..9511ea6 100644
--- a/arch/arm/mach-msm/board-msm8960.c
+++ b/arch/arm/mach-msm/board-msm8960.c
@@ -65,15 +65,20 @@ static struct platform_device *rumi3_devices[] __initdata = {
 	&msm8960_device_uart_gsbi5,
 };
 
-static void __init msm8960_sim_init(void)
+static void __init msm8960_init(void)
 {
 	msm_clock_init(msm_clocks_8960, msm_num_clocks_8960);
+}
+
+static void __init msm8960_sim_init(void)
+{
+	msm8960_init();
 	platform_add_devices(sim_devices, ARRAY_SIZE(sim_devices));
 }
 
 static void __init msm8960_rumi3_init(void)
 {
-	msm_clock_init(msm_clocks_8960, msm_num_clocks_8960);
+	msm8960_init();
 	platform_add_devices(rumi3_devices, ARRAY_SIZE(rumi3_devices));
 }
 
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
