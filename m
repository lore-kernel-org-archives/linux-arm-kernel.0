From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 12 Sep 2018 09:51:29 +0200
Subject: [PATCH v3 21/21] nvmem: use octal permissions instead of constants
In-Reply-To: <20180912075129.25185-1-brgl@bgdev.pl>
References: <20180912075129.25185-1-brgl@bgdev.pl>
Message-ID: <20180912075129.25185-22-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Checkpatch emits a warning when using symbolic permissions. Use octal
permissions instead.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bc14ffd87ca3..e174b282cc1f 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -154,7 +154,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUGO,
+		.mode	= 0644,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -178,7 +178,7 @@ static const struct attribute_group *nvmem_rw_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUGO,
+		.mode	= 0444,
 	},
 	.read	= bin_attr_nvmem_read,
 };
@@ -201,7 +201,7 @@ static const struct attribute_group *nvmem_ro_dev_groups[] = {
 static struct bin_attribute bin_attr_rw_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUSR,
+		.mode	= 0600,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -225,7 +225,7 @@ static const struct attribute_group *nvmem_rw_root_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_root_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUSR,
+		.mode	= 0400,
 	},
 	.read	= bin_attr_nvmem_read,
 };
-- 
2.18.0
