From: balbi@ti.com (Felipe Balbi)
Date: Mon, 10 Oct 2011 15:26:16 +0300
Subject: [RFT/PATCH 4/7] arm: omap: smartreflex: move late_initcall() closer
	to its argument
In-Reply-To: <1318249579-4089-1-git-send-email-balbi@ti.com>
References: <1318249579-4089-1-git-send-email-balbi@ti.com>
Message-ID: <1318249579-4089-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no functional changes, trivial patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 357363b..28a24fd 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1085,12 +1085,12 @@ static int __init sr_init(void)
 
 	return 0;
 }
+late_initcall(sr_init);
 
 static void __exit sr_exit(void)
 {
 	platform_driver_unregister(&smartreflex_driver);
 }
-late_initcall(sr_init);
 module_exit(sr_exit);
 
 MODULE_DESCRIPTION("OMAP Smartreflex Driver");
-- 
1.7.6.396.ge0613
