From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Tue, 11 Jun 2013 10:31:59 +0200
Subject: [PATCH 2/3] ARM: OMAP2+: devices: Do not print error when DMIC hwmod
 lookup fails
In-Reply-To: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
References: <1370939520-16132-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1370939520-16132-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It means that the SoC does not have DMIC IP
.
Reported-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/mach-omap2/devices.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index b82538d..8f268b4 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -393,10 +393,8 @@ static void __init omap_init_dmic(void)
 	struct platform_device *pdev;
 
 	oh = omap_hwmod_lookup("dmic");
-	if (!oh) {
-		pr_err("Could not look up dmic hw_mod\n");
+	if (!oh)
 		return;
-	}
 
 	pdev = omap_device_build("omap-dmic", -1, oh, NULL, 0);
 	WARN(IS_ERR(pdev), "Can't build omap_device for omap-dmic.\n");
-- 
1.8.2.1
