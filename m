From: segoon@openwall.com (Vasiliy Kulikov)
Date: Fri,  4 Feb 2011 15:23:43 +0300
Subject: [PATCH 10/20] mfd: ab8500: world-writable debugfs register-* files
In-Reply-To: <cover.1296818921.git.segoon@openwall.com>
References: <cover.1296818921.git.segoon@openwall.com>
Message-ID: <c8f28aeecd5f4d05b9ae0b110831aa128754f172.1296818921.git.segoon@openwall.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't allow everybody to interact with hardware registers.

Signed-off-by: Vasiliy Kulikov <segoon@openwall.com>
---
 Compile tested only.

 drivers/mfd/ab8500-debugfs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-debugfs.c b/drivers/mfd/ab8500-debugfs.c
index 3c1541a..64748e4 100644
--- a/drivers/mfd/ab8500-debugfs.c
+++ b/drivers/mfd/ab8500-debugfs.c
@@ -585,18 +585,18 @@ static int __devinit ab8500_debug_probe(struct platform_device *plf)
 		goto exit_destroy_dir;
 
 	ab8500_bank_file = debugfs_create_file("register-bank",
-		(S_IRUGO | S_IWUGO), ab8500_dir, &plf->dev, &ab8500_bank_fops);
+		(S_IRUGO | S_IWUSR), ab8500_dir, &plf->dev, &ab8500_bank_fops);
 	if (!ab8500_bank_file)
 		goto exit_destroy_reg;
 
 	ab8500_address_file = debugfs_create_file("register-address",
-		(S_IRUGO | S_IWUGO), ab8500_dir, &plf->dev,
+		(S_IRUGO | S_IWUSR), ab8500_dir, &plf->dev,
 		&ab8500_address_fops);
 	if (!ab8500_address_file)
 		goto exit_destroy_bank;
 
 	ab8500_val_file = debugfs_create_file("register-value",
-		(S_IRUGO | S_IWUGO), ab8500_dir, &plf->dev, &ab8500_val_fops);
+		(S_IRUGO | S_IWUSR), ab8500_dir, &plf->dev, &ab8500_val_fops);
 	if (!ab8500_val_file)
 		goto exit_destroy_address;
 
-- 
1.7.0.4
