From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 22 Aug 2017 19:08:22 +0200
Subject: [PATCH net-next v2 02/10] net: mvpp2: fix the synchronization module
 bypass macro name
In-Reply-To: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
References: <20170822170830.32413-1-antoine.tenart@free-electrons.com>
Message-ID: <20170822170830.32413-3-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The macro defining the bit to toggle to bypass or not the
synchronization module is wrongly named. Writing 1 will disable bypass.
This patch s/MVPP22_CTRL4_SYNC_BYPASS/MVPP22_CTRL4_SYNC_BYPASS_DIS/.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
Tested-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2.c b/drivers/net/ethernet/marvell/mvpp2.c
index 34c679f25fec..03b7ced1082f 100644
--- a/drivers/net/ethernet/marvell/mvpp2.c
+++ b/drivers/net/ethernet/marvell/mvpp2.c
@@ -346,7 +346,7 @@
 #define MVPP22_GMAC_CTRL_4_REG			0x90
 #define     MVPP22_CTRL4_EXT_PIN_GMII_SEL	BIT(0)
 #define     MVPP22_CTRL4_DP_CLK_SEL		BIT(5)
-#define     MVPP22_CTRL4_SYNC_BYPASS		BIT(6)
+#define     MVPP22_CTRL4_SYNC_BYPASS_DIS	BIT(6)
 #define     MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE	BIT(7)
 
 /* Per-port XGMAC registers. PPv2.2 only, only for GOP port 0,
@@ -4269,7 +4269,7 @@ static void mvpp22_port_mii_set(struct mvpp2_port *port)
 	else
 		val &= ~MVPP22_CTRL4_EXT_PIN_GMII_SEL;
 	val &= ~MVPP22_CTRL4_DP_CLK_SEL;
-	val |= MVPP22_CTRL4_SYNC_BYPASS;
+	val |= MVPP22_CTRL4_SYNC_BYPASS_DIS;
 	val |= MVPP22_CTRL4_QSGMII_BYPASS_ACTIVE;
 	writel(val, port->base + MVPP22_GMAC_CTRL_4_REG);
 }
-- 
2.13.5
