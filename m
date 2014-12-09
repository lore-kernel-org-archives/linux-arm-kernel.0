From: balbi@ti.com (Felipe Balbi)
Date: Tue, 9 Dec 2014 16:27:48 -0600
Subject: [RFC/PATCH 3/7] arm: omap: hwmod: drop 'const' qualifier from
 omap_hwmod_class name
In-Reply-To: <1418164072-19087-1-git-send-email-balbi@ti.com>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
Message-ID: <1418164072-19087-4-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We will be allocating struct omap_hwmod_class for
any DT which passes sysc data. Because of that,
class->name cannot be const.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.h b/arch/arm/mach-omap2/omap_hwmod.h
index fcf55f5..0ee0116 100644
--- a/arch/arm/mach-omap2/omap_hwmod.h
+++ b/arch/arm/mach-omap2/omap_hwmod.h
@@ -588,7 +588,7 @@ struct omap_hwmod_omap4_prcm {
  * unusual reset sequences - usually processor IP blocks like the IVA.
  */
 struct omap_hwmod_class {
-	const char				*name;
+	char					*name;
 	struct omap_hwmod_class_sysconfig	*sysc;
 	u32					rev;
 	int					(*pre_shutdown)(struct omap_hwmod *oh);
-- 
2.2.0
