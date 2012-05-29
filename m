From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:38:38 +0100
Subject: [RFC 10/34] dmaengine: PL08x: constify channel names and bus_id
 strings
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIsw-0006zN-Uv@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c   |    2 +-
 include/linux/amba/pl08x.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index d3ba147..0ba1426 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -233,7 +233,7 @@ struct pl08x_dma_chan {
 	struct pl08x_phy_chan *phychan;
 	int phychan_hold;
 	struct tasklet_struct tasklet;
-	char *name;
+	const char *name;
 	const struct pl08x_channel_data *cd;
 	dma_addr_t src_addr;
 	dma_addr_t dst_addr;
diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 48d02bf..158ce26 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -58,7 +58,7 @@ enum {
  * these buses (use PL08X_AHB1 | PL08X_AHB2).
  */
 struct pl08x_channel_data {
-	char *bus_id;
+	const char *bus_id;
 	int min_signal;
 	int max_signal;
 	u32 muxval;
-- 
1.7.4.4
