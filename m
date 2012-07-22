From: richardcochran@gmail.com (Richard Cochran)
Date: Sun, 22 Jul 2012 19:11:06 +0200
Subject: [PATCH net-next 4/4] forcedeth: advertise transmit time stamping
In-Reply-To: <cover.1342976654.git.richardcochran@gmail.com>
References: <cover.1342976654.git.richardcochran@gmail.com>
Message-ID: <d95c3b5bf30e3a7d056ad7f9fb774bbf572dc217.1342976654.git.richardcochran@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver now offers software transmit time stamping, so it should
advertise that fact via ethtool. Compile tested only.

Signed-off-by: Richard Cochran <richardcochran@gmail.com>

Cc: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/nvidia/forcedeth.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/nvidia/forcedeth.c b/drivers/net/ethernet/nvidia/forcedeth.c
index 67edc2e..f45def0 100644
--- a/drivers/net/ethernet/nvidia/forcedeth.c
+++ b/drivers/net/ethernet/nvidia/forcedeth.c
@@ -5182,6 +5182,7 @@ static const struct ethtool_ops ops = {
 	.get_ethtool_stats = nv_get_ethtool_stats,
 	.get_sset_count = nv_get_sset_count,
 	.self_test = nv_self_test,
+	.get_ts_info = ethtool_op_get_ts_info,
 };
 
 /* The mgmt unit and driver use a semaphore to access the phy during init */
-- 
1.7.2.5
