From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:46 +0900
Subject: [PATCH 05/14] ARM: shmobile: r8a73a4: add a clock alias for the DMAC
 in DT mode
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <b9b28f5254d792d7ebe35f5314fe11a36174270d.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Devices, initialised from the Device Tree and from platform code usually
have different names. This patch adds a clock alias for DMAC on r8a73a4
in DT mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 357b9bc..74841ed 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -580,6 +580,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP216]),
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP217]),
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]),
+	CLKDEV_DEV_ID("e6700020.dma-controller", &mstp_clks[MSTP218]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("e6520000.i2c", &mstp_clks[MSTP300]),
 	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
-- 
1.8.4
