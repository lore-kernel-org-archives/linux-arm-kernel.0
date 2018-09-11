From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 11 Sep 2018 13:20:07 +0800
Subject: [RFC PATCH] crypto: dpaa2_caam_iova_to_virt() can be static
In-Reply-To: <20180910171550.5659-8-horia.geanta@nxp.com>
References: <20180910171550.5659-8-horia.geanta@nxp.com>
Message-ID: <20180911052007.GA10279@ivb42>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: 10c08052347f ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 caamalg_qi2.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index e883386..af8d890 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -80,8 +80,8 @@ struct caam_ctx {
 	unsigned int authsize;
 };
 
-void *dpaa2_caam_iova_to_virt(struct dpaa2_caam_priv *priv,
-			      dma_addr_t iova_addr)
+static void *dpaa2_caam_iova_to_virt(struct dpaa2_caam_priv *priv,
+				     dma_addr_t iova_addr)
 {
 	phys_addr_t phys_addr;
 
