From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Sat, 8 Sep 2018 19:07:36 +0800
Subject: [PATCH v2 20/22] pintcrl: mediatek: add pull tweaks for I2C related
 pins on MT8183
In-Reply-To: <cover.1536404280.git.sean.wang@mediatek.com>
References: <cover.1536404280.git.sean.wang@mediatek.com>
Message-ID: <3d957d32b5b0f67548f63ae4ba7176dba9e61faa.1536404280.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhiyong Tao <zhiyong.tao@mediatek.com>

This patch provides the advanced pull for I2C used pins on MT8183.

Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8183.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
index bd3f00b..9d5aa27 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
@@ -397,10 +397,22 @@ static const struct mtk_pin_field_calc mt8183_pin_r0_range[] = {
 	PIN_FIELD_BASE(40, 40, 3, 0x0C0, 0x10, 20, 1),
 	PIN_FIELD_BASE(41, 41, 3, 0x0C0, 0x10, 24, 1),
 	PIN_FIELD_BASE(42, 42, 3, 0x0C0, 0x10, 28, 1),
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 18, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 13, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 10, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 5, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 7, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 5, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 15, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 17, 1),
 	PIN_FIELD_BASE(91, 91, 6, 0x0C0, 0x10, 0, 1),
 	PIN_FIELD_BASE(92, 92, 6, 0x0C0, 0x10, 4, 1),
 	PIN_FIELD_BASE(93, 93, 6, 0x0C0, 0x10, 8, 1),
 	PIN_FIELD_BASE(94, 94, 6, 0x0C0, 0x10, 12, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 20, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 10, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 22, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 12, 1),
 	PIN_FIELD_BASE(122, 122, 8, 0x0C0, 0x10, 0, 1),
 	PIN_FIELD_BASE(123, 123, 8, 0x0C0, 0x10, 4, 1),
 	PIN_FIELD_BASE(124, 124, 8, 0x0C0, 0x10, 8, 1),
@@ -430,10 +442,22 @@ static const struct mtk_pin_field_calc mt8183_pin_r1_range[] = {
 	PIN_FIELD_BASE(40, 40, 3, 0x0C0, 0x10, 21, 1),
 	PIN_FIELD_BASE(41, 41, 3, 0x0C0, 0x10, 25, 1),
 	PIN_FIELD_BASE(42, 42, 3, 0x0C0, 0x10, 29, 1),
+	PIN_FIELD_BASE(48, 48, 3, 0x0F0, 0x10, 19, 1),
+	PIN_FIELD_BASE(49, 49, 3, 0x0F0, 0x10, 14, 1),
+	PIN_FIELD_BASE(50, 50, 4, 0x0F0, 0x10, 11, 1),
+	PIN_FIELD_BASE(51, 51, 4, 0x0F0, 0x10, 6, 1),
+	PIN_FIELD_BASE(81, 81, 5, 0x0F0, 0x10, 8, 1),
+	PIN_FIELD_BASE(82, 82, 5, 0x0F0, 0x10, 6, 1),
+	PIN_FIELD_BASE(83, 83, 5, 0x0F0, 0x10, 16, 1),
+	PIN_FIELD_BASE(84, 84, 5, 0x0F0, 0x10, 18, 1),
 	PIN_FIELD_BASE(91, 91, 6, 0x0C0, 0x10, 1, 1),
 	PIN_FIELD_BASE(92, 92, 6, 0x0C0, 0x10, 5, 1),
 	PIN_FIELD_BASE(93, 93, 6, 0x0C0, 0x10, 9, 1),
 	PIN_FIELD_BASE(94, 94, 6, 0x0C0, 0x10, 13, 1),
+	PIN_FIELD_BASE(103, 103, 6, 0x0F0, 0x10, 21, 1),
+	PIN_FIELD_BASE(104, 104, 6, 0x0F0, 0x10, 11, 1),
+	PIN_FIELD_BASE(105, 105, 6, 0x0F0, 0x10, 23, 1),
+	PIN_FIELD_BASE(106, 106, 6, 0x0F0, 0x10, 13, 1),
 	PIN_FIELD_BASE(122, 122, 8, 0x0C0, 0x10, 1, 1),
 	PIN_FIELD_BASE(123, 123, 8, 0x0C0, 0x10, 5, 1),
 	PIN_FIELD_BASE(124, 124, 8, 0x0C0, 0x10, 9, 1),
-- 
2.7.4
