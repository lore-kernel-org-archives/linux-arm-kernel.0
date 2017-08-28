From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 28 Aug 2017 11:32:07 +0200
Subject: [PATCH linux-next] fix compilation error in mach-omap2/display.c
Message-ID: <20170828093207.GA29080@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


In linux-next 0828, I get

  CC      arch/arm/mach-omap2/display.o
  arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
  arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first

Fix it.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 798fc71..b3f6eb5 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -172,6 +172,7 @@ static int __init omapdss_init_fbdev(void)
 		.set_min_bus_tput = omap_dss_set_min_bus_tput,
 	};
 	struct device_node *node;
+	int r;
 
 	board_data.version = omap_display_get_version();
 	if (board_data.version == OMAPDSS_VER_UNKNOWN) {

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170828/552b08cb/attachment.sig>
