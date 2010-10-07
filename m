From: x0132446@ti.com (David Anders)
Date: Thu,  7 Oct 2010 14:36:28 -0500
Subject: [PATCH 1/3] omap4: pandaboard: remove unused hsmmc definition
In-Reply-To: <1286480190-20632-1-git-send-email-x0132446@ti.com>
References: <1286480190-20632-1-git-send-email-x0132446@ti.com>
Message-ID: <1286480190-20632-2-git-send-email-x0132446@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

remove the second hsmmc definition as it is only used on the
expansion header of the PandaBoard and can be mux for other
functions.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 992a03e..dc16884 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -98,10 +98,6 @@ static struct regulator_consumer_supply omap4_panda_vmmc_supply[] = {
 		.supply = "vmmc",
 		.dev_name = "mmci-omap-hs.0",
 	},
-	{
-		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.1",
-	},
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
@@ -187,7 +183,7 @@ static struct regulator_init_data omap4_panda_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 2,
+	.num_consumer_supplies  = 1,
 	.consumer_supplies      = omap4_panda_vmmc_supply,
 };
 
-- 
1.7.0.4
