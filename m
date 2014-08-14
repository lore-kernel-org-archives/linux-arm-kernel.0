From: panpan1.liu@samsung.com (panpan liu)
Date: Thu, 14 Aug 2014 15:11:01 +0800
Subject: [PATCH] videobuf2-core: modify the num of users
Message-ID: <1408000262-2774-1-git-send-email-panpan1.liu@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If num_users returns 1 or more than 1, that means we are not the
only user of the plane's memory.

Signed-off-by: panpan liu <panpan1.liu@samsung.com>
---
 drivers/media/v4l2-core/videobuf2-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/videobuf2-core.c b/drivers/media/v4l2-core/videobuf2-core.c
index c359006..d3a4b8f 100644
--- a/drivers/media/v4l2-core/videobuf2-core.c
+++ b/drivers/media/v4l2-core/videobuf2-core.c
@@ -625,7 +625,7 @@ static bool __buffer_in_use(struct vb2_queue *q, struct vb2_buffer *vb)
 		 * case anyway. If num_users() returns more than 1,
 		 * we are not the only user of the plane's memory.
 		 */
-		if (mem_priv && call_memop(vb, num_users, mem_priv) > 1)
+		if (mem_priv && call_memop(vb, num_users, mem_priv) >= 1)
 			return true;
 	}
 	return false;
-- 
1.7.9.5
