From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun,  1 Jul 2018 13:07:52 +0200
Subject: [RFC net-next 03/15] net: lora: Add protocol numbers
In-Reply-To: <20180701110804.32415-1-afaerber@suse.de>
References: <20180701110804.32415-1-afaerber@suse.de>
Message-ID: <20180701110804.32415-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Default protocol implementation will be datagram.
No other protocols are implemented yet.

Q: Would these protocol numbers be the suitable place to define LoRaWAN?

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 include/uapi/linux/lora.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/lora.h b/include/uapi/linux/lora.h
index 9368e8a84f3a..4ff00b9c3c20 100644
--- a/include/uapi/linux/lora.h
+++ b/include/uapi/linux/lora.h
@@ -10,6 +10,10 @@
 #include <linux/types.h>
 #include <linux/socket.h>
 
+/* particular protocols of the protocol family PF_LORA */
+#define LORA_PROTO_DATAGRAM	0
+#define LORA_NPROTO		1
+
 struct sockaddr_lora {
 	__kernel_sa_family_t lora_family;
 	int lora_ifindex;
-- 
2.16.4
