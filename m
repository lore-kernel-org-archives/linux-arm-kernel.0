From: balbi@ti.com (Felipe Balbi)
Date: Tue, 15 Nov 2011 10:46:02 +0200
Subject: [PATCH/RESEND #3 4/7] arm: omap: smartreflex: move late_initcall()
 closer to its argument
In-Reply-To: <1321346765-16633-1-git-send-email-balbi@ti.com>
References: <1321346765-16633-1-git-send-email-balbi@ti.com>
Message-ID: <1321346765-16633-5-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

no functional changes, trivial patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index bb3bfc0..97375d2 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1095,12 +1095,12 @@ static int __init sr_init(void)
 
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
1.7.8.rc0
