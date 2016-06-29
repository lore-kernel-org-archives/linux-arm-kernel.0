From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 29 Jun 2016 19:44:51 +0200
Subject: [PATCH] dmaengine: at_xdmac: fix debug string
Message-ID: <1467222291-13045-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mbr_ds is an integer, don't use %pad to print it.

Fixes: commit 268914f4e7a0 ("dmaengine: at_xdmac: use %pad format string for dma_addr_t")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/dma/at_xdmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 8e304b1befc5..e4c5522f9dcd 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -1195,8 +1195,8 @@ static struct at_xdmac_desc *at_xdmac_memset_create_desc(struct dma_chan *chan,
 	desc->lld.mbr_cfg = chan_cc;
 
 	dev_dbg(chan2dev(chan),
-		"%s: lld: mbr_da=%pad, mbr_ds=%pad, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
-		__func__, &desc->lld.mbr_da, &desc->lld.mbr_ds, desc->lld.mbr_ubc,
+		"%s: lld: mbr_da=%pad, mbr_ds=0x%08x, mbr_ubc=0x%08x, mbr_cfg=0x%08x\n",
+		__func__, &desc->lld.mbr_da, desc->lld.mbr_ds, desc->lld.mbr_ubc,
 		desc->lld.mbr_cfg);
 
 	return desc;
-- 
2.8.1
