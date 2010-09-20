From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 20 Sep 2010 14:55:31 +0200
Subject: [PATCHv2 1/7] ARM: S5PC110: update framebuffer setup information for
	Goni
In-Reply-To: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
References: <1284987337-15365-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1284987337-15365-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the default upper_margin and vsync_len to get rid of repeated last
line on the display.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index d9fe739..4bd5582 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -91,10 +91,10 @@ static struct s3c_fb_pd_win goni_fb_win0 = {
 		.pixclock = 1000000000000ULL / ((16+16+2+480)*(28+3+2+800)*55),
 		.left_margin	= 16,
 		.right_margin	= 16,
-		.upper_margin	= 3,
+		.upper_margin	= 2,
 		.lower_margin	= 28,
 		.hsync_len	= 2,
-		.vsync_len	= 2,
+		.vsync_len	= 1,
 		.xres		= 480,
 		.yres		= 800,
 		.refresh	= 55,
-- 
1.7.1.569.g6f426
