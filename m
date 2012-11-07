From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:34:58 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7779: add USB OHCI clock support
In-Reply-To: <1352277298-23312-1-git-send-email-horms@verge.net.au>
References: <1352277298-23312-1-git-send-email-horms@verge.net.au>
Message-ID: <1352277298-23312-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ohci-platform driver require these clocks

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 4ba4e3c..be885cf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -157,7 +157,9 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
+	CLKDEV_DEV_ID("ohci-platform.1", &mstp_clks[MSTP101]), /* USB OHCI port2 */
 	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
+	CLKDEV_DEV_ID("ohci-platform.0", &mstp_clks[MSTP100]), /* USB OHCI port0/1 */
 	CLKDEV_DEV_ID("sh_tmu.0", &mstp_clks[MSTP016]), /* TMU00 */
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
-- 
1.7.10.4
