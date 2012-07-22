From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 22 Jul 2012 19:11:04 +0200
Subject: [PATCH net-next 2/4] e1000: advertise transmit time stamping
In-Reply-To: <cover.1342976654.git.richardcochran@gmail.com>
References: <cover.1342976654.git.richardcochran@gmail.com>
Message-ID: <33885adb6b0e97e6b21fd1903fb6ede3ed7b50ab.1342976654.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver now offers software transmit time stamping, so it should
advertise that fact via ethtool. Compile tested only.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>

Cc: Willem de Bruijn <willemb@google.com>
Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc: e1000-devel at lists.sourceforge.net
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 3103f0b..736a7d9 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1851,6 +1851,7 @@ static const struct ethtool_ops e1000_ethtool_ops = {
 	.get_sset_count         = e1000_get_sset_count,
 	.get_coalesce           = e1000_get_coalesce,
 	.set_coalesce           = e1000_set_coalesce,
+	.get_ts_info		= ethtool_op_get_ts_info,
 };
 
 void e1000_set_ethtool_ops(struct net_device *netdev)
-- 
1.7.2.5
