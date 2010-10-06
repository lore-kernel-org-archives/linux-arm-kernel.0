From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:54 -0700
Subject: [PATCH 15/20 v2] msm: add msm8x60_surf machine
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-16-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steve Muckle <smuckle@codeaurora.org>

Signed-off-by: Steve Muckle <smuckle@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig         |    8 +++++++-
 arch/arm/mach-msm/board-msm8x60.c |    7 +++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index bc50a92..910db2e 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -38,7 +38,7 @@ config ARCH_MSM8X60
 	select ARM_GIC
 	select CPU_V7
 	select MSM_V2_TLMM
-	select MACH_MSM8X60_RUMI3 if (!MACH_MSM8X60_RUMI3)
+	select MACH_MSM8X60_SURF if (!MACH_MSM8X60_RUMI3)
 
 endchoice
 
@@ -97,6 +97,12 @@ config MACH_MSM8X60_RUMI3
 	help
 	  Support for the Qualcomm MSM8x60 RUMI3 emulator.
 
+config MACH_MSM8X60_SURF
+	depends on ARCH_MSM8X60
+	bool "MSM8x60 SURF"
+	help
+	  Support for the Qualcomm MSM8x60 SURF eval board.
+
 endmenu
 
 config MSM_DEBUG_UART
diff --git a/arch/arm/mach-msm/board-msm8x60.c b/arch/arm/mach-msm/board-msm8x60.c
index 70087ca..a8a4d8d 100644
--- a/arch/arm/mach-msm/board-msm8x60.c
+++ b/arch/arm/mach-msm/board-msm8x60.c
@@ -76,3 +76,10 @@ MACHINE_START(MSM8X60_RUMI3, "QCT MSM8X60 RUMI3")
 	.init_machine = msm8x60_init,
 	.timer = &msm_timer,
 MACHINE_END
+
+MACHINE_START(MSM8X60_SURF, "QCT MSM8X60 SURF")
+	.map_io = msm8x60_map_io,
+	.init_irq = msm8x60_init_irq,
+	.init_machine = msm8x60_init,
+	.timer = &msm_timer,
+MACHINE_END
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
