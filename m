From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 24 Jan 2014 13:49:41 +0100
Subject: [PATCH v2 05/15] ARM: shmobile: r7s72100 clock: Add RSPI clocks for DT
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Message-ID: <1390567791-8988-6-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Add DT-style ("%08x.spi") clocks, as Genmai doesn't use the common
clock framework yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
v2:
  - No changes

 arch/arm/mach-shmobile/clock-r7s72100.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index bf15b63c3d5a..f17a5db00221 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -194,6 +194,11 @@ static struct clk_lookup lookups[] = {
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
1.7.9.5
