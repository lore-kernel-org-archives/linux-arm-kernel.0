From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 10 Apr 2014 14:57:16 +0800
Subject: [PATCH] ARM: imx_v6_v7_defconfig: enable cpufreq and CMA support
Message-ID: <1397113036-16228-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 - Enable imx6 cpufreq support with ondemand governor
 - Enable CMA support so that device like 1080p HDMI can work
 - Run savedefconfig

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 51b7fab..0e00528 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -46,7 +46,11 @@ CONFIG_VMSPLIT_2G=y
 CONFIG_PREEMPT_VOLUNTARY=y
 CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
+CONFIG_CMA=y
 CONFIG_CMDLINE="noinitrd console=ttymxc0,115200"
+CONFIG_CPU_FREQ=y
+CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
+CONFIG_ARM_IMX6Q_CPUFREQ=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_BINFMT_MISC=m
@@ -72,6 +76,7 @@ CONFIG_RFKILL_INPUT=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
+CONFIG_DMA_CMA=y
 CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
 CONFIG_MTD=y
@@ -249,7 +254,6 @@ CONFIG_DRM_IMX_LDB=y
 CONFIG_DRM_IMX_IPUV3_CORE=y
 CONFIG_DRM_IMX_IPUV3=y
 CONFIG_DRM_IMX_HDMI=y
-CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_PWM=y
 CONFIG_PWM_IMX=y
-- 
1.8.3.2
