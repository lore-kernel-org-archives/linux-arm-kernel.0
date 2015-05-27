From: hongzhou.yang@mediatek.com (Hongzhou Yang)
Date: Wed, 27 May 2015 02:43:54 -0700
Subject: [PATCH 1/2] pinctrl: mediatek: Fix bug of ies/smt setting for mt8173.
In-Reply-To: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
References: <1432719835-18939-1-git-send-email-hongzhou.yang@mediatek.com>
Message-ID: <1432719835-18939-2-git-send-email-hongzhou.yang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ies/smt support for MSDC3.
Also fix ies bug for pin 106 and 107.

Signed-off-by: Hongzhou Yang <hongzhou.yang@mediatek.com>
---
 drivers/pinctrl/mediatek/pinctrl-mt8173.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8173.c b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
index cf4ed6e..d0c811d 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt8173.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt8173.c
@@ -84,6 +84,10 @@ static const struct mtk_pin_ies_smt_set mt8173_smt_set[] = {
 	MTK_PIN_IES_SMT_SPEC(16, 16, 0x930, 0),
 	MTK_PIN_IES_SMT_SPEC(17, 17, 0x950, 2),
 	MTK_PIN_IES_SMT_SPEC(18, 21, 0x940, 3),
+	MTK_PIN_IES_SMT_SPEC(22, 25, 0xce0, 13),
+	MTK_PIN_IES_SMT_SPEC(26, 26, 0xcc0, 13),
+	MTK_PIN_IES_SMT_SPEC(27, 27, 0xcd0, 13),
+	MTK_PIN_IES_SMT_SPEC(28, 28, 0xd70, 13),
 	MTK_PIN_IES_SMT_SPEC(29, 32, 0x930, 3),
 	MTK_PIN_IES_SMT_SPEC(33, 33, 0x930, 4),
 	MTK_PIN_IES_SMT_SPEC(34, 36, 0x930, 5),
@@ -133,6 +137,10 @@ static const struct mtk_pin_ies_smt_set mt8173_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(16, 16, 0x900, 0),
 	MTK_PIN_IES_SMT_SPEC(17, 17, 0x920, 2),
 	MTK_PIN_IES_SMT_SPEC(18, 21, 0x910, 3),
+	MTK_PIN_IES_SMT_SPEC(22, 25, 0xce0, 14),
+	MTK_PIN_IES_SMT_SPEC(26, 26, 0xcc0, 14),
+	MTK_PIN_IES_SMT_SPEC(27, 27, 0xcd0, 14),
+	MTK_PIN_IES_SMT_SPEC(28, 28, 0xd70, 14),
 	MTK_PIN_IES_SMT_SPEC(29, 32, 0x900, 3),
 	MTK_PIN_IES_SMT_SPEC(33, 33, 0x900, 4),
 	MTK_PIN_IES_SMT_SPEC(34, 36, 0x900, 5),
@@ -161,7 +169,7 @@ static const struct mtk_pin_ies_smt_set mt8173_ies_set[] = {
 	MTK_PIN_IES_SMT_SPEC(100, 103, 0xca0, 14),
 	MTK_PIN_IES_SMT_SPEC(104, 104, 0xc80, 14),
 	MTK_PIN_IES_SMT_SPEC(105, 105, 0xc90, 14),
-	MTK_PIN_IES_SMT_SPEC(106, 107, 0x91, 4),
+	MTK_PIN_IES_SMT_SPEC(106, 107, 0x910, 4),
 	MTK_PIN_IES_SMT_SPEC(108, 112, 0x910, 1),
 	MTK_PIN_IES_SMT_SPEC(113, 116, 0x910, 2),
 	MTK_PIN_IES_SMT_SPEC(117, 118, 0x910, 5),
-- 
1.7.9.5
