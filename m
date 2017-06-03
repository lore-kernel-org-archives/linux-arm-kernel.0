From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 3 Jun 2017 20:27:17 +0200
Subject: [PATCH 1/9] ARM: OMAP2+: Delete an error message for a failed memory
 allocation in omap_mcspi_init()
In-Reply-To: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
References: <e9d44aa5-9208-9ff3-46ec-cd58ac3f4696@users.sourceforge.net>
Message-ID: <2e685abe-2544-f996-4756-9836b8ecd450@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Jun 2017 16:45:12 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/mach-omap2/devices.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 473951203104..cf1fc0d162c4 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -82,7 +82,5 @@ static int __init omap_mcspi_init(struct omap_hwmod *oh, void *unused)
-	if (!pdata) {
-		pr_err("Memory allocation for McSPI device failed\n");
+	if (!pdata)
 		return -ENOMEM;
-	}
 
 	pdata->num_cs = mcspi_attrib->num_chipselect;
 	switch (oh->class->rev) {
-- 
2.13.0
