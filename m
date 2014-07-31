From: panpan1.liu@samsung.com (panpan liu)
Date: Thu, 31 Jul 2014 16:28:15 +0800
Subject: [PATCH] videobuf2-core: simplify and unify the kernel api
Message-ID: <1406795295-3013-1-git-send-email-panpan1.liu@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Making the kernel api more simplified and unified.

Signed-off-by: panpan liu <panpan1.liu@samsung.com>
---
 drivers/media/v4l2-core/videobuf2-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 drivers/media/v4l2-core/videobuf2-core.c

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
old mode 100644
new mode 100755
index 9abb15e..71ba92c
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -1194,7 +1194,7 @@ static void __enqueue_in_driver(struct vb2_buffer *vb)
 	for (plane = 0; plane < vb->num_planes; ++plane)
 		call_memop(q, prepare, vb->planes[plane].mem_priv);

-	q->ops->buf_queue(vb);
+	call_qop(q, buf_queue, vb);
 }

 static int __buf_prepare(struct vb2_buffer *vb, const struct v4l2_buffer *b)
--
1.7.9.5
