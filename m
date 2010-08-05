From: kmpark@infradead.org (Kyungmin Park)
Date: Thu, 05 Aug 2010 16:25:50 +0900
Subject: [PATCH 4/5] ARM: S5PC110: Fix GPIO I group config
Message-ID: <20100805072550.GA22276@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

GPIO I group doesn't support interrupt feature.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/gpiolib.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index bd24c81..94d4fe2 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -159,6 +159,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "GPG3",
 		},
 	}, {
+		.config = &gpio_cfg_noint,
 		.chip	= {
 			.base	= S5PV210_GPI(0),
 			.ngpio	= S5PV210_GPIO_I_NR,
-- 
1.5.3.3
