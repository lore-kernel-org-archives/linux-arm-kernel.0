From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 Sep 2011 15:46:26 +0300
Subject: [PATCHv9 18/18] TEMP: OMAP device: change pr_warnings to pr_debugs
In-Reply-To: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
Message-ID: <1316781986-30642-19-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prevents a hang when omap_device would want to print something for
serial console device while enabling / disabling its clocks.
Should be handled properly by serial runtime PM support.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Govindraj.R <govindraj.raja@ti.com>
---
 arch/arm/plat-omap/omap_device.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index d8f2299..ecec0cc 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -154,7 +154,7 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 					"%d: %llu\n",
 					od->pm_lat_level, act_lat);
 			} else
-				dev_warn(&od->pdev->dev,
+				dev_dbg(&od->pdev->dev,
 					 "activate latency %d "
 					 "higher than exptected. (%llu > %d)\n",
 					 od->pm_lat_level, act_lat,
@@ -221,7 +221,7 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 					"%d: %llu\n",
 					od->pm_lat_level, deact_lat);
 			} else
-				dev_warn(&od->pdev->dev,
+				dev_dbg(&od->pdev->dev,
 					 "deactivate latency %d "
 					 "higher than exptected. (%llu > %d)\n",
 					 od->pm_lat_level, deact_lat,
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 
