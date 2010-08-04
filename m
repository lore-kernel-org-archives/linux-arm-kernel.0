From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 04 Aug 2010 11:06:37 +0900
Subject: [PATCH] ARM: S5PC110: Fix GPIO I group config
Message-ID: <20100804020637.GA12479@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

GPIO I group doesn't support interrupt.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 0d45911..a0b3eee 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -150,6 +150,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.label	= "GPG3",
 		},
 	}, {
+		.config = &gpio_cfg_noint,
 		.chip	= {
 			.base	= S5PV210_GPI(0),
 			.ngpio	= S5PV210_GPIO_I_NR,
