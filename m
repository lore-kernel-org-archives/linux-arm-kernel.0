From: nm@ti.com (Nishanth Menon)
Date: Sat, 2 Dec 2017 04:20:12 -0600
Subject: [PATCH] firmware: ti_sci: Use %zu for size_t print format
Message-ID: <20171202102012.354-1-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mbox_msg->len is of type size_t and %d is incorrect format. Instead
use %zu for handling size_t correctly.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/firmware/ti_sci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 23b12d99ddfe..5229036dcfbf 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -287,13 +287,13 @@ static void ti_sci_rx_callback(struct mbox_client *cl, void *m)
 
 	/* Is the message of valid length? */
 	if (mbox_msg->len > info->desc->max_msg_size) {
-		dev_err(dev, "Unable to handle %d xfer(max %d)\n",
+		dev_err(dev, "Unable to handle %zu xfer(max %d)\n",
 			mbox_msg->len, info->desc->max_msg_size);
 		ti_sci_dump_header_dbg(dev, hdr);
 		return;
 	}
 	if (mbox_msg->len < xfer->rx_len) {
-		dev_err(dev, "Recv xfer %d < expected %d length\n",
+		dev_err(dev, "Recv xfer %zu < expected %d length\n",
 			mbox_msg->len, xfer->rx_len);
 		ti_sci_dump_header_dbg(dev, hdr);
 		return;
-- 
2.14.1
