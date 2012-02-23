From: christian.riesch@omicron.at (Christian Riesch)
Date: Thu, 23 Feb 2012 09:07:58 +0100
Subject: [PATCH] davinci_mdio: Correct bitmask for clock divider value
Message-ID: <1329984478-24090-1-git-send-email-christian.riesch@omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLKDIV bitfield in the MDIO Control Register is a 16 bit field,
therefore the CLKDIV value may range from 0 to 0xffff.

Signed-off-by: Christian Riesch <christian.riesch@omicron.at>
---
 drivers/net/ethernet/ti/davinci_mdio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index af8b8fc..2757c7d 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -53,7 +53,7 @@ struct davinci_mdio_regs {
 	u32	control;
 #define CONTROL_IDLE		BIT(31)
 #define CONTROL_ENABLE		BIT(30)
-#define CONTROL_MAX_DIV		(0xff)
+#define CONTROL_MAX_DIV		(0xffff)
 
 	u32	alive;
 	u32	link;
-- 
1.7.0.4
