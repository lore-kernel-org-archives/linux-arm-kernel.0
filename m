From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 24 Apr 2014 13:17:03 +0300
Subject: [PATCH 07/23] ARM: OMAP: add detection of omap5-dss
In-Reply-To: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
References: <1398334639-14172-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1398334639-14172-8-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add detection of omap5-dss nodes so that the related devices get
initialized.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 974461441fc3..74869326dadc 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -665,6 +665,10 @@ struct device_node * __init omapdss_find_dss_of_node(void)
 	if (node)
 		return node;
 
+	node = of_find_compatible_node(NULL, NULL, "ti,omap5-dss");
+	if (node)
+		return node;
+
 	return NULL;
 }
 
-- 
1.9.1
