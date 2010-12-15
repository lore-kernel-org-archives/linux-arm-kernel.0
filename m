From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Tue, 14 Dec 2010 19:49:20 -0800
Subject: [PATCH 6/7] msm: Makefile cleanup
In-Reply-To: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <1292384961-8851-7-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up some of the conditionals in the Makefile in
preparation for adding build support for MSM8960.

Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Makefile |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index 1945f9c..8cd0b5b 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -1,21 +1,15 @@
 obj-y += io.o idle.o timer.o
-ifndef CONFIG_ARCH_MSM8X60
-obj-y += acpuclock-arm11.o
-obj-y += dma.o
-endif

-ifdef CONFIG_MSM_VIC
-obj-y += irq-vic.o
-else
-ifndef CONFIG_ARCH_MSM8X60
-obj-y += irq.o
-endif
-endif
+obj-$(CONFIG_MSM_VIC) += irq-vic.o

+obj-$(CONFIG_ARCH_MSM7X00A) += dma.o irq.o acpuclock-arm11.o
+obj-$(CONFIG_ARCH_MSM7X30) += dma.o
+obj-$(CONFIG_ARCH_QSD8X50) += dma.o sirc.o
 obj-$(CONFIG_ARCH_MSM8X60) += clock-dummy.o iommu.o iommu_dev.o devices-msm8x60-iommu.o
+
 obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
 obj-$(CONFIG_MSM_PROC_COMM) += clock.o
-obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
+
 obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
 obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 obj-$(CONFIG_MSM_SCM) += scm.o scm-boot.o
--
1.7.0.2

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
