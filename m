From: aalonso@freescale.com (Adrian Alonso)
Date: Tue, 18 Aug 2015 10:48:58 -0500
Subject: [PATCH 7/8] pinctrl: freescale: imx: fix flat functions default return
In-Reply-To: <1439912939-17535-1-git-send-email-aalonso@freescale.com>
References: <1439912939-17535-1-git-send-email-aalonso@freescale.com>
Message-ID: <1439912939-17535-7-git-send-email-aalonso@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix imx pinctrl dt flat functions default return value.
If property fsl,pins is not found in function_np and
pinctrl_np return false to indicate that DT is not using
flat functions.

Signed-off-by: Adrian Alonso <aalonso@freescale.com>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 1009b52..3e02887 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -641,7 +641,7 @@ static bool imx_pinctrl_dt_is_flat_functions(struct device_node *np)
 		}
 	}
 
-	return true;
+	return false;
 }
 
 static int imx_pinctrl_probe_dt(struct platform_device *pdev,
-- 
2.1.4
