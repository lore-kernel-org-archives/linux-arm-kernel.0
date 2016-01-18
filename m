From: rainyfeeling@gmail.com (Josh Wu)
Date: Mon, 18 Jan 2016 20:52:19 +0800
Subject: [PATCH 08/13] atmel-isi: remove the function set_dma_ctrl() as it
 just use once
In-Reply-To: <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
References: <1453119709-20940-1-git-send-email-rainyfeeling@gmail.com>
 <1453121545-27528-1-git-send-email-rainyfeeling@gmail.com>
Message-ID: <1453121545-27528-3-git-send-email-rainyfeeling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Josh Wu <josh.wu@atmel.com>

Signed-off-by: Josh Wu <rainyfeeling@gmail.com>
---

 drivers/media/platform/soc_camera/atmel-isi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/media/platform/soc_camera/atmel-isi.c b/drivers/media/platform/soc_camera/atmel-isi.c
index ed4d04b..e1ad18f 100644
--- a/drivers/media/platform/soc_camera/atmel-isi.c
+++ b/drivers/media/platform/soc_camera/atmel-isi.c
@@ -46,11 +46,6 @@ struct fbd {
 	u32 next_fbd_address;
 };
 
-static void set_dma_ctrl(struct fbd *fb_desc, u32 ctrl)
-{
-	fb_desc->dma_ctrl = ctrl;
-}
-
 struct isi_dma_desc {
 	struct list_head list;
 	struct fbd *p_fbd;
@@ -385,7 +380,7 @@ static int buffer_prepare(struct vb2_buffer *vb)
 			desc->p_fbd->fb_address =
 					vb2_dma_contig_plane_dma_addr(vb, 0);
 			desc->p_fbd->next_fbd_address = 0;
-			set_dma_ctrl(desc->p_fbd, ISI_DMA_CTRL_WB);
+			desc->p_fbd->dma_ctrl = ISI_DMA_CTRL_WB;
 
 			buf->p_dma_desc = desc;
 		}
-- 
1.9.1
