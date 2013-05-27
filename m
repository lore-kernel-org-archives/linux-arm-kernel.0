From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 27 May 2013 15:16:06 +0200
Subject: [PATCH] ARM: nomadik: Update MMC defconfigs
Message-ID: <1369660566-18997-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Enable MMC_UNSAFE_RESUME to accomplish a proper suspend/resume cycle
for SD/SDIO/(e)MMC.

ARMMMCI host driver supports clock gating through runtime PM, thus
MMC_CLKGATE is not needed. Moreover ARMMMCI can do scatter-gather which
means we can explicity disable MMC_BLOCK_BOUNCE, since it's default
enabled, to skip unnecessary bounce buffer copying.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 arch/arm/configs/nhk8815_defconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index b01e763..606a080 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -94,7 +94,8 @@ CONFIG_I2C_NOMADIK=y
 CONFIG_DEBUG_GPIO=y
 # CONFIG_HWMON is not set
 CONFIG_MMC=y
-CONFIG_MMC_CLKGATE=y
+CONFIG_MMC_UNSAFE_RESUME=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL031=y
-- 
1.7.10
