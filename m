From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jan 2014 17:02:29 +0900
Subject: [PATCH v4 net-next 1/4] sh_eth: Use bool as return type of
 sh_eth_is_gether()
In-Reply-To: <1389168152-9434-1-git-send-email-horms+renesas@verge.net.au>
References: <1389168152-9434-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1389168152-9434-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return a boolean and use true and false.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

Dave,

please consider this for net-next.

v4
* First post
---
 drivers/net/ethernet/renesas/sh_eth.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 8884107..4b38533 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -310,12 +310,12 @@ static const u16 sh_eth_offset_fast_sh3_sh2[SH_ETH_MAX_REGISTER_OFFSET] = {
 	[TSU_ADRL31]	= 0x01fc,
 };
 
-static int sh_eth_is_gether(struct sh_eth_private *mdp)
+static bool sh_eth_is_gether(struct sh_eth_private *mdp)
 {
 	if (mdp->reg_offset == sh_eth_offset_gigabit)
-		return 1;
+		return true;
 	else
-		return 0;
+		return false;
 }
 
 static void sh_eth_select_mii(struct net_device *ndev)
-- 
1.8.4
