From: mpa@pengutronix.de (Markus Pargmann)
Date: Sat, 15 Mar 2014 14:07:41 +0100
Subject: [PATCH v2 2/5] net: cpsw: make cpsw.h self-contained
In-Reply-To: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
References: <1394888864-11007-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1394888864-11007-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpsw.h uses the symbol MII_BUS_ID_SIZE which is defined in
<linux/phy.h>. Add the respective #include to not depend on users to
include it themselves.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/net/ethernet/ti/cpsw.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/cpsw.h b/drivers/net/ethernet/ti/cpsw.h
index 574f49d..1b71067 100644
--- a/drivers/net/ethernet/ti/cpsw.h
+++ b/drivers/net/ethernet/ti/cpsw.h
@@ -15,6 +15,7 @@
 #define __CPSW_H__
 
 #include <linux/if_ether.h>
+#include <linux/phy.h>
 
 struct cpsw_slave_data {
 	char		phy_id[MII_BUS_ID_SIZE];
-- 
1.9.0
