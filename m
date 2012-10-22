From: balbi@ti.com (Felipe Balbi)
Date: Mon, 22 Oct 2012 12:46:57 +0300
Subject: [PATCH 7/8] i2c: add 'transferred' field to struct i2c_msg
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Message-ID: <1350899218-13624-8-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shubhrajyoti D <shubhrajyoti@ti.com>

In case of a NACK, it's wise to tell our clients
drivers about how many bytes were actually transferred.

Support this by adding an extra field to the struct
i2c_msg which gets incremented the amount of bytes
actually transferred.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/uapi/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/i2c.h b/include/uapi/linux/i2c.h
index 0e949cb..4b35c9b 100644
--- a/include/uapi/linux/i2c.h
+++ b/include/uapi/linux/i2c.h
@@ -77,6 +77,7 @@ struct i2c_msg {
 #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
 	__u16 len;		/* msg length				*/
+	__u16 transferred;	/* actual bytes transferred             */
 	__u8 *buf;		/* pointer to msg data			*/
 };
 
-- 
1.8.0.rc0
