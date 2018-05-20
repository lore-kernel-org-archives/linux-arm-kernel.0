From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Mon, 21 May 2018 01:01:51 +0800
Subject: [PATCH v1 5/7] pinctrl: mediatek: remove unused fields in struct
 mtk_eint_hw
In-Reply-To: <cover.1526835466.git.sean.wang@mediatek.com>
References: <cover.1526835466.git.sean.wang@mediatek.com>
Message-ID: <72462fb7aab16463a42066998ac3b4bf35ada416.1526835466.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

The .name field has been not being used in existent code logic, so
it's better that we remove them all.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/pinctrl/mediatek/mtk-eint.h       | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt2701.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt2712.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8127.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8135.c | 1 -
 drivers/pinctrl/mediatek/pinctrl-mt8173.c | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
index 55b4d5f..c286a9b 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.h
+++ b/drivers/pinctrl/mediatek/mtk-eint.h
@@ -33,7 +33,6 @@ struct mtk_eint_regs {
 };
 
 struct mtk_eint_hw {
-	const char	*name;
 	u8		port_mask;
 	u8		ports;
 	unsigned int	ap_num;
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2701.c b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
index db22250..e91c314 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2701.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2701.c
@@ -532,7 +532,6 @@ static const struct mtk_pinctrl_devdata mt2701_pinctrl_data = {
 	.port_mask = 0x1f,
 	.port_align = 4,
 	.eint_hw = {
-		.name = "mt2701_eint",
 		.port_mask = 6,
 		.ports     = 6,
 		.ap_num    = 169,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt2712.c b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
index 6e2acef..8398d55 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt2712.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt2712.c
@@ -577,7 +577,6 @@ static const struct mtk_pinctrl_devdata mt2712_pinctrl_data = {
 	.port_mask = 0xf,
 	.port_align = 4,
 	.eint_hw = {
-		.name = "mt2712_eint",
 		.port_mask = 0xf,
 		.ports     = 8,
 		.ap_num    = 229,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8127.c b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
index 949a235..2e4cc92 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8127.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8127.c
@@ -301,7 +301,6 @@ static const struct mtk_pinctrl_devdata mt8127_pinctrl_data = {
 	.port_mask = 0xf,
 	.port_align = 4,
 	.eint_hw = {
-		.name = "mt8127_eint",
 		.port_mask = 7,
 		.ports     = 6,
 		.ap_num    = 143,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8135.c b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
index 974a1f43..7f5edfa 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8135.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8135.c
@@ -314,7 +314,6 @@ static const struct mtk_pinctrl_devdata mt8135_pinctrl_data = {
 	.port_mask = 0xf,
 	.port_align = 4,
 	.eint_hw = {
-		.name = "mt8135_eint",
 		.port_mask = 7,
 		.ports     = 6,
 		.ap_num    = 192,
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index a836cee3..c449c9a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -341,7 +341,6 @@ static const struct mtk_pinctrl_devdata mt8173_pinctrl_data = {
 	.port_mask = 0xf,
 	.port_align = 4,
 	.eint_hw = {
-		.name = "mt8173_eint",
 		.port_mask = 7,
 		.ports     = 6,
 		.ap_num    = 224,
-- 
2.7.4
