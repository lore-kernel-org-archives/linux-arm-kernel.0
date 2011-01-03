From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 22:35:08 +0000
Subject: [PATCH 15/48] ARM: PL08x: constify vendor data pointers
In-Reply-To: <20110103222943.GB4572@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
Message-ID: <E1PZszc-0001Ot-Fz@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should never modify the vendor data structure so make it const.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 74b3591..707fa08 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -132,7 +132,7 @@ struct pl08x_driver_data {
 	struct dma_device memcpy;
 	void __iomem *base;
 	struct amba_device *adev;
-	struct vendor_data *vd;
+	const struct vendor_data *vd;
 	struct pl08x_platform_data *pd;
 	struct pl08x_phy_chan *phy_chans;
 	struct dma_pool *pool;
@@ -1891,7 +1891,7 @@ static inline void init_pl08x_debugfs(struct pl08x_driver_data *pl08x)
 static int pl08x_probe(struct amba_device *adev, struct amba_id *id)
 {
 	struct pl08x_driver_data *pl08x;
-	struct vendor_data *vd = id->data;
+	const struct vendor_data *vd = id->data;
 	int ret = 0;
 	int i;
 
-- 
1.6.2.5
