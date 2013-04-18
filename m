From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Apr 2013 10:54:33 -0700
Subject: [PATCH 2/3] ARM: OMAP2+: Fix unused variable warning for am3517 crane
In-Reply-To: <20130418175303.7436.75241.stgit@muffinssi.local>
References: <20130418175303.7436.75241.stgit@muffinssi.local>
Message-ID: <20130418175433.7436.18512.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following by removing the unused variable:

arch/arm/mach-omap2/board-am3517crane.c: In function ?am3517_crane_init?:
arch/arm/mach-omap2/board-am3517crane.c:113: warning: unused variable ?ret?

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index fc53911..0d499a1 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -110,8 +110,6 @@ static void __init am3517_crane_i2c_init(void)
 
 static void __init am3517_crane_init(void)
 {
-	int ret;
-
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
 	omap_sdrc_init(NULL, NULL);
