From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri,  1 Oct 2010 21:05:18 +0900
Subject: [PATCH 21/27] ARM: SAMSUNG: Add s3c_gpio_cfgrange_nopull() helper
In-Reply-To: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1285934724-5007-22-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ben Dooks <ben-linux@fluff.org>

A number of the SDHCI code configure a GPIO to a special function
and remove any pull-up, so add s3c_gpio_cfgrange_nopull() as a
wrapper to the s3c_gpio_cfgall_range() to make the code that
calls it fit on one line.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index ef0f1e3..e4b5cf1 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -172,6 +172,12 @@ extern s3c_gpio_pull_t s3c_gpio_getpull(unsigned int pin);
 extern int s3c_gpio_cfgall_range(unsigned int start, unsigned int nr,
 				 unsigned int cfg, s3c_gpio_pull_t pull);
 
+static inline int s3c_gpio_cfgrange_nopull(unsigned int pin, unsigned int size,
+					   unsigned int cfg)
+{
+	return s3c_gpio_cfgall_range(pin, size, cfg, S3C_GPIO_PULL_NONE);
+}
+
 /* Define values for the drvstr available for each gpio pin.
  *
  * These values control the value of the output signal driver strength,
-- 
1.6.2.5
