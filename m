From: gaowanlong@cn.fujitsu.com (Wanlong Gao)
Date: Wed, 3 Aug 2011 16:02:30 +0800
Subject: [PATCH] mfd:fix section mismatch in ab3550-core
Message-ID: <1312358550-21862-1-git-send-email-gaowanlong@cn.fujitsu.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the __init to __devinit for section mismatch fixing.

Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
---
 drivers/mfd/ab3550-core.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/ab3550-core.c b/drivers/mfd/ab3550-core.c
index 56ba194..703401c 100644
--- a/drivers/mfd/ab3550-core.c
+++ b/drivers/mfd/ab3550-core.c
@@ -1086,7 +1086,7 @@ static inline void ab3550_remove_debugfs(void)
  * This sets up a default config in the AB3550 chip so that it
  * will work as expected.
  */
-static int __init ab3550_setup(struct ab3550 *ab)
+static int __devinit ab3550_setup(struct ab3550 *ab)
 {
 	int err = 0;
 	int i;
@@ -1193,7 +1193,7 @@ struct ab_family_id {
 	char	*name;
 };
 
-static const struct ab_family_id ids[] __initdata = {
+static const struct ab_family_id ids[] __devinitdata = {
 	/* AB3550 */
 	{
 		.id = AB3550_P1A,
@@ -1205,7 +1205,7 @@ static const struct ab_family_id ids[] __initdata = {
 	}
 };
 
-static int __init ab3550_probe(struct i2c_client *client,
+static int __devinit ab3550_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct ab3550 *ab;
@@ -1326,7 +1326,7 @@ exit_no_detect:
 	return err;
 }
 
-static int __exit ab3550_remove(struct i2c_client *client)
+static int __devexit ab3550_remove(struct i2c_client *client)
 {
 	struct ab3550 *ab = i2c_get_clientdata(client);
 	int num_i2c_clients = AB3550_NUM_BANKS;
@@ -1359,7 +1359,7 @@ static struct i2c_driver ab3550_driver = {
 	},
 	.id_table	= ab3550_id,
 	.probe		= ab3550_probe,
-	.remove		= __exit_p(ab3550_remove),
+	.remove		= __devexit_p(ab3550_remove),
 };
 
 static int __init ab3550_i2c_init(void)
-- 
1.7.6
