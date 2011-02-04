From: segoon@openwall.com (Vasiliy Kulikov)
Date: Fri,  4 Feb 2011 15:23:36 +0300
Subject: [PATCH 08/20] mfd: ab3100: world-writable debugfs *_priv files
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Message-ID: <b5dceec3591728e7dfa4d9fb2e978780e55420c5.1296818921.git.segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't allow everybody to change device hardware registers.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested only.

 drivers/mfd/ab3100-core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/ab3100-core.c b/drivers/mfd/ab3100-core.c
index 4193af5..1707d22 100644
--- a/drivers/mfd/ab3100-core.c
+++ b/drivers/mfd/ab3100-core.c
@@ -613,7 +613,7 @@ static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 	ab3100_get_priv.ab3100 = ab3100;
 	ab3100_get_priv.mode = false;
 	ab3100_get_reg_file = debugfs_create_file("get_reg",
-				S_IWUGO, ab3100_dir, &ab3100_get_priv,
+				S_IWUSR, ab3100_dir, &ab3100_get_priv,
 				&ab3100_get_set_reg_fops);
 	if (!ab3100_get_reg_file) {
 		err = -ENOMEM;
@@ -623,7 +623,7 @@ static void ab3100_setup_debugfs(struct ab3100 *ab3100)
 	ab3100_set_priv.ab3100 = ab3100;
 	ab3100_set_priv.mode = true;
 	ab3100_set_reg_file = debugfs_create_file("set_reg",
-				S_IWUGO, ab3100_dir, &ab3100_set_priv,
+				S_IWUSR, ab3100_dir, &ab3100_set_priv,
 				&ab3100_get_set_reg_fops);
 	if (!ab3100_set_reg_file) {
 		err = -ENOMEM;
-- 
1.7.0.4
