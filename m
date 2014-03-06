From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Mar 2014 14:05:16 +0900
Subject: [PATCH 1/2] ARM: shmobile: r8a7791: Remove legacy clock aliases for
 DT devices
In-Reply-To: <cover.1394082270.git.horms+renesas@verge.net.au>
References: <cover.1394082270.git.horms+renesas@verge.net.au>
Message-ID: <a8a8266229787241e1dfdb075a416e31da2fa1d7.1394082270.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Now that the r8a7791 DT platforms use the common clock framework,
there's no need to manually create clock aliases for devices
instantiated through DT, as those devices will reference their clocks
directly in the device tree. Remove those aliases.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 3e1b6b6..605fc77 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -267,7 +267,6 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP311]),
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("qspi.0", &mstp_clks[MSTP917]),
-	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
 	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
-- 
1.8.5.2
