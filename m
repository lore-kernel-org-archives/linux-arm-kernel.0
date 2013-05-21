From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Tue, 21 May 2013 20:04:06 +0200
Subject: [PATCH v2 2/3] staging: drm/imx: fix spelling error for vsync flag
 config
In-Reply-To: <1369159448-14584-1-git-send-email-list-09_linux_arm@tqsc.de>
References: <1369159448-14584-1-git-send-email-list-09_linux_arm@tqsc.de>
Message-ID: <1369159448-14584-3-git-send-email-list-09_linux_arm@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Niebel <Markus.Niebel@tqs.de>

partial fix of changes from
"staging: drm/imx: Add support for VGA via TVE on i.MX53"

Have to check for vsync_pin instead of hsync_pin to set Vsync_pol.

Signed-off-by: Markus Niebel <Markus.Niebel@tqs.de>
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
---
V2:
  - no changes in patch
  - add Acked-by from v1 of patch

 drivers/staging/imx-drm/ipu-v3/ipu-di.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-di.c b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
index 19d777e..e7b9c98 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-di.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-di.c
@@ -614,11 +614,11 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 				di_gen |= DI_GEN_POLARITY_7;
 		}
 		if (sig->Vsync_pol) {
-			if (sig->hsync_pin == 3)
+			if (sig->vsync_pin == 3)
 				di_gen |= DI_GEN_POLARITY_3;
-			else if (sig->hsync_pin == 6)
+			else if (sig->vsync_pin == 6)
 				di_gen |= DI_GEN_POLARITY_6;
-			else if (sig->hsync_pin == 8)
+			else if (sig->vsync_pin == 8)
 				di_gen |= DI_GEN_POLARITY_8;
 		}
 	}
-- 
1.7.9.5
