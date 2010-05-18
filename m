From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 18 May 2010 11:30:48 +0200
Subject: [PATCH 1/2] ARM: SMDKC100: fix frame buffer definitions
In-Reply-To: <1274175049-21847-1-git-send-email-m.szyprowski@samsung.com>
References: <1274175049-21847-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274175049-21847-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of the framebuffer parameters was created when s3c-fb.c
driver was patched to support setting the refresh rate directly (commit
600ce1a0faafeed1ce6bcfd421bc040b941cbbc1). That patch was completely wrong
and was reverted in commit eb29a5cc0b601c458bae9df2f what breaked the
framebuffer on s5pc100. This patch updates framebuffer definitions to
correct values.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/mach-smdkc100.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pc100/mach-smdkc100.c b/arch/arm/mach-s5pc100/mach-smdkc100.c
index ae3c52c..dd8c154 100644
--- a/arch/arm/mach-s5pc100/mach-smdkc100.c
+++ b/arch/arm/mach-s5pc100/mach-smdkc100.c
@@ -119,8 +119,7 @@ static struct platform_device smdkc100_lcd_powerdev = {
 static struct s3c_fb_pd_win smdkc100_fb_win0 = {
 	/* this is to ensure we use win0 */
 	.win_mode	= {
-		.refresh	= 70,
-		.pixclock	= (8+13+3+800)*(7+5+1+480),
+		.pixclock = 1000000000000ULL / ((8+13+3+800)*(7+5+1+480)*80),
 		.left_margin	= 8,
 		.right_margin	= 13,
 		.upper_margin	= 7,
-- 
1.6.4
