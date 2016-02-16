From: biao.huang@mediatek.com (Biao Huang)
Date: Wed, 17 Feb 2016 03:16:33 +0800
Subject: [PATCH 1/2] pinctrl: mediatek: add input-enable setting in
 gpio_request_enable
In-Reply-To: <1455650194-9813-1-git-send-email-biao.huang@mediatek.com>
References: <1455650194-9813-1-git-send-email-biao.huang@mediatek.com>
Message-ID: <1455650194-9813-2-git-send-email-biao.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since input-disable cuts off input signal of gpio, add input-enable
setting in .gpio_request_enable implementation to ensure gpio function well

Signed-off-by: Biao Huang <biao.huang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
index 6024483..578897a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common.c
@@ -764,6 +764,7 @@ static int mtk_pmx_gpio_request_enable(struct pinctrl_dev *pctldev,
 	}
 
 	mtk_pmx_set_mode(pctldev, offset, muxval);
+	mtk_pconf_set_ies_smt(pctl, offset, 1, PIN_CONFIG_INPUT_ENABLE);
 
 	return 0;
 }
-- 
1.7.9.5
