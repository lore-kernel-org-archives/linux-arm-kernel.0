From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jul 2011 17:13:07 +0100
Subject: [PATCH 6/9] DMA: PL08x: constify plchan->cd and plat->slave_channels
In-Reply-To: <20110721160800.GR26574@n2100.arm.linux.org.uk>
References: <20110721160800.GR26574@n2100.arm.linux.org.uk>
Message-ID: <E1Qjvs3-0003MX-I5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We no longer write to the channel data structure, so we can make it
const throughout the driver.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 include/linux/amba/pl08x.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/amba/pl08x.h b/include/linux/amba/pl08x.h
index 47cfe31..e6e28f3 100644
--- a/include/linux/amba/pl08x.h
+++ b/include/linux/amba/pl08x.h
@@ -172,7 +172,7 @@ struct pl08x_dma_chan {
 	int phychan_hold;
 	struct tasklet_struct tasklet;
 	char *name;
-	struct pl08x_channel_data *cd;
+	const struct pl08x_channel_data *cd;
 	dma_addr_t src_addr;
 	dma_addr_t dst_addr;
 	u32 src_cctl;
@@ -205,7 +205,7 @@ struct pl08x_dma_chan {
  * @mem_buses: buses which memory can be accessed from: PL08X_AHB1 | PL08X_AHB2
  */
 struct pl08x_platform_data {
-	struct pl08x_channel_data *slave_channels;
+	const struct pl08x_channel_data *slave_channels;
 	unsigned int num_slave_channels;
 	struct pl08x_channel_data memcpy_channel;
 	int (*get_signal)(struct pl08x_dma_chan *);
-- 
1.7.4.4
