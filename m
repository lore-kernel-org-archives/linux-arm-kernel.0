From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:22 +0100
Subject: [PATCH 1/6] ARM: SAMSUNG: Increase virtual framebuffer size on
 Universal C210 board
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1327501407-1927-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase framebuffer virtual size to enable display panning.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index dd75101..0e01f04 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -817,6 +817,8 @@ static struct s3c_fb_pd_win universal_fb_win0 = {
 	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.virtual_x	= 480,
+	.virtual_y	= 2 * 800,
 };
 
 static struct s3c_fb_platdata universal_lcd_pdata __initdata = {
-- 
1.7.8.3
