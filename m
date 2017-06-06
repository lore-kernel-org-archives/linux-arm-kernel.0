From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue,  6 Jun 2017 15:36:15 +0200
Subject: [PATCH] net: mvpp2: do not bypass the mvpp22_port_mii_set function
Message-ID: <20170606133615.20747-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvpp22_port_mii_set() function was added by 2697582144dd, but the
function directly returns without doing anything. This return was used
when debugging and wasn't removed before sending the patch. Fix this.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 9b875d776b29..70bca2a6fb02 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -4186,8 +4186,6 @@ static void mvpp22_port_mii_set(struct mvpp2_port *port)
 {
 	u32 val;
 
-	return;
-
 	/* Only GOP port 0 has an XLG MAC */
 	if (port->gop_id == 0) {
 		val = readl(port->base + MVPP22_XLG_CTRL3_REG);
-- 
2.9.4
