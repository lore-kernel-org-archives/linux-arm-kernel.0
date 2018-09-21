From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 21 Sep 2018 12:07:38 +0800
Subject: [PATCH 4/4] pinctrl: mediatek: add eint support to MT6765 pinctrl
 driver
In-Reply-To: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
References: <ab85fbee4d8286cbedbcc7317f89dc0d2dd83965.1537502494.git.sean.wang@mediatek.com>
Message-ID: <82d47055aec8e40422eb72568e96bfbaf199d9d2.1537502494.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mars Cheng <mars.cheng@mediatek.com>

Just add eint support to MT6765 pinctrl driver as usual as
happens on the other SoCs.

Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt6765.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6765.c b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
index 1cae634..32451e8 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6765.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
@@ -1056,11 +1056,19 @@ static const char * const mt6765_pinctrl_register_base_names[] = {
 	"iocfg6", "iocfg7",
 };
 
+static const struct mtk_eint_hw mt6765_eint_hw = {
+	.port_mask = 7,
+	.ports     = 6,
+	.ap_num    = 160,
+	.db_cnt    = 13,
+};
+
 static const struct mtk_pin_soc mt6765_data = {
 	.reg_cal = mt6765_reg_cals,
 	.pins = mtk_pins_mt6765,
 	.npins = ARRAY_SIZE(mtk_pins_mt6765),
 	.ngrps = ARRAY_SIZE(mtk_pins_mt6765),
+	.eint_hw = &mt6765_eint_hw,
 	.gpio_m = 0,
 	.ies_present = true,
 	.base_names = mt6765_pinctrl_register_base_names,
-- 
2.7.4
