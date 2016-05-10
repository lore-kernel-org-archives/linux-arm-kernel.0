From: chunfeng.yun@mediatek.com (Chunfeng Yun)
Date: Tue, 10 May 2016 16:23:34 +0800
Subject: [PATCH 6/6] pinctrl: mt8173: set GPIO16 to usb iddig mode
In-Reply-To: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1462868614-20602-1-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <1462868614-20602-7-git-send-email-chunfeng.yun@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the default mode of GPIO16 pin is gpio, when set EINT16 to
IRQ_TYPE_LEVEL_HIGH, no interrupt is triggered, it can be
fixed when set its default mode as usb iddig.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
index 13e5b68..9b018fd 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-mt8173.h
@@ -201,7 +201,7 @@ static const struct mtk_desc_pin mtk_pins_mt8173[] = {
 	MTK_PIN(
 		PINCTRL_PIN(16, "IDDIG"),
 		NULL, "mt8173",
-		MTK_EINT_FUNCTION(0, 16),
+		MTK_EINT_FUNCTION(1, 16),
 		MTK_FUNCTION(0, "GPIO16"),
 		MTK_FUNCTION(1, "IDDIG"),
 		MTK_FUNCTION(2, "CMFLASH"),
-- 
1.7.9.5
