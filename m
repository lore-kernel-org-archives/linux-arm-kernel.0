From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Mon, 27 Feb 2017 17:23:52 -0700
Subject: [PATCH] arm: exynos increase CONFIG_CMA_SIZE_MBYTES to 96
Message-ID: <20170228002353.3101-1-shuahkh@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current CMA size of 64 Mbytes is right on the edge of being too small
for some display managers.  With the proposed s5p_mfc patch series that
pre-allocate buffers, when display manager starts, it fails to get GEM
buffers.  Increasing the CMA size to 96 solves the problem.

Change CONFIG_CMA_SIZE_MBYTES to 96 in exynos_defconfig to address the
problem.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 742baf0..2541414 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -53,7 +53,7 @@ CONFIG_RFKILL_REGULATOR=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DMA_CMA=y
-CONFIG_CMA_SIZE_MBYTES=64
+CONFIG_CMA_SIZE_MBYTES=96
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
-- 
2.7.4
