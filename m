From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  9 Mar 2018 15:27:20 +0900
Subject: [PATCH] net: ethernet: ave: enable Rx drop interrupt
Message-ID: <1520576840-17566-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables AVE_GI_RXDROP interrupt factor. This factor indicates
depletion of Rx descriptors and the handler counts the number
of dropped packets.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/socionext/sni_ave.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/socionext/sni_ave.c b/drivers/net/ethernet/socionext/sni_ave.c
index b247707..043eb55 100644
--- a/drivers/net/ethernet/socionext/sni_ave.c
+++ b/drivers/net/ethernet/socionext/sni_ave.c
@@ -1349,7 +1349,7 @@ static int ave_open(struct net_device *ndev)
 	val |= AVE_IIRQC_EN0 | (AVE_INTM_COUNT << 16);
 	writel(val, priv->base + AVE_IIRQC);
 
-	val = AVE_GI_RXIINT | AVE_GI_RXOVF | AVE_GI_TX;
+	val = AVE_GI_RXIINT | AVE_GI_RXOVF | AVE_GI_TX | AVE_GI_RXDROP;
 	ave_irq_restore(ndev, val);
 
 	napi_enable(&priv->napi_rx);
-- 
2.7.4
