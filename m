From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 25 Jan 2012 15:23:25 +0100
Subject: [PATCH 4/6] ARM: SAMSUNG: Correct framebuffer window size on Nuri
 board
In-Reply-To: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
References: <1327501407-1927-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1327501407-1927-5-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The real LCD resolution on Nuri is 1024x600, not 1280x800. This change
fixes the color distortion (green shadows) on half of the screen.
Also increase framebuffer virtual size for display panning support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-exynos/mach-nuri.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-nuri.c b/arch/arm/mach-exynos/mach-nuri.c
index cc8d2f6..ab8318c 100644
--- a/arch/arm/mach-exynos/mach-nuri.c
+++ b/arch/arm/mach-exynos/mach-nuri.c
@@ -222,14 +222,14 @@ static struct s3c_fb_pd_win nuri_fb_win0 = {
 		.lower_margin	= 1,
 		.hsync_len	= 48,
 		.vsync_len	= 3,
-		.xres		= 1280,
-		.yres		= 800,
+		.xres		= 1024,
+		.yres		= 600,
 		.refresh	= 60,
 	},
 	.max_bpp	= 24,
 	.default_bpp	= 16,
-	.virtual_x	= 1280,
-	.virtual_y	= 800,
+	.virtual_x	= 1024,
+	.virtual_y	= 2 * 600,
 };
 
 static struct s3c_fb_platdata nuri_fb_pdata __initdata = {
-- 
1.7.8.3
