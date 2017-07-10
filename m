From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Mon, 10 Jul 2017 11:07:22 +0530
Subject: [PATCH] mfd: ab8500-core: constify attribute_group structures.
Message-ID: <82391b6661b206976c244dcef76946c45c6aac2d.1499664942.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
  16298	   1009	    184	  17491	   4453	drivers/mfd/ab8500-core.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  16490	    817	    184	  17491	   4453	drivers/mfd/ab8500-core.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/mfd/ab8500-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 8511c06..30d09d1 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -1059,15 +1059,15 @@ static DEVICE_ATTR(dbbrstn, S_IRUGO | S_IWUSR,
 	NULL,
 };
 
-static struct attribute_group ab8500_attr_group = {
+static const struct attribute_group ab8500_attr_group = {
 	.attrs	= ab8500_sysfs_entries,
 };
 
-static struct attribute_group ab8505_attr_group = {
+static const struct attribute_group ab8505_attr_group = {
 	.attrs	= ab8505_sysfs_entries,
 };
 
-static struct attribute_group ab9540_attr_group = {
+static const struct attribute_group ab9540_attr_group = {
 	.attrs	= ab9540_sysfs_entries,
 };
 
-- 
1.9.1
