From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Thu, 14 Aug 2014 14:11:24 +0200
Subject: [PATCH v6 2/6] ASoC: mxs-saif: fix mixed use of public and provider
 clk API
In-Reply-To: <1408018287-14217-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1408018287-14217-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1408018287-14217-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation to changing the clk provider API to use struct clk_core instead
of struct clk.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/mxs/mxs-saif.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
index 231d7e7..a24367d 100644
--- a/sound/soc/mxs/mxs-saif.c
+++ b/sound/soc/mxs/mxs-saif.c
@@ -682,11 +682,11 @@ static int mxs_saif_mclk_init(struct platform_device *pdev)
 {
 	struct mxs_saif *saif = platform_get_drvdata(pdev);
 	struct device_node *np = pdev->dev.of_node;
-	struct clk *clk;
+	struct clk_core *clk;
 	int ret;
 
 	clk = clk_register_divider(&pdev->dev, "mxs_saif_mclk",
-				   __clk_get_name(saif->clk), 0,
+				   clk_get_name(saif->clk), 0,
 				   saif->base + SAIF_CTRL,
 				   BP_SAIF_CTRL_BITCLK_MULT_RATE, 3,
 				   0, NULL);
-- 
1.9.3
