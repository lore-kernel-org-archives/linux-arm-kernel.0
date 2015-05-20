From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 May 2015 09:13:11 +0200
Subject: [PATCH] pinctrl: mediatek: add OF dependency to MT6397
Message-ID: <1432105991-3731-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X86_64 allmodconfig screams like so:
warning: (PINCTRL_MT6397) selects PINCTRL_MTK_COMMON
which has unmet direct dependencies
(PINCTRL && (ARCH_MEDIATEK || COMPILE_TEST) && OF)

So add OF to dependencies to shut up this warning.

Cc: Hongzhou Yang <hongzhou.yang@mediatek.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/mediatek/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 0bc84fb2f4f2..02f6f92df86c 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -32,6 +32,7 @@ config PINCTRL_MT8173
 # For PMIC
 config PINCTRL_MT6397
 	bool "Mediatek MT6397 pin control" if COMPILE_TEST && !MFD_MT6397
+	depends on OF
 	default MFD_MT6397
 	select PINCTRL_MTK_COMMON
 
-- 
1.9.3
