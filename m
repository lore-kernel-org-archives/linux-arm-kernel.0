From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 17 Aug 2011 00:31:05 +0300
Subject: [PATCH 2/3] ARM: S5PC100: use dma-pl330 device name for clock
In-Reply-To: <1313530266-14939-1-git-send-email-vz@mleia.com>
References: <1313530266-14939-1-git-send-email-vz@mleia.com>
Message-ID: <1313530266-14939-3-git-send-email-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change replaces s3c-pl330.x clock device names with dma-pl330.x,
otherwise there won't be a correspondence between clock device name
and amba device name, thus clocks can't be enabled.

Fixes runtime errors on clk_get() from drivers/dma/pl330.c:
  dma-pl330 dma-pl330.0: Cannot get operation clock.
  dma-pl330: probe of dma-pl330.0 failed with error -22

Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
Cc: Boojin Kim <boojin.kim@samsung.com>
---
 arch/arm/mach-s5pc100/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pc100/clock.c b/arch/arm/mach-s5pc100/clock.c
index 6527c05..8d47709 100644
--- a/arch/arm/mach-s5pc100/clock.c
+++ b/arch/arm/mach-s5pc100/clock.c
@@ -460,13 +460,13 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 2),
 	}, {
 		.name		= "dma",
-		.devname	= "s3c-pl330.1",
+		.devname	= "dma-pl330.1",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
 		.name		= "dma",
-		.devname	= "s3c-pl330.0",
+		.devname	= "dma-pl330.0",
 		.parent		= &clk_div_d1_bus.clk,
 		.enable		= s5pc100_d1_0_ctrl,
 		.ctrlbit	= (1 << 0),
-- 
1.7.5.1
