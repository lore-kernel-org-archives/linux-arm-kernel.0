From: s-anna@ti.com (Suman Anna)
Date: Wed, 11 Mar 2015 18:38:38 -0500
Subject: [PATCH] ARM: OMAP2+: Fix socbus family info for AM33xx devices
Message-ID: <1426117118-11806-1-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The family information in the soc-bus data is currently
not classified properly for AM33xx devices, and a read
of /sys/bus/soc/devices/soc0/family currently shows
"Unknown". Fix the same.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/id.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 2a2f4d56e4c8..25f1beea453e 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -720,6 +720,8 @@ static const char * __init omap_get_family(void)
 		return kasprintf(GFP_KERNEL, "OMAP4");
 	else if (soc_is_omap54xx())
 		return kasprintf(GFP_KERNEL, "OMAP5");
+	else if (soc_is_am33xx() || soc_is_am335x())
+		return kasprintf(GFP_KERNEL, "AM33xx");
 	else if (soc_is_am43xx())
 		return kasprintf(GFP_KERNEL, "AM43xx");
 	else if (soc_is_dra7xx())
-- 
2.3.0
