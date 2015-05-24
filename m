From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 24 May 2015 20:04:18 +0200
Subject: [PATCH 2/2] mmc: sunxi: Also set SDXC_LOW_POWER_ON
In-Reply-To: <cover.1432491958.git.hramrach@gmail.com>
References: <cover.1432491958.git.hramrach@gmail.com>
Message-ID: <29e003a6fb8253b1e103f341405d4e8322e3edc2.1432491958.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function sunxi_mmc_oclk_onoff filters out the SDXC_LOW_POWER_ON flag
but never sets it.

Set SDXC_LOW_POWER_ON when oclk is disabled.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 7cdeecd..e957888 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -603,6 +603,8 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
 
 	if (oclk_en)
 		rval |= SDXC_CARD_CLOCK_ON;
+	else
+		rval |= SDXC_LOW_POWER_ON;
 
 	start = jiffies;
 	end = start + msecs_to_jiffies(750);
-- 
2.1.4
