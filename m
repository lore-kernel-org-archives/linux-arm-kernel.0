From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jan 2013 22:44:12 +0000
Subject: [PATCH 13/19] pinctrl: nomadik: nmk_prcm_gpiocr_get_mode may be unused
In-Reply-To: <1359153858-31992-1-git-send-email-arnd@arndb.de>
References: <1359123276-15833-1-git-send-email-arnd@arndb.de>
 <1359153858-31992-1-git-send-email-arnd@arndb.de>
Message-ID: <1359153858-31992-14-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

nmk_prcm_gpiocr_get_mode is only needed for debugfs output at
the moment, which can be compile-time disabled. Marking
the function __maybe_unused still gives us compile-time
coverage, but avoids a gcc warning.

Without this patch, building nhk8815_defconfig results in:

drivers/pinctrl/pinctrl-nomadik.c:676:12: warning: 'nmk_prcm_gpiocr_get_mode' defined but not used [-Wunused-function]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jean-Nicolas Graux <jean-nicolas.graux@stericsson.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
---
 drivers/pinctrl/pinctrl-nomadik.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
index 1bb16ff..5767b18 100644
--- a/drivers/pinctrl/pinctrl-nomadik.c
+++ b/drivers/pinctrl/pinctrl-nomadik.c
@@ -676,7 +676,7 @@ int nmk_gpio_set_mode(int gpio, int gpio_mode)
 }
 EXPORT_SYMBOL(nmk_gpio_set_mode);
 
-static int nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev, int gpio)
+static int __maybe_unused nmk_prcm_gpiocr_get_mode(struct pinctrl_dev *pctldev, int gpio)
 {
 	int i;
 	u16 reg;
-- 
1.8.0
