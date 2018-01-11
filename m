From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 11 Jan 2018 16:02:56 +0800
Subject: [RFC PATCH nomadik] net: ethernet: gmac_coalesce_delay_expired() can
 be static
In-Reply-To: <201801111518.om5JWZd1%fengguang.wu@intel.com>
References: <201801111518.om5JWZd1%fengguang.wu@intel.com>
Message-ID: <20180111080256.GA23490@lkp-sb05>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Fixes: de0cb586c9e5 ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 gemini.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 7258136..459bdf5a 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1624,7 +1624,7 @@ static u32 gmac_get_intr_flags(struct net_device *netdev, int i)
 	return val;
 }
 
-enum hrtimer_restart gmac_coalesce_delay_expired(struct hrtimer *timer)
+static enum hrtimer_restart gmac_coalesce_delay_expired(struct hrtimer *timer)
 {
 	struct gemini_ethernet_port *port =
 		container_of(timer, struct gemini_ethernet_port,
