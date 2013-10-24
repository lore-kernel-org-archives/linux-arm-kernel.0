From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 24 Oct 2013 17:55:18 +0200
Subject: [PATCH] ASoC: kirkwood: Fix compile error due to patch 'add S/PDIF
 support'
Message-ID: <20131024175518.49b80343@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the compilation error of kirkwood-i2s.c introduced
by the commit 75b9b65ee5a80e99e 'ASoC: kirkwood: add S/PDIF support'.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---

Mark, sorry for this error.
This patch applies on your repository broonie/sound.git/ topic/kirkwood.
I may give you an other patch to apply with the commit removed.

---
 sound/soc/kirkwood/kirkwood-i2s.c     | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood/kirkwood-i2s.c
index 9ec38d1..d34d917 100644
--- a/sound/soc/kirkwood/kirkwood-i2s.c
+++ b/sound/soc/kirkwood/kirkwood-i2s.c
@@ -568,7 +568,7 @@ static int kirkwood_i2s_dev_probe(struct platform_device *pdev)
 		} else {
 			dev_info(&pdev->dev, "found external clock\n");
 			clk_prepare_enable(priv->extclk);
-			soc_dai = &kirkwood_i2s_dai_extclk;
+			soc_dai = kirkwood_i2s_dai_extclk;
 		}
 	}
 


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
