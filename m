From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jan 2014 11:46:49 +0900
Subject: [PATCH] ARM: shmobile: r8a7790: Fix I2C controller names
In-Reply-To: <cover.1389321620.git.horms+renesas@verge.net.au>
References: <cover.1389321620.git.horms+renesas@verge.net.au>
Message-ID: <db455c786886465c4d7fcd012fe2684b4c887776.1389321620.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This fixes the issue introduced by the following commit:
b448c904f5058b6c "ARM: shmobile: r8a7790: add I2C support"

The R8A7790 is an R-Car Gen2 SoC. The clock division factor
(CDF) width is 3 bits on Gen2 as opposed to 2 bits on Gen1.
Fix the device names for R8A7790 SoC to make the R-Car I2C
driver configure the hardware properly.

Changes in V2:
* rebased on top of the latest branch;
* capitalized ARM in the subject line;
* noted the commit that caused the issue in the log.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 8 ++++----
 arch/arm/mach-shmobile/setup-r8a7790.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index b6ecea3..e6f88dd 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -292,13 +292,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
 	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
-	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
-	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
-	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.2", &mstp_clks[MSTP929]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
-	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 66476d2..d6589f3 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -81,7 +81,7 @@ static struct resource i2c_resources[] __initdata = {
 
 #define r8a7790_register_i2c(idx)		\
 	platform_device_register_simple(	\
-		"i2c-rcar", idx,		\
+		"i2c-rcar_gen2", idx,		\
 		i2c_resources + (2 * idx), 2);	\
 
 void __init r8a7790_pinmux_init(void)
-- 
1.8.4
