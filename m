From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 07 Jan 2011 17:57:48 +0100
Subject: [PATCH 3/3] ARM: S5PV210: Change framebuffer window 0 size on GONI
In-Reply-To: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
References: <1294419468-13700-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1294419468-13700-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase virtual size of the frambuffer window 0
for the display panning support.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/mach-goni.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/mach-goni.c b/arch/arm/mach-s5pv210/mach-goni.c
index 2051cee..ed06f20 100644
--- a/arch/arm/mach-s5pv210/mach-goni.c
+++ b/arch/arm/mach-s5pv210/mach-goni.c
@@ -108,6 +108,8 @@ static struct s3c_fb_pd_win goni_fb_win0 = {
 	},
 	.max_bpp	= 32,
 	.default_bpp	= 16,
+	.virtual_x	= 480,
+	.virtual_y	= 2 * 800,
 };
 
 static struct s3c_fb_platdata goni_lcd_pdata __initdata = {
-- 
1.7.3.5
