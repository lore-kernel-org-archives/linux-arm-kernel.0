From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 25 Jan 2016 16:58:08 +0100
Subject: [PATCH] irqchip: s3c24xx: mark init_eint as __maybe_unused
Message-ID: <1453737499-1960073-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The init_eint array in the s3c24xx irqchip driver is used by
every individual chip variant, but Kconfig allows building
the driver when they are all disabled, and that leads to
a harmless compile-time warning:

drivers/irqchip/irq-s3c24xx.c:608:28: error: 'init_eint' defined but not used [-Werror=unused-variable]

This marks the array as __maybe_unused to avoid the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/irqchip/irq-s3c24xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-s3c24xx.c b/drivers/irqchip/irq-s3c24xx.c
index c71914e8f596..5dc5a760c723 100644
--- a/drivers/irqchip/irq-s3c24xx.c
+++ b/drivers/irqchip/irq-s3c24xx.c
@@ -605,7 +605,7 @@ err:
 	return ERR_PTR(ret);
 }
 
-static struct s3c_irq_data init_eint[32] = {
+static struct s3c_irq_data __maybe_unused init_eint[32] = {
 	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
 	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
 	{ .type = S3C_IRQTYPE_NONE, }, /* reserved */
-- 
2.7.0
