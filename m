From: balbi@ti.com (Felipe Balbi)
Date: Tue, 24 Jul 2012 11:54:02 +0300
Subject: [PATCH 5/5] arm: omap: debug-leds: switch to resource_size()
In-Reply-To: <1343120042-16695-1-git-send-email-balbi@ti.com>
References: <1343120042-16695-1-git-send-email-balbi@ti.com>
Message-ID: <1343120042-16695-6-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

instead of hardcoding the address space size, we
can calculate it using resource_size() helper.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/debug-leds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/debug-leds.c b/arch/arm/plat-omap/debug-leds.c
index 08fbb85..ebc0317 100644
--- a/arch/arm/plat-omap/debug-leds.c
+++ b/arch/arm/plat-omap/debug-leds.c
@@ -272,7 +272,7 @@ static int __devinit fpga_probe(struct platform_device *pdev)
 	if (!iomem)
 		return -ENODEV;
 
-	fpga = ioremap(iomem->start, H2P2_DBG_FPGA_SIZE);
+	fpga = ioremap(iomem->start, resource_size(iomem));
 	__raw_writew(~0, &fpga->leds);
 
 #ifdef	CONFIG_LEDS
-- 
1.7.11
