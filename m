From: e.voevodin@samsung.com (Evgeny Voevodin)
Date: Fri, 23 Dec 2011 15:48:47 +0400
Subject: [PATCH] exynos4: Frame buffer clock source changed to "lcd".
Message-ID: <1324640927-16139-1-git-send-email-e.voevodin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With "fimd" kernel couldn't find the clock during boot-up:
"s3c-fb exynos4-fb.0: failed to get bus clock"

Signed-off-by: Evgeny Voevodin <e.voevodin@samsung.com>
---
 arch/arm/mach-exynos/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index 2894f0a..8e52be5 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -489,7 +489,7 @@ static struct clk init_clocks_off[] = {
 		.enable		= exynos4_clk_ip_cam_ctrl,
 		.ctrlbit	= (1 << 3),
 	}, {
-		.name		= "fimd",
+		.name		= "lcd",
 		.devname	= "exynos4-fb.0",
 		.enable		= exynos4_clk_ip_lcd0_ctrl,
 		.ctrlbit	= (1 << 0),
-- 
1.7.4.1
