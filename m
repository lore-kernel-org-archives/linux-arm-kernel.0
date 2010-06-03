From: leiwen@marvell.com (Lei Wen)
Date: Thu, 3 Jun 2010 15:46:50 +0800
Subject: [PATCH 14/25] mmp: correct nand clock setting for pxa168 and pxa910
Message-ID: <mailman.26.1276839452.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no clock setting at 208Mhz for nand on pxa168 and pxa910
platform. Set correct register and lock the clock at
156MHZ.

Signed-off-by: Lei Wen <leiwen@marvell.com>
---
 arch/arm/mach-mmp/pxa168.c |    2 +-
 arch/arm/mach-mmp/pxa910.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 652ae66..70d2231 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -78,7 +78,7 @@ static APBC_CLK(ssp3, PXA168_SSP3, 4, 0);
 static APBC_CLK(ssp4, PXA168_SSP4, 4, 0);
 static APBC_CLK(ssp5, PXA168_SSP5, 4, 0);

-static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(nand, NAND, 0x19B, 156000000);

 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 46f2d69..96f2b61 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -110,7 +110,7 @@ static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);

-static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(nand, NAND, 0x19B, 156000000);

 /* device and clock bindings */
 static struct clk_lookup pxa910_clkregs[] = {
-- 
1.7.0.4
