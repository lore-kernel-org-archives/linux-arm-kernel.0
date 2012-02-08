From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Wed,  8 Feb 2012 18:43:50 +0100
Subject: [PATCH 05/14] ARM: OMAP3+: SmartReflex: use __devexit_p annotation
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Message-ID: <1328723039-15952-6-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use __devexit_p() in struct platform_driver for functions that are
defined with __devexit.

Reported-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9c39484..24ba80b 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1079,7 +1079,7 @@ static void __devexit omap_sr_shutdown(struct platform_device *pdev)
 }
 
 static struct platform_driver smartreflex_driver = {
-	.remove         = omap_sr_remove,
+	.remove         = __devexit_p(omap_sr_remove),
 	.shutdown	= __devexit_p(omap_sr_shutdown),
 	.driver		= {
 		.name	= "smartreflex",
-- 
1.7.5.4
