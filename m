From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 12 Nov 2018 15:33:56 +0800
Subject: [PATCH v1 2/3] pwm: mediatek: add pwm support for MT7629 SoC
In-Reply-To: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542007642.git.ryder.lee@mediatek.com>
References: <4c9044427b1aab373acd6ac76f0c905e2be79784.1542007642.git.ryder.lee@mediatek.com>
Message-ID: <9043534495d49c532bdb0b904344b77faeb41359.1542007642.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds pwm controller support for MT7629 SoC.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/pwm/pwm-mediatek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 9400c41..4ed95e5 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -292,11 +292,16 @@ static int mtk_pwm_remove(struct platform_device *pdev)
 	.pwm45_fixup = true,
 };
 
+static const struct mtk_pwm_platform_data mt7629_pwm_data = {
+	.num_pwms = 1,
+};
+
 static const struct of_device_id mtk_pwm_of_match[] = {
 	{ .compatible = "mediatek,mt2712-pwm", .data = &mt2712_pwm_data },
 	{ .compatible = "mediatek,mt7622-pwm", .data = &mt7622_pwm_data },
 	{ .compatible = "mediatek,mt7623-pwm", .data = &mt7623_pwm_data },
 	{ .compatible = "mediatek,mt7628-pwm", .data = &mt7628_pwm_data },
+	{ .compatible = "mediatek,mt7629-pwm", .data = &mt7629_pwm_data },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, mtk_pwm_of_match);
-- 
1.9.1
