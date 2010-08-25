From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Tue, 24 Aug 2010 21:57:45 -0700
Subject: [PATCH 16/24] msm: add build support for msm8x60 target
In-Reply-To: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
References: <1282712273-344-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <1282712273-344-17-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jeff Ohlstein <johlstei@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig  |    7 +++++++
 arch/arm/mach-msm/Makefile |    7 ++++++-
 2 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 27fc183..dfa67d8 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -33,6 +33,13 @@ config ARCH_QSD8X50
 	select MSM_PROC_COMM
 	select HAS_MSM_DEBUG_UART_PHYS
 
+config ARCH_MSM8X60
+	bool "MSM8X60"
+	select ARCH_MSM_SCORPIONMP
+	select ARM_GIC
+	select CPU_V7
+	select MSM_V2_TLMM
+
 endchoice
 
 config MSM_SOC_REV_A
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 8a01f8a..17c03fa 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,11 +1,16 @@
-obj-y += io.o idle.o timer.o dma.o
+obj-y += io.o idle.o timer.o
+ifndef CONFIG_ARCH_MSM8X60
 obj-y += acpuclock-arm11.o
+obj-y += gpio.o dma.o
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
-- 
1.7.2.1

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
