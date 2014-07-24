From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:40 +0900
Subject: [PATCH 3/5] ARM: shmobile: r8a73a4: add CMT1 clock support for DT
In-Reply-To: <cover.1406164563.git.horms+renesas@verge.net.au>
References: <cover.1406164563.git.horms+renesas@verge.net.au>
Message-ID: <aad64dc31954dbbb84cd8fcfaf1bc028f3bc2616.1406164563.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising CMT1 device using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a73a4.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a73a4.c b/arch/arm/mach-shmobile/clock-r8a73a4.c
index 1d2fe05..9629851 100644
--- a/arch/arm/mach-shmobile/clock-r8a73a4.c
+++ b/arch/arm/mach-shmobile/clock-r8a73a4.c
@@ -604,6 +604,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6500000.i2c", &mstp_clks[MSTP318]),
 	CLKDEV_DEV_ID("e6510000.i2c", &mstp_clks[MSTP323]),
 	CLKDEV_ICK_ID("fck", "sh-cmt-48-gen2.1", &mstp_clks[MSTP329]),
+	CLKDEV_ICK_ID("fck", "e6130000.timer", &mstp_clks[MSTP329]),
 	CLKDEV_DEV_ID("e60b0000.i2c", &mstp_clks[MSTP409]),
 	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP410]),
 	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP411]),
-- 
2.0.1
