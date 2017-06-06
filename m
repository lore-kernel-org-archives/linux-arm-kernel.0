From: ruxandra.radulescu@nxp.com (Ioana Radulescu)
Date: Tue, 6 Jun 2017 10:00:24 -0500
Subject: [PATCH 01/18] staging: fsl-dpaa2/eth: Add "static" keyword where
 needed
In-Reply-To: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
References: <20170606150041.10955-1-ruxandra.radulescu@nxp.com>
Message-ID: <20170606150041.10955-2-ruxandra.radulescu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make a couple of locally used functions and structures static.
Issue found through static analysis tool.

Signed-off-by: Ioana Radulescu <ruxandra.radulescu@nxp.com>
---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c     | 6 +++---
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h     | 2 --
 drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c | 4 ++--
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
index 49c435bad706..8ff8951f31b9 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.c
@@ -1162,8 +1162,8 @@ static int dpaa2_eth_set_addr(struct net_device *net_dev, void *addr)
 /** Fill in counters maintained by the GPP driver. These may be different from
  * the hardware counters obtained by ethtool.
  */
-void dpaa2_eth_get_stats(struct net_device *net_dev,
-			 struct rtnl_link_stats64 *stats)
+static void dpaa2_eth_get_stats(struct net_device *net_dev,
+				struct rtnl_link_stats64 *stats)
 {
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
 	struct rtnl_link_stats64 *percpu_stats;
@@ -1958,7 +1958,7 @@ static const struct dpaa2_eth_hash_fields hash_fields[] = {
 /* Set RX hash options
  * flags is a combination of RXH_ bits
  */
-int dpaa2_eth_set_hash(struct net_device *net_dev, u64 flags)
+static int dpaa2_eth_set_hash(struct net_device *net_dev, u64 flags)
 {
 	struct device *dev = net_dev->dev.parent;
 	struct dpaa2_eth_priv *priv = netdev_priv(net_dev);
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
index 55b47623008c..539da71470d9 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-eth.h
@@ -339,8 +339,6 @@ struct dpaa2_eth_priv {
 extern const struct ethtool_ops dpaa2_ethtool_ops;
 extern const char dpaa2_eth_drv_version[];
 
-int dpaa2_eth_set_hash(struct net_device *net_dev, u64 flags);
-
 static int dpaa2_eth_queue_count(struct dpaa2_eth_priv *priv)
 {
 	return priv->dpni_attrs.num_queues;
diff --git a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
index dd0cffa908ef..89888b6115bf 100644
--- a/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
+++ b/drivers/staging/fsl-dpaa2/ethernet/dpaa2-ethtool.c
@@ -34,7 +34,7 @@
 #include "dpaa2-eth.h"
 
 /* To be kept in sync with DPNI statistics */
-char dpaa2_ethtool_stats[][ETH_GSTRING_LEN] = {
+static char dpaa2_ethtool_stats[][ETH_GSTRING_LEN] = {
 	"rx frames",
 	"rx bytes",
 	"rx mcast frames",
@@ -56,7 +56,7 @@ char dpaa2_ethtool_stats[][ETH_GSTRING_LEN] = {
 
 #define DPAA2_ETH_NUM_STATS	ARRAY_SIZE(dpaa2_ethtool_stats)
 
-char dpaa2_ethtool_extras[][ETH_GSTRING_LEN] = {
+static char dpaa2_ethtool_extras[][ETH_GSTRING_LEN] = {
 	/* per-cpu stats */
 	"tx conf frames",
 	"tx conf bytes",
-- 
2.11.0
