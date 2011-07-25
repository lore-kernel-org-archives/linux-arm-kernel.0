From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 25 Jul 2011 16:18:24 +0300
Subject: [PATCH] OMAP: omap_device: make latency autoadjust messages debug
Message-ID: <1311599904-5981-1-git-send-email-notasas@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During normal system operation warning messages similar to this
are appearing quite often:
omap_device: omap4-keypad.-1: new worst case activate latency 0: 61035

This doesn't seem to be reporting a problem, nor is it very useful for
non-developers, so reduce it to debug level.

Cc: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
---
Applies on top of git://git.pwsan.com/linux-2.6 prcm-devel-3.1
+ Kevin's "OMAP: omap_device: replace pr_* prints with dev_*".

 arch/arm/plat-omap/omap_device.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 1914d7e..f363cbf 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -146,10 +146,10 @@ static int _omap_device_activate(struct omap_device *od, u8 ignore_lat)
 			odpl->activate_lat_worst = act_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->activate_lat = act_lat;
-				dev_warn(&od->pdev.dev,
-					 "new worst case activate latency "
-					 "%d: %llu\n",
-					 od->pm_lat_level, act_lat);
+				dev_dbg(&od->pdev.dev,
+					"new worst case activate latency "
+					"%d: %llu\n",
+					od->pm_lat_level, act_lat);
 			} else
 				dev_warn(&od->pdev.dev,
 					 "activate latency %d "
@@ -213,10 +213,10 @@ static int _omap_device_deactivate(struct omap_device *od, u8 ignore_lat)
 			odpl->deactivate_lat_worst = deact_lat;
 			if (odpl->flags & OMAP_DEVICE_LATENCY_AUTO_ADJUST) {
 				odpl->deactivate_lat = deact_lat;
-				dev_warn(&od->pdev.dev,
-					 "new worst case deactivate latency "
-					 "%d: %llu\n",
-					 od->pm_lat_level, deact_lat);
+				dev_dbg(&od->pdev.dev,
+					"new worst case deactivate latency "
+					"%d: %llu\n",
+					od->pm_lat_level, deact_lat);
 			} else
 				dev_warn(&od->pdev.dev,
 					 "deactivate latency %d "
-- 
1.7.0.4
