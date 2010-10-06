From: x0132446@ti.com (David Anders)
Date: Wed,  6 Oct 2010 16:20:17 -0500
Subject: [PATCH 1/4] omap4: pandaboard: remove unused hsmmc definition
In-Reply-To: <1286400020-1010-1-git-send-email-x0132446@ti.com>
References: <1286400020-1010-1-git-send-email-x0132446@ti.com>
Message-ID: <1286400020-1010-2-git-send-email-x0132446@ti.com>
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
index 96f5bbb..093d13b 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -67,10 +67,6 @@ static struct regulator_consumer_supply omap4_panda_vmmc_supply[] = {
 		.supply = "vmmc",
 		.dev_name = "mmci-omap-hs.0",
 	},
-	{
-		.supply = "vmmc",
-		.dev_name = "mmci-omap-hs.1",
-	},
 };
 
 static int omap4_twl6030_hsmmc_late_init(struct device *dev)
@@ -156,7 +152,7 @@ static struct regulator_init_data omap4_panda_vmmc = {
 					| REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
-	.num_consumer_supplies  = 2,
+	.num_consumer_supplies  = 1,
 	.consumer_supplies      = omap4_panda_vmmc_supply,
 };
 
-- 
1.7.0.4
