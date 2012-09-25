From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 25 Sep 2012 02:02:15 +0200
Subject: [PATCH 3/6] ARM: dove: Fix clock names of sata and gbe
In-Reply-To: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1348531338-16624-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1348531338-16624-4-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes wrong clock names of lately added clock gates
for sata and gbe (mv64xx_eth).

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/common.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/common.c b/arch/arm/mach-dove/common.c
index 343a4bc..ffec26f 100644
--- a/arch/arm/mach-dove/common.c
+++ b/arch/arm/mach-dove/common.c
@@ -110,8 +110,8 @@ static void __init dove_clk_init(void)
 
 	orion_clkdev_add(NULL, "orion-ehci.0", usb0);
 	orion_clkdev_add(NULL, "orion-ehci.1", usb1);
-	orion_clkdev_add(NULL, "mv643xx_eth.0", ge);
-	orion_clkdev_add("0", "sata_mv.0", sata);
+	orion_clkdev_add(NULL, "mv643xx_eth_port.0", ge);
+	orion_clkdev_add(NULL, "sata_mv.0", sata);
 	orion_clkdev_add("0", "pcie", pex0);
 	orion_clkdev_add("1", "pcie", pex1);
 	orion_clkdev_add(NULL, "sdhci-dove.0", sdio0);
-- 
1.7.10.4
