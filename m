From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Tue, 20 Nov 2018 21:17:49 -0800
Subject: [PATCH v8 4/7] ASoC: simple-amplifier: make enable-gpio optional
In-Reply-To: <20181121051752.18387-1-anarsoul@gmail.com>
References: <20181121051752.18387-1-anarsoul@gmail.com>
Message-ID: <20181121051752.18387-5-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Amplifier may have no enable GPIO, so make this property
optional.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 sound/soc/codecs/simple-amplifier.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/simple-amplifier.c b/sound/soc/codecs/simple-amplifier.c
index c07e8a80b4b7..351aa55c384e 100644
--- a/sound/soc/codecs/simple-amplifier.c
+++ b/sound/soc/codecs/simple-amplifier.c
@@ -89,7 +89,8 @@ static int simple_amp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->gpiod_enable = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
+	priv->gpiod_enable = devm_gpiod_get_optional(dev, "enable",
+						     GPIOD_OUT_LOW);
 	if (IS_ERR(priv->gpiod_enable)) {
 		err = PTR_ERR(priv->gpiod_enable);
 		if (err != -EPROBE_DEFER)
-- 
2.19.1
