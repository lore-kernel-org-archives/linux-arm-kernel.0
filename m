From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Mon,  1 May 2017 14:45:01 +0200
Subject: [PATCH v5 01/20] net: stmmac: export
 stmmac_set_mac_addr/stmmac_get_mac_addr
In-Reply-To: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
References: <20170501124520.3769-1-clabbe.montjoie@gmail.com>
Message-ID: <20170501124520.3769-2-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thoses symbol will be needed for the dwmac-sun8i ethernet driver.
For letting it to be build as module, they need to be exported.

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
index 38f9430..67af0bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac_lib.c
@@ -248,6 +248,7 @@ void stmmac_set_mac_addr(void __iomem *ioaddr, u8 addr[6],
 	data = (addr[3] << 24) | (addr[2] << 16) | (addr[1] << 8) | addr[0];
 	writel(data, ioaddr + low);
 }
+EXPORT_SYMBOL_GPL(stmmac_set_mac_addr);
 
 /* Enable disable MAC RX/TX */
 void stmmac_set_mac(void __iomem *ioaddr, bool enable)
@@ -279,4 +280,4 @@ void stmmac_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,
 	addr[4] = hi_addr & 0xff;
 	addr[5] = (hi_addr >> 8) & 0xff;
 }
-
+EXPORT_SYMBOL_GPL(stmmac_get_mac_addr);
-- 
2.10.2
