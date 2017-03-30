From: colin.king@canonical.com (Colin King)
Date: Thu, 30 Mar 2017 10:34:03 +0100
Subject: [PATCH] staging: bcm2835-camera: fix spelling mistake: "elementry" ->
 "elementary"
Message-ID: <20170330093403.18879-1-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in various comments and pr_debug messages

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h   | 2 +-
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c | 6 +++---
 drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
index bf3d1f3f2c53..52cdf4da1b47 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-msg.h
@@ -160,7 +160,7 @@ struct mmal_msg_port_info_get_reply {
 	s32 found;             /* unused */
 	u32 port_handle;               /**< Handle to use for this port */
 	struct mmal_port port;
-	struct mmal_es_format format; /* elementry stream format */
+	struct mmal_es_format format; /* elementary stream format */
 	union mmal_es_specific_format es; /* es type specific data */
 	u8 extradata[MMAL_FORMAT_EXTRADATA_MAX_SIZE]; /* es extra data */
 };
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
index ccb2ee547055..4360db6d4392 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
@@ -906,7 +906,7 @@ static void dump_port_info(struct vchiq_mmal_port *port)
 		 port->current_buffer.num,
 		 port->current_buffer.size, port->current_buffer.alignment);
 
-	pr_debug("elementry stream: type:%d encoding:0x%x variant:0x%x\n",
+	pr_debug("elementary stream: type:%d encoding:0x%x variant:0x%x\n",
 		 port->format.type,
 		 port->format.encoding, port->format.encoding_variant);
 
@@ -970,7 +970,7 @@ static int port_info_set(struct vchiq_mmal_instance *instance,
 
 	port_to_mmal_msg(port, &m.u.port_info_set.port);
 
-	/* elementry stream format setup */
+	/* elementary stream format setup */
 	m.u.port_info_set.format.type = port->format.type;
 	m.u.port_info_set.format.encoding = port->format.encoding;
 	m.u.port_info_set.format.encoding_variant =
@@ -1079,7 +1079,7 @@ static int port_info_get(struct vchiq_mmal_instance *instance,
 	port->format.bitrate = rmsg->u.port_info_get_reply.format.bitrate;
 	port->format.flags = rmsg->u.port_info_get_reply.format.flags;
 
-	/* elementry stream format */
+	/* elementary stream format */
 	memcpy(&port->es,
 	       &rmsg->u.port_info_get_reply.es,
 	       sizeof(union mmal_es_specific_format));
diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
index 5140b330325e..63db053532bf 100644
--- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
+++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.h
@@ -75,7 +75,7 @@ struct vchiq_mmal_port {
 
 	/* stream format */
 	struct mmal_es_format_local format;
-	/* elementry stream format */
+	/* elementary stream format */
 	union mmal_es_specific_format es;
 
 	/* data buffers to fill */
-- 
2.11.0
