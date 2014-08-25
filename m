From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:09:46 +0900
Subject: [PATCH 1/3] ARM: shmobile: sh73a0: Remove spurious 0x from SCIFB
 clock name
In-Reply-To: <cover.1408926048.git.horms+renesas@verge.net.au>
References: <cover.1408926048.git.horms+renesas@verge.net.au>
Message-ID: <2c3758b01aa6f11382d2b018614b5d48ecf30350.1408926048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A stray '0x' crept into a0f7e7496d56ac2d ("ARM: shmobile: sh73a0: add CMT1
clock support for DT"). This  patch removes it.

This change should not have any run-time affect at this time as
the clock in question is used by a SCIF device that is not enabled by
default.

Reported-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 0d77f65..b0993a5 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -644,7 +644,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("e6cb0000.serial", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
-	CLKDEV_DEV_ID("0xe6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
+	CLKDEV_DEV_ID("e6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("e6c40000.serial", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
-- 
2.0.1
