From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 16 Feb 2013 11:25:53 +0900
Subject: [PATCH] sh-pfc: sh_pfc_probe() sizeof() fix
In-Reply-To: <1360981553-11414-1-git-send-email-horms+renesas@verge.net.au>
References: <1360981553-11414-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1360981553-11414-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Fix sizeof() usage in sh-pfc/core.c to allocate space
for the full data structure instead of a pointer.

Signed-off-by: Magnus Damm <damm@opensource.se>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index d323c24f..970ddff 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -495,7 +495,7 @@ static int sh_pfc_probe(struct platform_device *pdev)
 	if (info == NULL)
 		return -ENODEV;
 
-	pfc = devm_kzalloc(&pdev->dev, sizeof(pfc), GFP_KERNEL);
+	pfc = devm_kzalloc(&pdev->dev, sizeof(*pfc), GFP_KERNEL);
 	if (pfc == NULL)
 		return -ENOMEM;
 
-- 
1.7.10.4
