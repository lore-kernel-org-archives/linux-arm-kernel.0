From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jul 2012 11:54:00 +0300
Subject: [PATCH 3/5] arm: omap: debug-leds: add section annotation to probe
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Message-ID: <1343120042-16695-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

put our probe function on __devinit section, so
it can be freed on some cases.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 615d085..392daa8 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -236,7 +236,7 @@ fpga_led_set(struct led_classdev *cdev, enum led_brightness value)
 	spin_unlock_irqrestore(&lock, flags);
 }
 
-static void __init newled_init(struct device *dev)
+static void __devinit newled_init(struct device *dev)
 {
 	unsigned	i;
 	struct dbg_led	*led;
@@ -254,7 +254,7 @@ static void __init newled_init(struct device *dev)
 
 /*-------------------------------------------------------------------------*/
 
-static int /* __init */ fpga_probe(struct platform_device *pdev)
+static int __devinit fpga_probe(struct platform_device *pdev)
 {
 	struct resource	*iomem;
 
-- 
1.7.11
