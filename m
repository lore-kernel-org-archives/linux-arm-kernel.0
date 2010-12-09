From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu,  9 Dec 2010 14:15:14 +0100
Subject: [RFC PATCH] scatterlist: Initialize the dma_address field with
	invalid dma address
Message-ID: <1291900514-7290-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Initialize the the dma_address field so that it will be possible to test
its value while using scatterlists. This field will be compatible with
testing by dma_mapping_error().

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi,

I wonder why this field is not initialized in the scatterlist: is it
intentional and is there a different way to check if dma_address is a
valid field?

 lib/scatterlist.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 4ceb05d..ca69409 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -85,6 +85,7 @@ EXPORT_SYMBOL(sg_last);
 void sg_init_table(struct scatterlist *sgl, unsigned int nents)
 {
 	memset(sgl, 0, sizeof(*sgl) * nents);
+	sgl->dma_address = (~(dma_addr_t)0);
 #ifdef CONFIG_DEBUG_SG
 	{
 		unsigned int i;
-- 
1.7.3
