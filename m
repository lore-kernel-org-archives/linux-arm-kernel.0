From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:13:55 +0900
Subject: [PATCH 06/12] ARM: shmobile: r8a7778: add audio clock in new style
In-Reply-To: <cover.1392277789.git.horms+renesas@verge.net.au>
References: <cover.1392277789.git.horms+renesas@verge.net.au>
Message-ID: <0117ae1a7bad69ca788f9b77af8fd6b1998115b6.1392278855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current audio clock doesn't have dependency to device/driver,
but, it is not good design for DT support.
To avoid branch merge conflict issue,
it uses this load map, and this patch is 1) part.
 1) add new style clock in platform
 2) add new style clock method in driver
 3) remove old tyle clock from platform

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 9783945..2009a9b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -221,6 +221,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("fffc6000.spi", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("rcar_sound", &mstp_clks[MSTP008]), /* SRU */
 
+	CLKDEV_ICK_ID("clk_a", "rcar_sound", &audio_clk_a),
+	CLKDEV_ICK_ID("clk_b", "rcar_sound", &audio_clk_b),
+	CLKDEV_ICK_ID("clk_c", "rcar_sound", &audio_clk_c),
+	CLKDEV_ICK_ID("clk_i", "rcar_sound", &s1_clk),
 	CLKDEV_ICK_ID("ssi.0", "rcar_sound", &mstp_clks[MSTP012]),
 	CLKDEV_ICK_ID("ssi.1", "rcar_sound", &mstp_clks[MSTP011]),
 	CLKDEV_ICK_ID("ssi.2", "rcar_sound", &mstp_clks[MSTP010]),
-- 
1.8.5.2
