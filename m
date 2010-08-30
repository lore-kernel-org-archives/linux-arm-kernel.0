From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 30 Aug 2010 20:47:08 +0900
Subject: [PATCH 1/3] ARM: Samsung S5P: Move the common Samsung S5P series	GPIO
	level type
Message-ID: <20100830114708.GA13140@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Samsung S5P series has common level type. It's different from S3C series.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/plat-samsung/include/plat/gpio-core.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/gpio-core.h b/arch/arm/plat-samsung/include/plat/gpio-core.h
index e358c7d..c8681e0 100644
--- a/arch/arm/plat-samsung/include/plat/gpio-core.h
+++ b/arch/arm/plat-samsung/include/plat/gpio-core.h
@@ -14,6 +14,12 @@
 #define GPIOCON_OFF	(0x00)
 #define GPIODAT_OFF	(0x04)
 
+#define S5P_GPIO_LEVEL_LOW		(0x00)
+#define S5P_GPIO_LEVEL_HIGH		(0x01)
+#define S5P_GPIO_EDGE_FALLING		(0x02)
+#define S5P_GPIO_EDGE_RISING		(0x03)
+#define S5P_GPIO_EDGE_BOTH		(0x04)
+
 #define con_4bit_shift(__off) ((__off) * 4)
 
 /* Define the core gpiolib support functions that the s3c platforms may
-- 
1.5.3.3
