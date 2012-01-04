From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed,  4 Jan 2012 11:13:30 +0800
Subject: [PATCH] ARM: mmp: fix missing gpio name in irq resource
Message-ID: <1325646810-24372-1-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio_mux name is missed in pxa168/pxa910/mmp2. pxa-gpio driver needs to
check name in irq resource. Otherwise, pxa-gpio driver will fail to
probe.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/mmp2.c   |    1 +
 arch/arm/mach-mmp/pxa168.c |    1 +
 arch/arm/mach-mmp/pxa910.c |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 617c60a..c709a24 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -223,6 +223,7 @@ struct resource mmp2_resource_gpio[] = {
 	}, {
 		.start	= IRQ_MMP2_GPIO,
 		.end	= IRQ_MMP2_GPIO,
+		.name	= "gpio_mux",
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 8424503..12a96d6 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -167,6 +167,7 @@ struct resource pxa168_resource_gpio[] = {
 	}, {
 		.start	= IRQ_PXA168_GPIOX,
 		.end	= IRQ_PXA168_GPIOX,
+		.name	= "gpio_mux",
 		.flags	= IORESOURCE_IRQ,
 	},
 };
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 3241a25..0c87e69 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -173,6 +173,7 @@ struct resource pxa910_resource_gpio[] = {
 	}, {
 		.start	= IRQ_PXA910_AP_GPIO,
 		.end	= IRQ_PXA910_AP_GPIO,
+		.name	= "gpio_mux",
 		.flags	= IORESOURCE_IRQ,
 	},
 };
-- 
1.7.4.1
