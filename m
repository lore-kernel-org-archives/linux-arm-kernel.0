From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 22 Jul 2012 19:11:05 +0200
Subject: [PATCH net-next 3/4] e1000e: advertise transmit time stamping
In-Reply-To: <cover.1342976654.git.richardcochran@gmail.com>
References: <cover.1342976654.git.richardcochran@gmail.com>
Message-ID: <e0e31f0229b5bfda1684122498b4d6fb3195cf26.1342976654.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver now offers software transmit time stamping, so it should
advertise that fact via ethtool. Compile tested only.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>

Cc: Willem de Bruijn <willemb@google.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: e1000-devel at lists.sourceforge.net
---
 drivers/net/ethernet/intel/e1000e/ethtool.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 105d554..0349e24 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -2061,6 +2061,7 @@ static const struct ethtool_ops e1000_ethtool_ops = {
 	.get_coalesce		= e1000_get_coalesce,
 	.set_coalesce		= e1000_set_coalesce,
 	.get_rxnfc		= e1000_get_rxnfc,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 void e1000e_set_ethtool_ops(struct net_device *netdev)
-- 
1.7.2.5
