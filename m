From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Mon,  6 May 2013 17:49:49 +0530
Subject: [PATCH V2 1/3] virtio: console: Add emergency writeonly register to
 config space
In-Reply-To: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
References: <1367842791-30285-1-git-send-email-pranavkumar@linaro.org>
Message-ID: <1367842791-30285-2-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds an emerg_wr register (writeonly) in config space
of virtio console device which can be used for debugging.

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 include/uapi/linux/virtio_console.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index ee13ab6..3fd0dce 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -38,6 +38,7 @@
 /* Feature bits */
 #define VIRTIO_CONSOLE_F_SIZE	0	/* Does host provide console size? */
 #define VIRTIO_CONSOLE_F_MULTIPORT 1	/* Does host provide multiple ports? */
+#define VIRTIO_CONSOLE_F_EMERG_WRITE 2 /* Does host support emergency write? */
 
 #define VIRTIO_CONSOLE_BAD_ID		(~(u32)0)
 
@@ -48,6 +49,8 @@ struct virtio_console_config {
 	__u16 rows;
 	/* max. number of ports this device can hold */
 	__u32 max_nr_ports;
+	/* emergency write register */
+	__u32 emerg_wr;
 } __attribute__((packed));
 
 /*
-- 
1.7.9.5
