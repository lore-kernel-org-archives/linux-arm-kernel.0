From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 14 Jun 2013 01:45:46 +0200
Subject: [PATCH v6 01/18] sh-pfc: Remove support for platform data
In-Reply-To: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1371167163-10507-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1371167163-10507-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data isn't used, support can thus be removed.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 3b2fd43..ac45084 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -354,8 +354,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	struct sh_pfc *pfc;
 	int ret;
 
-	info = pdev->id_entry->driver_data
-	      ? (void *)pdev->id_entry->driver_data : pdev->dev.platform_data;
+	info = (void *)pdev->id_entry->driver_data;
 	if (info == NULL)
 		return -ENODEV;
 
-- 
1.8.1.5
