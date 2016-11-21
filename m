From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:15:39 +0100
Subject: [PATCH 1/3] ARM: davinci: hawk: fix mmc card detect gpio
In-Reply-To: <20161121161541.27048-1-ahaslam@baylibre.com>
References: <20161121161541.27048-1-ahaslam@baylibre.com>
Message-ID: <20161121161541.27048-2-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The card detect gpio on the hawk board is gpio4_0 and not gpio3_12

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index a4e8726..c0c24ba9 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -25,7 +25,7 @@
 #include <mach/mux.h>
 
 #define HAWKBOARD_PHY_ID		"davinci_mdio-0:07"
-#define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(3, 12)
+#define DA850_HAWK_MMCSD_CD_PIN		GPIO_TO_PIN(4, 0)
 #define DA850_HAWK_MMCSD_WP_PIN		GPIO_TO_PIN(3, 13)
 
 #define DA850_USB1_VBUS_PIN		GPIO_TO_PIN(2, 4)
@@ -119,7 +119,7 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 static const short hawk_mmcsd0_pins[] = {
 	DA850_MMCSD0_DAT_0, DA850_MMCSD0_DAT_1, DA850_MMCSD0_DAT_2,
 	DA850_MMCSD0_DAT_3, DA850_MMCSD0_CLK, DA850_MMCSD0_CMD,
-	DA850_GPIO3_12, DA850_GPIO3_13,
+	DA850_GPIO4_0, DA850_GPIO3_13,
 	-1
 };
 
-- 
2.9.3
