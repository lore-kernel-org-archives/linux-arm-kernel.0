From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 12 May 2010 14:45:54 -0700
Subject: [PATCH 25/25] msm: 7x30 Kconfig and makefile changes
In-Reply-To: <>
References: <>
Message-ID: <1273700754-10256-26-git-send-email-dwalker@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enables basic boot support for the MSM7x30 SURF development
board.

Signed-off-by: Daniel Walker <dwalker@codeaurora.org>
Signed-off-by: David Brown <davidb@codeaurora.org>
Signed-off-by: Gregory Bean <gbean@codeaurora.org>
Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
Signed-off-by: Stepan Moskovchenko <stepanm@codeaurora.org>
---
 arch/arm/mach-msm/Kconfig  |   14 ++++++++++++++
 arch/arm/mach-msm/Makefile |    1 +
 2 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 3dbad24..47264a7 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -11,6 +11,14 @@ config ARCH_MSM7X00A
 	select MSM_SMD_PKG3
 	select CPU_V6
 
+config ARCH_MSM7X30
+	bool "MSM7x30"
+	select ARCH_MSM_SCORPION
+	select MSM_SMD
+	select MSM_VIC
+	select CPU_V7
+	select MSM_REMOTE_SPINLOCK_DEKKERS
+
 config ARCH_QSD8X50
 	bool "QSD8X50"
 	select ARCH_MSM_SCORPION
@@ -47,6 +55,12 @@ config MACH_TROUT
 	help
 	  Support for the HTC Dream, T-Mobile G1, Android ADP1 devices.
 
+config MACH_MSM7X30_SURF
+	depends on ARCH_MSM7X30
+	bool "MSM7x30 SURF"
+	help
+	  Support for the Qualcomm MSM7x30 SURF eval board.
+
 config MACH_QSD8X50_SURF
 	depends on ARCH_QSD8X50
 	bool "QSD8x50 SURF"
diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
index df95f57..66677f0 100644
--- a/arch/arm/mach-msm/Makefile
+++ b/arch/arm/mach-msm/Makefile
@@ -17,5 +17,6 @@ obj-$(CONFIG_MSM_SMD) += last_radio_log.o
 
 obj-$(CONFIG_MACH_TROUT) += board-trout.o devices-msm7x00.o
 obj-$(CONFIG_MACH_HALIBUT) += board-halibut.o devices-msm7x00.o
+obj-$(CONFIG_ARCH_MSM7X30) += board-msm7x30.o devices-msm7x30.o
 obj-$(CONFIG_ARCH_QSD8X50) += board-qsd8x50.o devices-qsd8x50.o
 
-- 
1.6.2.3
