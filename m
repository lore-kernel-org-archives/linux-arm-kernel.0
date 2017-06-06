From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:27 -0500
Subject: [PATCH 04/18] staging: fsl-dpaa2/eth: Remove incorrect error path
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-5-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not having Rx hashing distribution enabled for an
interface is a valid configuration and shouldn't be
treated as an error.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index a9e245df2488..f63054e071b3 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1969,8 +1969,8 @@ static int dpaa2_eth_set_hash(struct net_device *net_dev, u64 flags)
 	int err = 0;
 
 	if (!dpaa2_eth_hash_enabled(priv)) {
-		dev_err(dev, "Hashing support is not enabled\n");
-		return -EOPNOTSUPP;
+		dev_dbg(dev, "Hashing support is not enabled\n");
+		return 0;
 	}
 
 	memset(&cls_cfg, 0, sizeof(cls_cfg));
-- 
2.11.0
