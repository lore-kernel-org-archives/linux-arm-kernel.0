From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 10:35:34 -0700
Subject: [PATCH 01/22] OMAP2+: hwmod: remove unused voltagedomain pointer
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Message-ID: <1314639355-12713-2-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The voltage domain pointer currently in struct omap_hwmod is not used
and does not belong here.  Instead, voltage domains will be associated
with powerdomains in forthcoming patches.

Acked-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 0e329ca..38ac4af 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -526,7 +526,6 @@ struct omap_hwmod {
 	char				*clkdm_name;
 	struct clockdomain		*clkdm;
 	char				*vdd_name;
-	struct voltagedomain		*voltdm;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	void				*dev_attr;
-- 
1.7.6
