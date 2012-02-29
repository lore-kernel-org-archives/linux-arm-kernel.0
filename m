From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed, 29 Feb 2012 23:33:45 +0100
Subject: [PATCH 09/13] ARM: OMAP3+: SmartReflex: move late_initcall() closer
 to its argument
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Message-ID: <1330554829-11347-10-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Balbi <balbi@ti.com>

no functional changes, trivial patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 22fe442..fc59a24 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1117,12 +1117,12 @@ static int __init sr_init(void)
 
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
1.7.5.4
