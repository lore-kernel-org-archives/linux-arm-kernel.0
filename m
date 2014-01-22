From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Wed, 22 Jan 2014 20:04:20 +0100
Subject: [PATCH v2 5/5] [RFC] omapdss: remove FEAT_DPI_USES_VDDS_DSI from omap3
In-Reply-To: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
References: <1390417460-3134-1-git-send-email-chf.fritz@googlemail.com>
Message-ID: <1390417460-3134-6-git-send-email-chf.fritz@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DBB056 doesn't use DSI for its display, but omap3 forces this
erroneously for all its boards:

  | OMAP DSS rev 2.0
  | omapdss DPI error: can't get VDDS_DSI regulator
  | omapfb omapfb: failed to connect default display
  | omapfb omapfb: failed to init overlay connections
  | omapfb omapfb: failed to setup omapfb
  | platform omapfb: Driver omapfb requests probe deferral

So this patch just disables it for omap3. Consider this as a hack!
Is there a proper fix for this issue?
---
 drivers/video/omap2/dss/dss_features.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dss_features.c b/drivers/video/omap2/dss/dss_features.c
index 7f89691..dbf5894 100644
--- a/drivers/video/omap2/dss/dss_features.c
+++ b/drivers/video/omap2/dss/dss_features.c
@@ -536,7 +536,6 @@ static const enum dss_feat_id omap3630_dss_feat_list[] = {
 	FEAT_ALPHA_FIXED_ZORDER,
 	FEAT_FIFO_MERGE,
 	FEAT_OMAP3_DSI_FIFO_BUG,
-	FEAT_DPI_USES_VDDS_DSI,
 };
 
 static const enum dss_feat_id omap4430_es1_0_dss_feat_list[] = {
-- 
1.7.10.4
