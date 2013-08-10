From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 10 Aug 2013 14:55:57 +0200
Subject: [PATCH] ASoC: imx-audmux: default configuration parser fixups
In-Reply-To: <20130809123712.GD13664@s25.your-server.de>
References: <20130809123712.GD13664@s25.your-server.de>
Message-ID: <1376139357-21089-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 sound/soc/fsl/imx-audmux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-audmux.c b/sound/soc/fsl/imx-audmux.c
index f37cd9c..b21b85f 100644
--- a/sound/soc/fsl/imx-audmux.c
+++ b/sound/soc/fsl/imx-audmux.c
@@ -270,7 +270,7 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 		}
 
 		for (i = 0; (ret = of_property_read_u32_index(child,
-					"fsl,port-config\n", i, &val)) == 0;
+					"fsl,port-config", i, &val)) == 0;
 				++i) {
 			if (audmux_type == IMX31_AUDMUX) {
 				if (i % 2)
@@ -282,7 +282,7 @@ static int imx_audmux_parse_dt_defaults(struct platform_device *pdev,
 			}
 		}
 
-		if (ret != -ENODATA) {
+		if (ret != -EOVERFLOW) {
 			dev_err(&pdev->dev, "Failed to read u32 at index %d of child %s\n",
 					i, child->full_name);
 			continue;
-- 
1.8.3.2
