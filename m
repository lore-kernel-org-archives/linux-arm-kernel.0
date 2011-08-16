From: vz@mleia.com (Vladimir Zapolskiy)
Date: Wed, 17 Aug 2011 00:31:04 +0300
Subject: [PATCH 1/3] ARM: EXYNOS4: use dma-pl330 device name for clock
In-Reply-To: <1313530266-14939-1-git-send-email-vz@mleia.com>
References: <1313530266-14939-1-git-send-email-vz@mleia.com>
Message-ID: <1313530266-14939-2-git-send-email-vz@mleia.com>
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
 arch/arm/mach-exynos4/clock.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos4/clock.c b/arch/arm/mach-exynos4/clock.c
index fee2dd8..04c997a 100644
--- a/arch/arm/mach-exynos4/clock.c
+++ b/arch/arm/mach-exynos4/clock.c
@@ -460,12 +460,12 @@ static struct clk init_clocks_off[] = {
 		.ctrlbit	= (1 << 10),
 	}, {
 		.name		= "dma",
-		.devname	= "s3c-pl330.0",
+		.devname	= "dma-pl330.0",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 0),
 	}, {
 		.name		= "dma",
-		.devname	= "s3c-pl330.1",
+		.devname	= "dma-pl330.1",
 		.enable		= exynos4_clk_ip_fsys_ctrl,
 		.ctrlbit	= (1 << 1),
 	}, {
-- 
1.7.5.1
