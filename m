From: cmc@babblebit.net (Chris Coffey)
Date: Thu, 29 Mar 2018 13:47:45 +0100
Subject: [PATCH v2] staging: mt7621-eth: Fix sparse warning in ethtool.c
In-Reply-To: <20180329095637.GA16778@kroah.com>
References: <20180329095637.GA16778@kroah.com>
Message-ID: <20180329124745.24694-1-cmc@babblebit.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes the following sparse warning:

drivers/staging/mt7621-eth/ethtool.c:213:6: warning: symbol
'mtk_set_ethtool_ops' was not declared. Should it be static?

Signed-off-by: Chris Coffey <cmc@babblebit.net>
---
Changes in v2:
 - Per GregKH's feedback (thanks!), don't add unnecessary new .h file
 dependencies. This patch version reverts those changes and fixes the
 problem directly in ethtool.c (which is that it didn't include
 ethtool.h anywhere -- mtk_set_ethtool_ops is not static).

 drivers/staging/mt7621-eth/ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/mt7621-eth/ethtool.c b/drivers/staging/mt7621-eth/ethtool.c
index 38ba0c040a..5268c5ca09 100644
--- a/drivers/staging/mt7621-eth/ethtool.c
+++ b/drivers/staging/mt7621-eth/ethtool.c
@@ -13,6 +13,7 @@
  */
 
 #include "mtk_eth_soc.h"
+#include "ethtool.h"
 
 static const char mtk_gdma_str[][ETH_GSTRING_LEN] = {
 #define _FE(x...)	# x,
-- 
2.11.0
