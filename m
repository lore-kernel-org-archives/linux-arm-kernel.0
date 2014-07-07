From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:53 +0200
Subject: [PATCH v2 28/30] ARM: shmobile: sh73a0: add CMT1 clock support for DT
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-29-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising CMT1 device using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 9433a4e..d8c4048 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -690,6 +690,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.0", &dsi0phy_clk),
 	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.1", &dsi1phy_clk),
 	CLKDEV_ICK_ID("fck", "sh-cmt-48.1", &mstp_clks[MSTP329]), /* CMT1 */
+	CLKDEV_ICK_ID("fck", "e6138000.timer", &mstp_clks[MSTP329]), /* CMT1 */
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP125]), /* TMU0 */
 };
 
-- 
2.0.0.rc2
