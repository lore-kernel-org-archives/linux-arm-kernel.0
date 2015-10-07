From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Oct 2015 14:49:30 +0200
Subject: [PATCH] mfd: remove unused variables
Message-ID: <7700818.mjdn6x2kkK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A mass-cleanup by Javier Martinez Canillas removed a lot of
unused code, but left at least two variables in mfd drivers
in place that are now causing warnings:

drivers/mfd/rtsx_pcr.c: In function 'rtsx_pci_set_pull_ctl':
drivers/mfd/rtsx_pcr.c:564:6: warning: unused variable 'err' [-Wunused-variable]
drivers/mfd/lm3533-core.c: In function 'lm3533_i2c_probe':
drivers/mfd/lm3533-core.c:595:6: warning: unused variable 'ret' [-Wunused-variable]

This removes them as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: c749db571dc ("mfd: lm3533: Simplify function return logic")
Fixes: a3c29b09982 ("mfd: rtsx: Simplify function return logic")
---

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 193ecee1fa7e..5abcbb2e8849 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -592,7 +592,6 @@ static int lm3533_i2c_probe(struct i2c_client *i2c,
 					const struct i2c_device_id *id)
 {
 	struct lm3533 *lm3533;
-	int ret;
 
 	dev_dbg(&i2c->dev, "%s\n", __func__);
 
diff --git a/drivers/mfd/rtsx_pcr.c b/drivers/mfd/rtsx_pcr.c
index b98cf1de0a55..d63f3a896adb 100644
--- a/drivers/mfd/rtsx_pcr.c
+++ b/drivers/mfd/rtsx_pcr.c
@@ -561,8 +561,6 @@ EXPORT_SYMBOL_GPL(rtsx_pci_write_ppbuf);
 
 static int rtsx_pci_set_pull_ctl(struct rtsx_pcr *pcr, const u32 *tbl)
 {
-	int err;
-
 	rtsx_pci_init_cmd(pcr);
 
 	while (*tbl & 0xFFFF0000) {
