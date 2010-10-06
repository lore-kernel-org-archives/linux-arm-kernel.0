From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Wed,  6 Oct 2010 00:42:51 -0700
Subject: [PATCH 12/20 v2] msm: add build support for msm8x60 target
In-Reply-To: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
References: <1286350979-19328-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1286350979-19328-13-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig  |    7 +++++++
 arch/arm/mach-msm/Makefile |    8 +++++++-
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index def2a64..bc50a92 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -33,6 +33,13 @@ config ARCH_QSD8X50
 	select MSM_PROC_COMM
 	select HAS_MSM_DEBUG_UART_PHYS
 
+config ARCH_MSM8X60
+	bool "MSM8X60"
+	select ARM_GIC
+	select CPU_V7
+	select MSM_V2_TLMM
+	select MACH_MSM8X60_RUMI3 if (!MACH_MSM8X60_RUMI3)
+
 endchoice
 
 config MSM_SOC_REV_A
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index f7df564..6a0b92e 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,11 +1,16 @@
-obj-y += io.o idle.o timer.o dma.o
+obj-y += io.o idle.o timer.o
+ifndef CONFIG_ARCH_MSM8X60
 obj-y += acpuclock-arm11.o
+obj-y += dma.o
+endif
 
 ifdef CONFIG_MSM_VIC
 obj-y += irq-vic.o
 else
+ifndef CONFIG_ARCH_MSM8X60
 obj-y += irq.o
 endif
+endif
 
 obj-$(CONFIG_ARCH_MSM8X60) += clock-dummy.o
 obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
@@ -17,3 +22,4 @@ obj-$(CONFIG_MACH_TROUT) += board-trout.o board-trout-gpio.o board-trout-mmc.o d
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
 obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
+obj-$(CONFIG_ARCH_MSM8X60) += board-msm8x60.o
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
