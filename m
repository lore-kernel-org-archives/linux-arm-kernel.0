From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed,  7 Oct 2015 17:35:14 +0100
Subject: [PATCH] nvmem: core: make default user binary file root-access only
Message-ID: <1444235714-24365-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As required by many providers like at24/at25/mxs-ocotp/qfprom, which would
want to allow root-only to read/write the nvmem content.
So making the defaults to be root-only access which can prevent normal
users from reading the nvmem data.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 6fd4e5a..4d2e476 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -112,7 +112,7 @@ static ssize_t bin_attr_nvmem_write(struct file *filp, struct kobject *kobj,
 static struct bin_attribute bin_attr_rw_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IWUSR | S_IRUGO,
+		.mode	= S_IWUSR | S_IRUSR,
 	},
 	.read	= bin_attr_nvmem_read,
 	.write	= bin_attr_nvmem_write,
@@ -136,7 +136,7 @@ static const struct attribute_group *nvmem_rw_dev_groups[] = {
 static struct bin_attribute bin_attr_ro_nvmem = {
 	.attr	= {
 		.name	= "nvmem",
-		.mode	= S_IRUGO,
+		.mode	= S_IRUSR,
 	},
 	.read	= bin_attr_nvmem_read,
 };
-- 
1.9.1
