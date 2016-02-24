From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 24 Feb 2016 18:45:30 +0530
Subject: [PATCH 05/50] pinctrl: cygnus-mux: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <1456319775-3216-6-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use devm_pinctrl_register() for pin control registration.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Ray Jui <rjui@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>
Cc: Jon Mason <jonmason@broadcom.com>
---
 drivers/pinctrl/bcm/pinctrl-cygnus-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
index 9728f3d..9382a0a 100644
--- a/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
+++ b/drivers/pinctrl/bcm/pinctrl-cygnus-mux.c
@@ -987,7 +987,7 @@ static int cygnus_pinmux_probe(struct platform_device *pdev)
 	cygnus_pinctrl_desc.pins = pins;
 	cygnus_pinctrl_desc.npins = num_pins;
 
-	pinctrl->pctl = pinctrl_register(&cygnus_pinctrl_desc, &pdev->dev,
+	pinctrl->pctl = devm_pinctrl_register(&pdev->dev, &cygnus_pinctrl_desc,
 			pinctrl);
 	if (IS_ERR(pinctrl->pctl)) {
 		dev_err(&pdev->dev, "unable to register Cygnus IOMUX pinctrl\n");
-- 
2.1.4
