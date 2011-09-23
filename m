From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 23 Sep 2011 15:46:22 +0300
Subject: [PATCHv9 14/18] TEMP: mux: added trace for io wkup event
In-Reply-To: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
References: <1316781986-30642-1-git-send-email-t-kristo@ti.com>
Message-ID: <1316781986-30642-15-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Temporary patch for testing purposes, not meant for integration.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/mux.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index b27c061..642fe3f 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -376,6 +376,8 @@ bool omap_hwmod_mux_get_wake_status(struct omap_hwmod_mux_info *hmux)
 					pad->mux->reg_offset);
 			if (val & OMAP_WAKEUP_EVENT) {
 				ret = true;
+				pr_info("wkup detected: %04x\n",
+					pad->mux->reg_offset);
 				break;
 			}
 		}
-- 
1.7.4.1


Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 
