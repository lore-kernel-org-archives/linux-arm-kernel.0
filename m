From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:32:06 +0200
Subject: [PATCH 6/9] ARM: OMAP2+: Improve a size determination in sr_dev_init()
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <82c5d47e-5b98-5e6d-c161-fbd0093a38db@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 19:02:24 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/sr_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/sr_device.c b/arch/arm/mach-omap2/sr_device.c
index d7cff2632d1e..01df4907c0e3 100644
--- a/arch/arm/mach-omap2/sr_device.c
+++ b/arch/arm/mach-omap2/sr_device.c
@@ -102,5 +102,5 @@ static int __init sr_dev_init(struct omap_hwmod *oh, void *user)
 	char *name = "smartreflex";
 	static int i;
 
-	sr_data = kzalloc(sizeof(struct omap_sr_data), GFP_KERNEL);
+	sr_data = kzalloc(sizeof(*sr_data), GFP_KERNEL);
 	if (!sr_data) {
-- 
2.13.0
