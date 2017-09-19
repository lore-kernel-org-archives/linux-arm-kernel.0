From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 19 Sep 2017 12:00:28 +0800
Subject: [PATCH v4 7/9] soc: mediatek: add dependent clock jpgdec/audio for
 scpsys
In-Reply-To: <1505793630-12590-1-git-send-email-weiyi.lu@mediatek.com>
References: <1505793630-12590-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1505793630-12590-8-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are dependent clock jpgdec/audio in scpsys on MT2712,
and will exist three dependent clocks on MT2712 VDEC.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-scpsys.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
index 2569390..28c6e6a 100644
--- a/drivers/soc/mediatek/mtk-scpsys.c
+++ b/drivers/soc/mediatek/mtk-scpsys.c
@@ -84,6 +84,8 @@ enum clk_id {
 	CLK_ETHIF,
 	CLK_VDEC,
 	CLK_HIFSEL,
+	CLK_JPGDEC,
+	CLK_AUDIO,
 	CLK_MAX,
 };
 
@@ -96,10 +98,12 @@ enum clk_id {
 	"ethif",
 	"vdec",
 	"hif_sel",
+	"jpgdec",
+	"audio",
 	NULL,
 };
 
-#define MAX_CLKS	2
+#define MAX_CLKS	3
 
 struct scp_domain_data {
 	const char *name;
-- 
1.9.1
