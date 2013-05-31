From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 31 May 2013 11:19:14 +0200
Subject: [PATCH 39/39] ARM: u300: Update MMC configs for u300 defconfig
In-Reply-To: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
References: <1369991954-17406-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1369991954-17406-40-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Enable MMC_UNSAFE_RESUME to be accomplish a proper suspend/resume cycle
for SD/SDIO/(e)MMC.

ARMMMCI host driver supports clock gating through runtime PM, thus
MMC_CLKGATE is not needed. Moreover ARMMMCI can do scatter-gather which
means we can explicity disable MMC_BLOCK_BOUNCE, since it's default
enabled, to skip unnecessary bounce buffer copying.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u300_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/u300_defconfig b/arch/arm/configs/u300_defconfig
index a5fa0d9..fd81a1b 100644
--- a/arch/arm/configs/u300_defconfig
+++ b/arch/arm/configs/u300_defconfig
@@ -49,7 +49,8 @@ CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
-CONFIG_MMC_CLKGATE=y
+CONFIG_MMC_UNSAFE_RESUME=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
 CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
-- 
1.7.11.3
