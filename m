From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 30 Jan 2013 02:26:40 +0100
Subject: [PATCH 1/2] ARM: kirkwood: provide ge clock aliases for shared smi
Message-ID: <1359509201-11674-1-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT support for mv643xx_eth will split smi driver from core gbe driver.
Although different drivers, both use the same internal device and the
same (gateable) clock. This patch provides a proper clock alias for
the smi driver to not break non-DT kernels.

Reported-by: Simon Baatz <gmbnomis@gmail.com>
Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Simon Baatz <gmbnomis@gmail.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/common.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-kirkwood/common.c b/arch/arm/mach-kirkwood/common.c
index bac21a5..502d80d 100644
--- a/arch/arm/mach-kirkwood/common.c
+++ b/arch/arm/mach-kirkwood/common.c
@@ -252,7 +252,9 @@ void __init kirkwood_clk_init(void)
 	orion_clkdev_add(NULL, "orion_spi.0", runit);
 	orion_clkdev_add(NULL, "orion_spi.1", runit);
 	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".0", ge0);
+	orion_clkdev_add(NULL, MV643XX_ETH_SHARED_NAME ".0", ge0);
 	orion_clkdev_add(NULL, MV643XX_ETH_NAME ".1", ge1);
+	orion_clkdev_add(NULL, MV643XX_ETH_SHARED_NAME ".1", ge1);
 	orion_clkdev_add(NULL, "orion_wdt", tclk);
 	orion_clkdev_add("0", "sata_mv.0", sata0);
 	orion_clkdev_add("1", "sata_mv.0", sata1);
-- 
1.7.10.4
