From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:29:04 +0100
Subject: [PATCH 6/6] staging: drm/imx: Remove 300ms delay after memory reset
In-Reply-To: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
References: <1352734144-14897-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352734144-14897-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Philipp Zabel <p.zabel@pengutronix.de>

This has been added once, but does not seem to be necessary. Tested
on i.MX51 and i.MX6.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-common.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-common.c b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
index d871bb6..147c3e9 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-common.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-common.c
@@ -673,8 +673,6 @@ static int ipu_reset(struct ipu_soc *ipu)
 		cpu_relax();
 	}
 
-	mdelay(300);
-
 	return 0;
 }
 
-- 
1.7.10.4
