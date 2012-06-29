From: shubhrajyoti@ti.com (Shubhrajyoti D)
Date: Fri, 29 Jun 2012 16:35:25 +0530
Subject: [RFC PATCH 1/3] i2c: add 'actual' field to struct i2c_msg
In-Reply-To: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <1340967927-27354-2-git-send-email-shubhrajyoti@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In case of a NACK, it's wise to tell our clients
drivers about how many bytes were actually transferred.

Support this by adding an extra field to the struct
i2c_msg which gets incremented the amount of bytes
actually transferred.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 include/linux/i2c.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index ddfa041..0cb6b83 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -547,6 +547,7 @@ struct i2c_msg {
 #define I2C_M_NO_RD_ACK		0x0800	/* if I2C_FUNC_PROTOCOL_MANGLING */
 #define I2C_M_RECV_LEN		0x0400	/* length will be first received byte */
 	__u16 len;		/* msg length				*/
+	__u16 actual;		/* actual bytes transferred             */
 	__u8 *buf;		/* pointer to msg data			*/
 };
 
-- 
1.7.5.4
