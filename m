From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Wed, 16 Mar 2011 19:16:02 +0200
Subject: [PATCH 1/2] arm: mach-omap2: devices: fix omap3_l3_init() return value
Message-ID: <1300295763-497-1-git-send-email-aaro.koskinen@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the return value for the successful case.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 0d2d6a9..d478f53 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -65,7 +65,7 @@ static int __init omap3_l3_init(void)
 
 	WARN(IS_ERR(od), "could not build omap_device for %s\n", oh_name);
 
-	return PTR_ERR(od);
+	return IS_ERR(od) ? PTR_ERR(od) : 0;
 }
 postcore_initcall(omap3_l3_init);
 
-- 
1.5.6.5
