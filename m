From: mihai.dumitru2201@gmail.com (Mihai-Valentin DUMITRU)
Date: Sat, 25 Feb 2017 12:18:34 +0200
Subject: [PATCH] ASoC: rockchip: i2s: Remove unnecessary 'out of memory'
 message
Message-ID: <20170225101834.28232-1-mihai.dumitru2201@stud.acs.upb.ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was reported by checkpatch.pl

Signed-off-by: Mihai-Valentin DUMITRU <mihai.dumitru2201@gmail.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 974915cb4c4f..d02a1045fc0b 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -551,10 +551,8 @@ static int rockchip_i2s_probe(struct platform_device *pdev)
 	int val;
 
 	i2s = devm_kzalloc(&pdev->dev, sizeof(*i2s), GFP_KERNEL);
-	if (!i2s) {
-		dev_err(&pdev->dev, "Can't allocate rk_i2s_dev\n");
+	if (!i2s)
 		return -ENOMEM;
-	}
 
 	i2s->dev = &pdev->dev;
 
-- 
2.11.1
