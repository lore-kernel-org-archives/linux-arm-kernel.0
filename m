From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 29 Oct 2014 18:45:23 +0800
Subject: [PATCH 3/7] can: m_can: add .ndo_change_mtu function
In-Reply-To: <1414579527-31100-1-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
Message-ID: <1414579527-31100-3-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use common can_change_mtu function.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/net/can/m_can/m_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 2784423..e4ef146 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1002,6 +1002,7 @@ static const struct net_device_ops m_can_netdev_ops = {
 	.ndo_open = m_can_open,
 	.ndo_stop = m_can_close,
 	.ndo_start_xmit = m_can_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static int register_m_can_dev(struct net_device *dev)
-- 
1.9.1
