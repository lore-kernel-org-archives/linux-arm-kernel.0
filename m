From: segoon@openwall.com (Vasiliy Kulikov)
Date: Fri,  4 Feb 2011 15:23:39 +0300
Subject: [PATCH 09/20] mfd: ab3500: world-writable debugfs register-* files
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Message-ID: <f67e210975afa7122a9bfe5e6c84ea84366a399f.1296818921.git.segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't allow everybody to interact with hardware registers.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested only.

 drivers/mfd/ab3550-core.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab3550-core.c b/drivers/mfd/ab3550-core.c
index 5fbca34..681984d 100644
--- a/drivers/mfd/ab3550-core.c
+++ b/drivers/mfd/ab3550-core.c
@@ -1053,17 +1053,17 @@ static inline void ab3550_setup_debugfs(struct ab3550 *ab)
 		goto exit_destroy_dir;
 
 	ab3550_bank_file = debugfs_create_file("register-bank",
-		(S_IRUGO | S_IWUGO), ab3550_dir, ab, &ab3550_bank_fops);
+		(S_IRUGO | S_IWUSR), ab3550_dir, ab, &ab3550_bank_fops);
 	if (!ab3550_bank_file)
 		goto exit_destroy_reg;
 
 	ab3550_address_file = debugfs_create_file("register-address",
-		(S_IRUGO | S_IWUGO), ab3550_dir, ab, &ab3550_address_fops);
+		(S_IRUGO | S_IWUSR), ab3550_dir, ab, &ab3550_address_fops);
 	if (!ab3550_address_file)
 		goto exit_destroy_bank;
 
 	ab3550_val_file = debugfs_create_file("register-value",
-		(S_IRUGO | S_IWUGO), ab3550_dir, ab, &ab3550_val_fops);
+		(S_IRUGO | S_IWUSR), ab3550_dir, ab, &ab3550_val_fops);
 	if (!ab3550_val_file)
 		goto exit_destroy_address;
 
-- 
1.7.0.4
