From: jj@chaosbits.net (Jesper Juhl)
Date: Sat, 9 Jul 2011 23:11:14 +0200 (CEST)
Subject: [PATCH 1/7] ARM: static should be at beginning of declaration
In-Reply-To: <alpine.LNX.2.00.1107092304160.25516@swampdragon.chaosbits.net>
References: <alpine.LNX.2.00.1107092304160.25516@swampdragon.chaosbits.net>
Message-ID: <alpine.LNX.2.00.1107092309500.25516@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure that the 'static' keywork is at the beginning of declaration
for arch/arm/mach-shmobile/board-ap4evb.c

This gets rid of warnings like
  warning: ?static? is not at beginning of declaration
when building with -Wold-style-declaration (and/or -Wextra which also
enables it).

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 803bc6e..bb4e084 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -443,7 +443,7 @@ static struct platform_device usb1_host_device = {
 	.resource	= usb1_host_resources,
 };
 
-const static struct fb_videomode ap4evb_lcdc_modes[] = {
+static const struct fb_videomode ap4evb_lcdc_modes[] = {
 	{
 #ifdef CONFIG_AP4EVB_QHD
 		.name		= "R63302(QHD)",
-- 
1.7.6


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
