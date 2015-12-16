From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 16 Dec 2015 17:14:45 +0800
Subject: [PATCH 1/2] bus: sunxi-rsb: Fix primary PMIC mapping hardware address
In-Reply-To: <1450257286-1645-1-git-send-email-wens@csie.org>
References: <1450257286-1645-1-git-send-email-wens@csie.org>
Message-ID: <1450257286-1645-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The primary PMICs use 0x3a3 as their hardware address, not 0x3e3.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/bus/sunxi-rsb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index 0cfcb39c53f4..f951b3555175 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -527,7 +527,7 @@ static int sunxi_rsb_init_device_mode(struct sunxi_rsb *rsb)
  */
 
 static const struct sunxi_rsb_addr_map sunxi_rsb_addr_maps[] = {
-	{ 0x3e3, 0x2d }, /* Primary PMIC: AXP223, AXP809, AXP81X, ... */
+	{ 0x3a3, 0x2d }, /* Primary PMIC: AXP223, AXP809, AXP81X, ... */
 	{ 0x745, 0x3a }, /* Secondary PMIC: AXP806, ... */
 	{ 0xe89, 0x45 }, /* Peripheral IC: AC100, ... */
 };
-- 
2.6.4
