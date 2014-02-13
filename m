From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:13:58 +0900
Subject: [PATCH 09/12] ARM: shmobile: r7s72100 clock: Add RSPI clocks for DT
In-Reply-To: <cover.1392277789.git.horms+renesas@verge.net.au>
References: <cover.1392277789.git.horms+renesas@verge.net.au>
Message-ID: <9c25f63d91d1ca7e894faf70cbf6ba1801758cbc.1392278855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add DT-style ("%08x.spi") clocks, as Genmai doesn't use the common
clock framework yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index ffb0fff..71c99fe 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -191,6 +191,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("rspi-rz.2", &mstp_clks[MSTP105]),
 	CLKDEV_DEV_ID("rspi-rz.3", &mstp_clks[MSTP104]),
 	CLKDEV_DEV_ID("rspi-rz.4", &mstp_clks[MSTP103]),
+	CLKDEV_DEV_ID("e800c800.spi", &mstp_clks[MSTP107]),
+	CLKDEV_DEV_ID("e800d000.spi", &mstp_clks[MSTP106]),
+	CLKDEV_DEV_ID("e800d800.spi", &mstp_clks[MSTP105]),
+	CLKDEV_DEV_ID("e800e000.spi", &mstp_clks[MSTP104]),
+	CLKDEV_DEV_ID("e800e800.spi", &mstp_clks[MSTP103]),
 	CLKDEV_DEV_ID("fcfee000.i2c", &mstp_clks[MSTP97]),
 	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
 	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
-- 
1.8.5.2
