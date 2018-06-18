From: radhey.shyam.pandey@xilinx.com (Radhey Shyam Pandey)
Date: Mon, 18 Jun 2018 17:20:10 +0530
Subject: [PATCH 5/5] net: emaclite: Remove unnecessary spaces
In-Reply-To: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <1529322610-27215-6-git-send-email-radhey.shyam.pandey@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes below checkpatch checks-

CHECK: spaces preferred around that '*' (ctx:VxV)
CHECK: No space is necessary after a cast

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index e8bb7b3..f62e4b6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -95,11 +95,11 @@
 
 
 
-#define TX_TIMEOUT		(60*HZ)		/* Tx timeout is 60 seconds. */
+#define TX_TIMEOUT		(60 * HZ)	/* Tx timeout is 60 seconds. */
 #define ALIGNMENT		4
 
 /* BUFFER_ALIGN(adr) calculates the number of bytes to the next alignment. */
-#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32) adr)) % ALIGNMENT)
+#define BUFFER_ALIGN(adr) ((ALIGNMENT - ((u32)adr)) % ALIGNMENT)
 
 #ifdef __BIG_ENDIAN
 #define xemaclite_readl		ioread32be
@@ -239,8 +239,8 @@ static void xemaclite_aligned_write(void *src_ptr, u32 *dest_ptr,
 
 		/* Set up to output the remaining data */
 		align_buffer = 0;
-		to_u8_ptr = (u8 *) &align_buffer;
-		from_u8_ptr = (u8 *) from_u16_ptr;
+		to_u8_ptr = (u8 *)&align_buffer;
+		from_u8_ptr = (u8 *)from_u16_ptr;
 
 		/* Output the remaining data */
 		for (; length > 0; length--)
@@ -273,7 +273,7 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 	u32 align_buffer;
 
 	from_u32_ptr = src_ptr;
-	to_u16_ptr = (u16 *) dest_ptr;
+	to_u16_ptr = (u16 *)dest_ptr;
 
 	for (; length > 3; length -= 4) {
 		/* Copy each word into the temporary buffer */
@@ -289,9 +289,9 @@ static void xemaclite_aligned_read(u32 *src_ptr, u8 *dest_ptr,
 		u8 *to_u8_ptr, *from_u8_ptr;
 
 		/* Set up to read the remaining data */
-		to_u8_ptr = (u8 *) to_u16_ptr;
+		to_u8_ptr = (u8 *)to_u16_ptr;
 		align_buffer = *from_u32_ptr++;
-		from_u8_ptr = (u8 *) &align_buffer;
+		from_u8_ptr = (u8 *)&align_buffer;
 
 		/* Read the remaining data */
 		for (; length > 0; length--)
@@ -351,7 +351,7 @@ static int xemaclite_send_data(struct net_local *drvdata, u8 *data,
 		return -1; /* Buffer was full, return failure */
 
 	/* Write the frame to the buffer */
-	xemaclite_aligned_write(data, (u32 __force *) addr, byte_count);
+	xemaclite_aligned_write(data, (u32 __force *)addr, byte_count);
 
 	xemaclite_writel((byte_count & XEL_TPLR_LENGTH_MASK),
 			 addr + XEL_TPLR_OFFSET);
@@ -448,7 +448,7 @@ static u16 xemaclite_recv_data(struct net_local *drvdata, u8 *data, int maxlen)
 		length = maxlen;
 
 	/* Read from the EmacLite device */
-	xemaclite_aligned_read((u32 __force *) (addr + XEL_RXBUFF_OFFSET),
+	xemaclite_aligned_read((u32 __force *)(addr + XEL_RXBUFF_OFFSET),
 				data, length);
 
 	/* Acknowledge the frame */
@@ -479,7 +479,7 @@ static void xemaclite_update_address(struct net_local *drvdata,
 	/* Determine the expected Tx buffer address */
 	addr = drvdata->base_addr + drvdata->next_tx_buf_to_use;
 
-	xemaclite_aligned_write(address_ptr, (u32 __force *) addr, ETH_ALEN);
+	xemaclite_aligned_write(address_ptr, (u32 __force *)addr, ETH_ALEN);
 
 	xemaclite_writel(ETH_ALEN, addr + XEL_TPLR_OFFSET);
 
@@ -574,7 +574,7 @@ static void xemaclite_tx_handler(struct net_device *dev)
 	dev->stats.tx_packets++;
 	if (lp->deferred_skb) {
 		if (xemaclite_send_data(lp,
-					(u8 *) lp->deferred_skb->data,
+					(u8 *)lp->deferred_skb->data,
 					lp->deferred_skb->len) != 0)
 			return;
 		dev->stats.tx_bytes += lp->deferred_skb->len;
@@ -619,7 +619,7 @@ static void xemaclite_rx_handler(struct net_device *dev)
 
 	skb_reserve(skb, 2);
 
-	len = xemaclite_recv_data(lp, (u8 *) skb->data, len);
+	len = xemaclite_recv_data(lp, (u8 *)skb->data, len);
 
 	if (!len) {
 		dev->stats.rx_errors++;
@@ -1032,7 +1032,7 @@ static int xemaclite_send(struct sk_buff *orig_skb, struct net_device *dev)
 	new_skb = orig_skb;
 
 	spin_lock_irqsave(&lp->reset_lock, flags);
-	if (xemaclite_send_data(lp, (u8 *) new_skb->data, len) != 0) {
+	if (xemaclite_send_data(lp, (u8 *)new_skb->data, len) != 0) {
 		/* If the Emaclite Tx buffer is busy, stop the Tx queue and
 		 * defer the skb for transmission during the ISR, after the
 		 * current transmission is complete
-- 
2.7.4
