From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 23 Jul 2012 11:13:28 +0200
Subject: [PATCH 23/25] i2c/mpc: make data used as *of_device_id.data const
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1343034810-3386-24-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

[ukl: split Arnd's patch by driver]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-mpc.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 775062c..57f7703 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -730,24 +730,24 @@ static int mpc_i2c_resume(struct device *dev)
 SIMPLE_DEV_PM_OPS(mpc_i2c_pm_ops, mpc_i2c_suspend, mpc_i2c_resume);
 #endif
 
-static struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_512x __devinitdata = {
 	.setup = mpc_i2c_setup_512x,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_52xx __devinitdata = {
 	.setup = mpc_i2c_setup_52xx,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8313 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8543 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 2,
 };
 
-static struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
+static const struct mpc_i2c_data mpc_i2c_data_8544 __devinitdata = {
 	.setup = mpc_i2c_setup_8xxx,
 	.prescaler = 3,
 };
-- 
1.7.10.4
