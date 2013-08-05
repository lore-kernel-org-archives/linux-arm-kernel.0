From: lokeshvutla@ti.com (Lokesh Vutla)
Date: Mon, 5 Aug 2013 20:17:22 +0530
Subject: [PATCH 5/6] ARM: OMAP2+: Only manually add hwmod data when DT not
 used.
In-Reply-To: <1375714043-23407-1-git-send-email-lokeshvutla@ti.com>
References: <1375714043-23407-1-git-send-email-lokeshvutla@ti.com>
Message-ID: <1375714043-23407-6-git-send-email-lokeshvutla@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omap_init_rng() routine in devices.c only needs to be
called when there is no device tree present.

Cc: Tony Lindgren <tony@atomide.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
 arch/arm/mach-omap2/devices.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 3c1279f..afc2017 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -570,12 +570,12 @@ static int __init omap2_init_devices(void)
 		omap_init_mcspi();
 		omap_init_sham();
 		omap_init_aes();
+		omap_init_rng();
 	} else {
 		/* These can be removed when bindings are done */
 		omap_init_wl12xx_of();
 	}
 	omap_init_sti();
-	omap_init_rng();
 	omap_init_vout();
 
 	return 0;
-- 
1.7.9.5
