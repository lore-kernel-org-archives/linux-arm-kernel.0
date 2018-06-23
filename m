From: joe@perches.com (Joe Perches)
Date: Sat, 23 Jun 2018 10:27:58 -0700
Subject: [PATCH] staging: Convert random_ether_addr to eth_random_addr
Message-ID: <d5ed83275b7e9ed8bacbcc8a45fcb5ac419c272f.1529774856.git.joe@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

random_ether_addr is a #define for eth_random_addr which is
generally preferred in kernel code by ~3:1

Convert the uses of random_ether_addr to enable removing the #define

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c               | 2 +-
 drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 2c7a2e666bfb..e1696b06870e 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -1822,7 +1822,7 @@ static int __init mtk_init(struct net_device *dev)
 
 	/* If the mac address is invalid, use random mac address  */
 	if (!is_valid_ether_addr(dev->dev_addr)) {
-		random_ether_addr(dev->dev_addr);
+		eth_random_addr(dev->dev_addr);
 		dev_err(eth->dev, "generated random MAC address %pM\n",
 			dev->dev_addr);
 		dev->addr_assign_type = NET_ADDR_RANDOM;
diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
index 21874e78d8a1..9d9a9e102bb8 100644
--- a/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
+++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_softmac.c
@@ -2382,7 +2382,7 @@ static void ieee80211_start_ibss_wq(struct work_struct *work)
 	if (ieee->state == IEEE80211_NOLINK) {
 		printk("creating new IBSS cell\n");
 		if(!ieee->wap_set)
-			random_ether_addr(ieee->current_network.bssid);
+			eth_random_addr(ieee->current_network.bssid);
 
 		if(ieee->modulation & IEEE80211_CCK_MODULATION){
 
-- 
2.15.0
