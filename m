From: nm@ti.com (Nishanth Menon)
Date: Mon, 16 Jul 2018 13:06:02 -0500
Subject: [PATCH V2 1/6] mailbox: ti-msgmgr: Get rid of unused structure members
In-Reply-To: <20180716180607.16526-1-nm@ti.com>
References: <20180716180607.16526-1-nm@ti.com>
Message-ID: <20180716180607.16526-2-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Though q_proxies and q_slices do describe the hardware configuration,
they are not necessary for operation given that the values are
always default. Hence drop the same.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Changes since V1: None
V1: https://patchwork.kernel.org/patch/10475339/
RFC: https://patchwork.kernel.org/patch/10447665/

 drivers/mailbox/ti-msgmgr.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 5d04738c3c8a..5fe6ce200264 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -42,8 +42,6 @@ struct ti_msgmgr_valid_queue_desc {
  * @queue_count:	Number of Queues
  * @max_message_size:	Message size in bytes
  * @max_messages:	Number of messages
- * @q_slices:		Number of queue engines
- * @q_proxies:		Number of queue proxies per page
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
  * @tx_polled:		Do I need to use polled mechanism for tx
@@ -58,8 +56,6 @@ struct ti_msgmgr_desc {
 	u8 queue_count;
 	u8 max_message_size;
 	u8 max_messages;
-	u8 q_slices;
-	u8 q_proxies;
 	u8 data_first_reg;
 	u8 data_last_reg;
 	bool tx_polled;
@@ -494,8 +490,6 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.queue_count = 64,
 	.max_message_size = 64,
 	.max_messages = 128,
-	.q_slices = 1,
-	.q_proxies = 1,
 	.data_first_reg = 16,
 	.data_last_reg = 31,
 	.tx_polled = false,
-- 
2.15.1
