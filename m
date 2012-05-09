From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed,  9 May 2012 10:33:34 +0300
Subject: [PATCH v2 3/3] OMAP: omap4panda: Use common configuration for V1V8,
 V2V1 supplies
In-Reply-To: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
References: <1336548814-1005-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1336548814-1005-4-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These supplies going to be needed for the twl6040 driver.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1b782ba..c47feed 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -323,7 +323,9 @@ static int __init omap4_panda_i2c_init(void)
 			TWL_COMMON_REGULATOR_VANA |
 			TWL_COMMON_REGULATOR_VCXIO |
 			TWL_COMMON_REGULATOR_VUSB |
-			TWL_COMMON_REGULATOR_CLK32KG);
+			TWL_COMMON_REGULATOR_CLK32KG |
+			TWL_COMMON_REGULATOR_V1V8 |
+			TWL_COMMON_REGULATOR_V2V1);
 	omap4_pmic_init("twl6030", &omap4_panda_twldata,
 			&twl6040_data, OMAP44XX_IRQ_SYS_2N);
 	omap_register_i2c_bus(2, 400, NULL, 0);
-- 
1.7.8.6
