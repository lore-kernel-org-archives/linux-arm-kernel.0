From: jc@linux.com (Jesse Chan)
Date: Sun, 19 Nov 2017 23:47:54 -0800
Subject: [PATCH v3] media: mtk-vcodec: add missing MODULE_LICENSE/DESCRIPTION
In-Reply-To: <20171120063930.82066-1-jc@linux.com>
References: <20171120063930.82066-1-jc@linux.com>
Message-ID: <20171120074754.67708-1-jc@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change resolves a new compile-time warning
when built as a loadable module:

WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o
see include/linux/module.h for more information

This adds the license as "GPL v2", which matches the header of the file.

MODULE_DESCRIPTION is also added.

Signed-off-by: Jesse Chan <jc@linux.com>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
index 46768c056193..0c28d0b995cc 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_util.c
@@ -115,3 +115,6 @@ struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *dev)
 	return ctx;
 }
 EXPORT_SYMBOL(mtk_vcodec_get_curr_ctx);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mediatek video codec driver");
-- 
2.14.1
