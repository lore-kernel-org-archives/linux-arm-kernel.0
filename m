From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Fri, 16 Aug 2013 17:51:53 +0530
Subject: [PATCH v4 1/2] rtc: omap: update of_device_id to reflect latest ip
 revisions
In-Reply-To: <1376655714-28947-1-git-send-email-gururaja.hebbar@ti.com>
References: <1376655714-28947-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <1376655714-28947-2-git-send-email-gururaja.hebbar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The syntax of compatible property in DT is to mention the Most specific
match to most generic match.

Since AM335x is the platform with latest IP revision, add it 1st in
the device id table.

This way, we can add new matching compatible as 1st and maintain old
compatible string for backwards compatibility.

ex:
	compatible = "ti,am3352-rtc", "ti,da830-rtc";

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
CC: mark.rutland at arm.com
---
Changes in V4:
	- Rebased on latest linux-next (as on 160813).
	- Correct a type AM335X --> AM3352

Changes in v3:
	- new patch

:100644 100644 dc62cc3... 2f0968c... M	drivers/rtc/rtc-omap.c
 drivers/rtc/rtc-omap.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
index dc62cc3..2f0968c 100644
--- a/drivers/rtc/rtc-omap.c
+++ b/drivers/rtc/rtc-omap.c
@@ -330,12 +330,12 @@ static struct platform_device_id omap_rtc_devtype[] = {
 MODULE_DEVICE_TABLE(platform, omap_rtc_devtype);
 
 static const struct of_device_id omap_rtc_of_match[] = {
-	{	.compatible	= "ti,da830-rtc",
-		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
-	},
 	{	.compatible	= "ti,am3352-rtc",
 		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_AM3352_IDX],
 	},
+	{	.compatible	= "ti,da830-rtc",
+		.data		= &omap_rtc_devtype[OMAP_RTC_DATA_DA830_IDX],
+	},
 	{},
 };
 MODULE_DEVICE_TABLE(of, omap_rtc_of_match);
-- 
1.7.0.4
