From: john.linn@xilinx.com (John Linn)
Date: Wed, 6 Apr 2011 11:15:10 -0600
Subject: [PATCH V2 4/4] ARM: Xilinx: update of infrastructure for SMP
In-Reply-To: <1302110110-32208-4-git-send-email-john.linn@xilinx.com>
References: <1302110110-32208-1-git-send-email-john.linn@xilinx.com>
	<1302110110-32208-2-git-send-email-john.linn@xilinx.com>
	<1302110110-32208-3-git-send-email-john.linn@xilinx.com>
	<1302110110-32208-4-git-send-email-john.linn@xilinx.com>
Message-ID: <00563c7b-efa1-4480-b091-44972a71f160@VA3EHSMHS036.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only minor updates of Kconfig and Makefile to support
SMP.

Signed-off-by: John Linn <john.linn@xilinx.com>
---

V2 Changes

Minor cleanup for the change from mach-xilinx to mach-zynq and
for the SMP boot process changes.

 arch/arm/Kconfig            |    2 +-
 arch/arm/mach-zynq/Makefile |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3bc4d86..bffa4f3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1339,7 +1339,7 @@ config SMP
 	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
 		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE
+		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || ARCH_ZYNQ
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
 	help
diff --git a/arch/arm/mach-zynq/Makefile b/arch/arm/mach-zynq/Makefile
index 9983a3f..9692d7d 100644
--- a/arch/arm/mach-zynq/Makefile
+++ b/arch/arm/mach-zynq/Makefile
@@ -5,4 +5,5 @@
 # Common support
 obj-y 				:= common.o timer.o
 obj-$(CONFIG_MACH_XILINX_EP107)	+= board_ep107.o
+obj-$(CONFIG_SMP)		+= platsmp.o
 obj-$(CONFIG_LOCAL_TIMERS)	+= localtimer.o
-- 
1.5.4.7



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
