From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Thu, 03 Jun 2010 14:01:35 +0900
Subject: [PATCH 3/7] ARM: S5PV210: Support GPIOlib gpio_to_irq for external
	interrupts
In-Reply-To: <1275541299-25566-1-git-send-email-jy0922.shim@samsung.com>
References: <1275541299-25566-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1275541299-25566-3-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to support GPIOlib gpio_to_irq for external interrupts to
s5pv210 machine.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/gpiolib.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/gpiolib.c b/arch/arm/mach-s5pv210/gpiolib.c
index 9ea8972..5b73c3e 100644
--- a/arch/arm/mach-s5pv210/gpiolib.c
+++ b/arch/arm/mach-s5pv210/gpiolib.c
@@ -213,6 +213,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.base	= S5PV210_GPH0(0),
 			.ngpio	= S5PV210_GPIO_H0_NR,
 			.label	= "GPH0",
+			.to_irq = s5p_gpiolib_eint_to_irq,
 		},
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC20),
@@ -221,6 +222,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.base	= S5PV210_GPH1(0),
 			.ngpio	= S5PV210_GPIO_H1_NR,
 			.label	= "GPH1",
+			.to_irq = s5p_gpiolib_eint_to_irq,
 		},
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC40),
@@ -229,6 +231,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.base	= S5PV210_GPH2(0),
 			.ngpio	= S5PV210_GPIO_H2_NR,
 			.label	= "GPH2",
+			.to_irq = s5p_gpiolib_eint_to_irq,
 		},
 	}, {
 		.base	= (S5P_VA_GPIO + 0xC60),
@@ -237,6 +240,7 @@ static struct s3c_gpio_chip s5pv210_gpio_4bit[] = {
 			.base	= S5PV210_GPH3(0),
 			.ngpio	= S5PV210_GPIO_H3_NR,
 			.label	= "GPH3",
+			.to_irq = s5p_gpiolib_eint_to_irq,
 		},
 	},
 };
-- 
1.7.0.4
