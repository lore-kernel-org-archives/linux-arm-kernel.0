From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Thu, 27 Oct 2016 22:23:24 +0200
Subject: [PATCH next 1/2] media: mtk-mdp: fix video_device_release argument
In-Reply-To: <1473340146-6598-4-git-send-email-minghsiu.tsai@mediatek.com>
References: <1473340146-6598-4-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <20161027202325.20680-1-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

video_device_release() takes a pointer to struct video_device as argument.
Fix two call sites where the address of the pointer is passed instead.

Fixes: c8eb2d7e8202fd9c ("[media] media: Add Mediatek MDP Driver")
Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Mauro Carvalho Chehab <mchehab@s-opensource.com>
---
 drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
index 9a747e7..4a9e3e9d 100644
--- a/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
+++ b/drivers/media/platform/mtk-mdp/mtk_mdp_m2m.c
@@ -1267,13 +1267,13 @@ int mtk_mdp_register_m2m_device(struct mtk_mdp_dev *mdp)
 err_vdev_register:
 	v4l2_m2m_release(mdp->m2m_dev);
 err_m2m_init:
-	video_device_release(&mdp->vdev);
+	video_device_release(mdp->vdev);
 
 	return ret;
 }
 
 void mtk_mdp_unregister_m2m_device(struct mtk_mdp_dev *mdp)
 {
-	video_device_release(&mdp->vdev);
+	video_device_release(mdp->vdev);
 	v4l2_m2m_release(mdp->m2m_dev);
 }
-- 
2.9.3
