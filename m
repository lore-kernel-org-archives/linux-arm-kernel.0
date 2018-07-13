From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 13 Jul 2018 18:18:37 +0200
Subject: [PATCH net-next v2 3/7] net: mvneta: increase number of buffers in RX
 and TX queue
In-Reply-To: <20180713161841.11202-1-gregory.clement@bootlin.com>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
Message-ID: <20180713161841.11202-4-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yelena Krivosheev <yelena@marvell.com>

The initial values were too small leading to poor performance when using
the software buffer management.

Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
[gregory: extract from a larger patch]
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/net/ethernet/marvell/mvneta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
index f4e3943a745d..c22df28b07c8 100644
--- a/drivers/net/ethernet/marvell/mvneta.c
+++ b/drivers/net/ethernet/marvell/mvneta.c
@@ -295,10 +295,10 @@
 #define MVNETA_RSS_LU_TABLE_SIZE	1
 
 /* Max number of Rx descriptors */
-#define MVNETA_MAX_RXD 128
+#define MVNETA_MAX_RXD 512
 
 /* Max number of Tx descriptors */
-#define MVNETA_MAX_TXD 532
+#define MVNETA_MAX_TXD 1024
 
 /* Max number of allowed TCP segments for software TSO */
 #define MVNETA_MAX_TSO_SEGS 100
-- 
2.18.0
