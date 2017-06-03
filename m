From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:33:10 +0200
Subject: [PATCH 7/9] ARM: OMAP2+: Use kcalloc() in sr_set_nvalues()
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <201e94ac-bbd7-5fb0-582b-4a6b2585bdab@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 19:09:07 +0200

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kcalloc".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data structure by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/sr_device.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index 01df4907c0e3..65775c6e8c27 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -44,7 +44,5 @@ static void __init sr_set_nvalues(struct omap_volt_data *volt_data,
 	while (volt_data[count].volt_nominal)
 		count++;
 
-	nvalue_table = kzalloc(sizeof(struct omap_sr_nvalue_table)*count,
-			GFP_KERNEL);
-
+	nvalue_table = kcalloc(count, sizeof(*nvalue_table), GFP_KERNEL);
 	if (!nvalue_table) {
-- 
2.13.0
