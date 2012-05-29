From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 29 May 2012 10:37:18 +0100
Subject: [RFC 06/34] dmaengine: PL08x: remove redundant spinlock
In-Reply-To: <20120529093015.GF12217@n2100.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
Message-ID: <E1SZIre-0006z6-GS@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pl08x_driver_data spinlock is only ever initialized.  Nothing else
uses it.  Let's get rid of it.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/amba-pl08x.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a5bb7f8..219769f 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -142,7 +142,6 @@ struct pl08x_driver_data {
 	int pool_ctr;
 	u8 lli_buses;
 	u8 mem_buses;
-	spinlock_t lock;
 };
 
 /*
@@ -1888,8 +1887,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 		goto out_no_lli_pool;
 	}
 
-	spin_lock_init(&pl08x->lock);
-
 	pl08x->base = ioremap(adev->res.start, resource_size(&adev->res));
 	if (!pl08x->base) {
 		ret = -ENOMEM;
-- 
1.7.4.4
