From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 13 Feb 2015 17:11:22 +0200
Subject: [PATCH 5/9] ARM: OMAP2+: display: detect DRA7 DSS
In-Reply-To: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
References: <1423840286-18377-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1423840286-18377-6-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add platform code to detect DRA7 DSS.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/mach-omap2/display.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 156d022b1e09..7f596fe2bfeb 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -281,6 +281,8 @@ static enum omapdss_version __init omap_display_get_version(void)
 		return OMAPDSS_VER_OMAP5;
 	else if (soc_is_am43xx())
 		return OMAPDSS_VER_AM43xx;
+	else if (soc_is_dra7xx())
+		return OMAPDSS_VER_DRA7xx;
 	else
 		return OMAPDSS_VER_UNKNOWN;
 }
@@ -567,6 +569,7 @@ static const char * const omapdss_compat_names[] __initconst = {
 	"ti,omap3-dss",
 	"ti,omap4-dss",
 	"ti,omap5-dss",
+	"ti,dra7-dss",
 };
 
 struct device_node * __init omapdss_find_dss_of_node(void)
-- 
2.3.0
