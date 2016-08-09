From: romain.perier@free-electrons.com (Romain Perier)
Date: Tue,  9 Aug 2016 11:03:13 +0200
Subject: [PATCH 0/7] Various fixes for the cesa driver
Message-ID: <1470733400-23621-1-git-send-email-romain.perier@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches series contains various fixes for ahash requests, dma
operations and an important fixe in the core of the driver (cesa.c). It
also includes some code cleanups.

Romain Perier (3):
  crypto: marvell - Update transformation context for each dequeued req
  crypto: marvell - Don't overwrite default creq->state during
    initialization
  crypto: marvell - Don't hardcode block size in mv_cesa_ahash_cache_req

Thomas Petazzoni (4):
  crypto: marvell: be explicit about destination in mv_cesa_dma_add_op()
  crypto: marvell: remove unused parameter in
    mv_cesa_ahash_dma_add_cache()
  crypto: marvell: turn mv_cesa_ahash_init() into a function returning
    void
  crypto: marvell: make mv_cesa_ahash_cache_req() return bool

 drivers/crypto/marvell/cesa.c |  1 +
 drivers/crypto/marvell/hash.c | 44 +++++++++++++++++++++----------------------
 drivers/crypto/marvell/tdma.c |  1 +
 3 files changed, 23 insertions(+), 23 deletions(-)

-- 
2.8.1
