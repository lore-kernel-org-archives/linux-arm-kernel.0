From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 11 Jun 2013 10:31:58 +0200
Subject: [PATCH 1/3] ARM: OMAP2+: devices: Do not print error when McPDM hwmod
 lookup fails
In-Reply-To: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
References: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1370939520-16132-2-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It means that the SoC does not have McPDM IP.

Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 4269fc1..b82538d 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -374,10 +374,8 @@ static void __init omap_init_mcpdm(void)
 	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("mcpdm");
-	if (!oh) {
-		printk(KERN_ERR "Could not look up mcpdm hw_mod\n");
+	if (!oh)
 		return;
-	}
 
 	pdev = omap_device_build("omap-mcpdm", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap-mcpdm.\n");
-- 
1.8.2.1
