From: s-guiriec@ti.com (Sebastien Guiriec)
Date: Tue, 16 Oct 2012 17:30:40 +0200
Subject: [PATCH] OMAP4: devices: fixup OMAP4 DMIC platform device error message
Message-ID: <1350401440-9620-1-git-send-email-s-guiriec@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct DMIC hwmod lockup error message and replace printk() by
pr_err().

Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index c8c2117..cba60e0 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -341,7 +341,7 @@ static void __init omap_init_dmic(void)
 
 	oh = omap_hwmod_lookup("dmic");
 	if (!oh) {
-		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
+		pr_err("Could not look up dmic hw_mod\n");
 		return;
 	}
 
-- 
1.7.10.4
