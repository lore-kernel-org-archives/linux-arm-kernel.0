From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 28 May 2010 06:56:49 +0100
Subject: [PATCH 12/15] ARM: SAMSUNG: Add s3c_gpio_cfgrange_nopull() helper
In-Reply-To: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
References: <1275026212-27510-1-git-send-email-ben-linux@fluff.org>
Message-ID: <1275026212-27510-13-git-send-email-ben-linux@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A number of the SDHCI code configure a GPIO to a special function
and remove any pull-up, so add s3c_gpio_cfgrange_nopull() as a
wrapper to the s3c_gpio_cfgall_range() to make the code that
calls it fit on one line.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/include/plat/gpio-cfg.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-cfg.h b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
index bec872f..47126c0 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-cfg.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-cfg.h
@@ -181,4 +181,10 @@ extern int s3c_gpio_cfgall_range(unsigned int pin, unsigned int size,
 				 unsigned int cfg, s3c_gpio_pull_t pull);
 
 
+static inline int s3c_gpio_cfgrange_nopull(unsigned int pin, unsigned int size,
+					   unsigned int cfg)
+{
+	return s3c_gpio_cfgall_range(pin, size, cfg, S3C_GPIO_PULL_NONE);
+}
+
 #endif /* __PLAT_GPIO_CFG_H */
-- 
1.6.3.3
