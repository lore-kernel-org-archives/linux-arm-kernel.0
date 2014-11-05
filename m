From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 5 Nov 2014 21:16:31 +0800
Subject: [PATCH V3 1/3] can: add can_is_canfd_skb() API
Message-ID: <1415193393-30023-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CAN device drivers can use it to check if the frame to send is on
CAN FD mode or normal CAN mode.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
ChangesLog:
 * v1->v2: change to skb->len == CANFD_MTU;
---
 include/linux/can/dev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6992afc..4c3919c 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -99,6 +99,11 @@ inval_skb:
 	return 1;
 }
 
+static inline int can_is_canfd_skb(struct sk_buff *skb)
+{
+	return skb->len == CANFD_MTU;
+}
+
 /* get data length from can_dlc with sanitized can_dlc */
 u8 can_dlc2len(u8 can_dlc);
 
-- 
1.9.1
