From: sky@genki.is (Genki Sky)
Date: Mon, 04 Dec 2017 21:39:07 -0500
Subject: [PATCH v2 3/3] staging: vc04_services: Use __func__
In-Reply-To: <cover.1512441073.git.sky@genki.is>
References: <20171204105235.2nhmalxsd4uslesi@mwanda>
 <cover.1512441073.git.sky@genki.is>
Message-ID: <69dc7f6f0078bd381aed97981ed3a7c6f0abef0c.1512441073.git.sky@genki.is>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Genki Sky <sky@genki.is>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index 5ddea4f54bf7..6c4d8b4c7cd9 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -618,8 +618,8 @@ static void buffer_to_host_cb(struct vchiq_mmal_instance *instance,
 	struct mmal_msg_context *msg_context;
 	u32 handle;
 
-	pr_debug("buffer_to_host_cb: instance:%p msg:%p msg_len:%d\n",
-		 instance, msg, msg_len);
+	pr_debug("%s: instance:%p msg:%p msg_len:%d\n",
+		 __func__, instance, msg, msg_len);
 
 	if (msg->u.buffer_from_host.drvbuf.magic == MMAL_MAGIC) {
 		handle = msg->u.buffer_from_host.drvbuf.client_context;
-- 
2.15.1
