From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:13 +0200
Subject: [PATCH 08/25] gpio/mpc8xxx: add a const qualifier
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/gpio/gpio-mpc8xxx.c: In function 'mpc8xxx_add_controller':
	drivers/gpio/gpio-mpc8xxx.c:360:30: warning: assignment discards 'const' qualifier from pointer target type [enabled by default]

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/gpio/gpio-mpc8xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 5a1817e..9ae29cc 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -38,7 +38,7 @@ struct mpc8xxx_gpio_chip {
 	 */
 	u32 data;
 	struct irq_domain *irq;
-	void *of_dev_id_data;
+	const void *of_dev_id_data;
 };
 
 static inline u32 mpc8xxx_gpio2mask(unsigned int gpio)
-- 
1.7.10.4
