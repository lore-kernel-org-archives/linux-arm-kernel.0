From: john.linn@xilinx.com (John Linn)
Date: Sun, 3 Apr 2011 15:00:18 -0600
Subject: [PATCH 3/3] ARM: Xilinx: update of infrastructure for SMP
In-Reply-To: <1301864418-12425-3-git-send-email-john.linn@xilinx.com>
References: <1301864418-12425-1-git-send-email-john.linn@xilinx.com>
	<1301864418-12425-2-git-send-email-john.linn@xilinx.com>
	<1301864418-12425-3-git-send-email-john.linn@xilinx.com>
Message-ID: <c6063ede-75c8-4dba-9a63-ce6d5b6bfd64@VA3EHSMHS021.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only minor updates of Kconfig and Makefile to support
the local timer and SMP.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
 arch/arm/Kconfig              |    2 +-
 arch/arm/mach-xilinx/Makefile |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aa7ac3b..50283ae 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1338,7 +1338,7 @@ config SMP
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
+		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || ARCH_XILINX
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
diff --git a/arch/arm/mach-xilinx/Makefile b/arch/arm/mach-xilinx/Makefile
index 62787ff..2f34007 100644
--- a/arch/arm/mach-xilinx/Makefile
+++ b/arch/arm/mach-xilinx/Makefile
@@ -5,3 +5,5 @@
 # Common support
 obj-y 				:= common.o timer.o
 obj-$(CONFIG_MACH_XILINX_EP107)	+= board_ep107.o
+obj-$(CONFIG_SMP)		+= platsmp.o headsmp.o
+obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-- 
1.5.4.7



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
