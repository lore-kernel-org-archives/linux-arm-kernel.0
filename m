From: cmc@babblebit.net (Chris Coffey)
Date: Wed, 28 Mar 2018 22:18:48 +0100
Subject: [PATCH] staging: mt7621-eth: Fix sparse warning in ethtool.c
Message-ID: <20180328211848.11085-1-cmc@babblebit.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the local ethtool.h header file in mtk_eth_soc.h so
implementation files have centralized access to it.

This fixes the following sparse warning:

drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
'mtk_set_ethtool_ops' was not declared. Should it be static?

Signed-off-by: Chris Coffey <cmc@babblebit.net>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 1 -
 drivers/staging/mt7621-eth/mtk_eth_soc.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index cbc7339843..0574e71573 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -35,7 +35,6 @@
 
 #include "mtk_eth_soc.h"
 #include "mdio.h"
-#include "ethtool.h"
 
 #define	MAX_RX_LENGTH		1536
 #define MTK_RX_ETH_HLEN		(VLAN_ETH_HLEN + VLAN_HLEN + ETH_FCS_LEN)
diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.h b/drivers/staging/mt7621-eth/mtk_eth_soc.h
index 443f88d8af..01deeddfdd 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.h
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.h
@@ -23,6 +23,7 @@
 #include <linux/ethtool.h>
 #include <linux/version.h>
 #include <linux/atomic.h>
+#include "ethtool.h"
 
 /* these registers have different offsets depending on the SoC. we use a lookup
  * table for these
-- 
2.11.0
