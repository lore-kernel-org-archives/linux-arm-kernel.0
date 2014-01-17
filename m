From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 17 Jan 2014 09:22:27 +0900
Subject: [PATCH v7 net-next 1/4] sh_eth: Use bool as return type of
 sh_eth_is_gether()
In-Reply-To: <1389918150-19058-1-git-send-email-horms+renesas@verge.net.au>
References: <1389918150-19058-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1389918150-19058-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return a boolean from sh_eth_is_gether() and refactor it as a one-liner.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
Dave, please consider this for net-next.

v7
* Updated changelog

v6
* Simplify logic as suggested by Joe Perches

v5
* No change

v4
* First post
---
 drivers/net/ethernet/renesas/sh_eth.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index ba1f6c9..f12a929 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -310,12 +310,9 @@ static const u16 sh_eth_offset_fast_sh3_sh2[SH_ETH_MAX_REGISTER_OFFSET] = {
 	[TSU_ADRL31]	= 0x01fc,
 };
 
-static int sh_eth_is_gether(struct sh_eth_private *mdp)
+static bool sh_eth_is_gether(struct sh_eth_private *mdp)
 {
-	if (mdp->reg_offset == sh_eth_offset_gigabit)
-		return 1;
-	else
-		return 0;
+	return mdp->reg_offset == sh_eth_offset_gigabit;
 }
 
 static void sh_eth_select_mii(struct net_device *ndev)
-- 
1.8.4
