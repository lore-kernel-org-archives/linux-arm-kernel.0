From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Thu, 26 Jul 2018 11:36:19 -0700
Subject: [PATCH 2/7] net: phy: Fix the register offsets in Broadcom iProc mdio
 mux driver
In-Reply-To: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
References: <1532630184-29450-1-git-send-email-arun.parameswaran@broadcom.com>
Message-ID: <1532630184-29450-3-git-send-email-arun.parameswaran@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modify the register offsets in the Broadcom iProc mdio mux to start
from the top of the register address space.

Earlier the base address specified was from the middle of the block's
register space. The base address will now point to the start of the
mdio's address space. The offsets have been fixed to match this.

Fixes: 98bc865a1ec8 ("net: mdio-mux: Add MDIO mux driver for iProc SoCs")
Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>
---
 drivers/net/phy/mdio-mux-bcm-iproc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index 0831b71..dc65e95 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -22,7 +22,7 @@
 #include <linux/mdio-mux.h>
 #include <linux/delay.h>
 
-#define MDIO_PARAM_OFFSET		0x00
+#define MDIO_PARAM_OFFSET		0x23c
 #define MDIO_PARAM_MIIM_CYCLE		29
 #define MDIO_PARAM_INTERNAL_SEL		25
 #define MDIO_PARAM_BUS_ID		22
@@ -30,15 +30,15 @@
 #define MDIO_PARAM_PHY_ID		16
 #define MDIO_PARAM_PHY_DATA		0
 
-#define MDIO_READ_OFFSET		0x04
+#define MDIO_READ_OFFSET		0x240
 #define MDIO_READ_DATA_MASK		0xffff
-#define MDIO_ADDR_OFFSET		0x08
+#define MDIO_ADDR_OFFSET		0x244
 
-#define MDIO_CTRL_OFFSET		0x0C
+#define MDIO_CTRL_OFFSET		0x248
 #define MDIO_CTRL_WRITE_OP		0x1
 #define MDIO_CTRL_READ_OP		0x2
 
-#define MDIO_STAT_OFFSET		0x10
+#define MDIO_STAT_OFFSET		0x24c
 #define MDIO_STAT_DONE			1
 
 #define BUS_MAX_ADDR			32
-- 
1.9.1
