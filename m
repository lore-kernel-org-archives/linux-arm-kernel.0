From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:34:07 +0200
Subject: [PATCH 8/9] ARM: OMAP2+: SmartReflex: Delete an error message for a
 failed memory allocation in two functions
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <13210fb0-3a22-07f5-0bc5-b338b1ccfdeb@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 19:16:27 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/sr_device.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 65775c6e8c27..eef6935e0403 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -48,7 +48,5 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
-	if (!nvalue_table) {
-		pr_err("OMAP: SmartReflex: cannot allocate memory for n-value table\n");
+	if (!nvalue_table)
 		return;
-	}
 
 	for (i = 0, j = 0; i < count; i++) {
 		u32 v;
@@ -104,8 +102,5 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
-	if (!sr_data) {
-		pr_err("%s: Unable to allocate memory for %s sr_data\n",
-		       __func__, oh->name);
+	if (!sr_data)
 		return -ENOMEM;
-	}
 
 	sr_dev_attr = (struct omap_smartreflex_dev_attr *)oh->dev_attr;
 	if (!sr_dev_attr || !sr_dev_attr->sensor_voltdm_name) {
-- 
2.13.0
