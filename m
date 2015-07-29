From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Wed, 29 Jul 2015 16:39:36 +0530
Subject: [PATCH 06/17] mmc: host: omap_hsmmc: remove unnecessary pbias
 set_voltage
In-Reply-To: <1438168187-1614-1-git-send-email-kishon@ti.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
Message-ID: <1438168187-1614-7-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the unnecessary pbias regulator_set_voltage done after
pbias regulator_disable in omap_hsmmc_set_power.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index dad1473..7aee1a0 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -270,7 +270,6 @@ static int omap_hsmmc_set_power(struct device *dev, int power_on, int vdd)
 			if (!ret)
 				host->pbias_enabled = 0;
 		}
-		regulator_set_voltage(host->pbias, VDD_3V0, VDD_3V0);
 	}
 
 	/*
-- 
1.7.9.5
