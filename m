From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 29 Oct 2014 18:45:22 +0800
Subject: [PATCH 2/7] can: m_can: fix the incorrect error messages
In-Reply-To: <1414579527-31100-1-git-send-email-b29396@freescale.com>
References: <1414579527-31100-1-git-send-email-b29396@freescale.com>
Message-ID: <1414579527-31100-2-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix a few error messages.

Signed-off-by: Dong Aisheng <b29396@freescale.com>
---
 drivers/net/can/m_can/m_can.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 8692848..2784423 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -606,14 +606,14 @@ static int m_can_handle_state_errors(struct net_device *dev, u32 psr)
 
 	if ((psr & PSR_EP) &&
 	    (priv->can.state != CAN_STATE_ERROR_PASSIVE)) {
-		netdev_dbg(dev, "entered error warning state\n");
+		netdev_dbg(dev, "entered error passive state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_ERROR_PASSIVE);
 	}
 
 	if ((psr & PSR_BO) &&
 	    (priv->can.state != CAN_STATE_BUS_OFF)) {
-		netdev_dbg(dev, "entered error warning state\n");
+		netdev_dbg(dev, "entered error bus off state\n");
 		work_done += m_can_handle_state_change(dev,
 						       CAN_STATE_BUS_OFF);
 	}
@@ -625,7 +625,7 @@ static void m_can_handle_other_err(struct net_device *dev, u32 irqstatus)
 {
 	if (irqstatus & IR_WDI)
 		netdev_err(dev, "Message RAM Watchdog event due to missing READY\n");
-	if (irqstatus & IR_BEU)
+	if (irqstatus & IR_ELO)
 		netdev_err(dev, "Error Logging Overflow\n");
 	if (irqstatus & IR_BEU)
 		netdev_err(dev, "Bit Error Uncorrected\n");
-- 
1.9.1
