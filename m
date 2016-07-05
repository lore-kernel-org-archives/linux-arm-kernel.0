From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 05 Jul 2016 15:36:51 +0530
Subject: [PATCH] arm64: defconfig: Enable s2mps11 regulator clk and s3c rtc
 driver
Message-ID: <1467713211-16014-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c rtc controller on exynos7 platform uses rtc source clock
from s2mps11 pmic. This patch enables the required bits to make
rtc work on exynos7-espresso board.

Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/configs/defconfig |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fd2d74d..c05b8ba 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -268,6 +268,7 @@ CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_XGENE=y
+CONFIG_RTC_DRV_S3C=y
 CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_TEGRA20_APB_DMA=y
@@ -282,6 +283,7 @@ CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
+CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
-- 
1.7.10.4
