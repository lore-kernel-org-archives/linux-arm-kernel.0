From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 03 Dec 2009 06:45:37 -0700
Subject: [PATCH 5/9] OMAP powerdomain: rearrange struct powerdomain to save
	some memory
In-Reply-To: <20091203134321.16229.87539.stgit@localhost.localdomain>
References: <20091203134321.16229.87539.stgit@localhost.localdomain>
Message-ID: <20091203134536.16229.35852.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rearranges the order of structure members in struct powerdomain
to avoid wasting memory due to alignment restrictions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/powerdomain.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 5a80ddb..56bb1b9 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -87,15 +87,15 @@ struct powerdomain {
 	/* Used to represent the OMAP chip types containing this pwrdm */
 	const struct omap_chip_id omap_chip;
 
-	/* Bit shift of this powerdomain's PM_WKDEP/CM_SLEEPDEP bit */
-	const u8 dep_bit;
-
 	/* Powerdomains that can be told to wake this powerdomain up */
 	struct pwrdm_dep *wkdep_srcs;
 
 	/* Powerdomains that can be told to keep this pwrdm from inactivity */
 	struct pwrdm_dep *sleepdep_srcs;
 
+	/* Bit shift of this powerdomain's PM_WKDEP/CM_SLEEPDEP bit */
+	const u8 dep_bit;
+
 	/* Possible powerdomain power states */
 	const u8 pwrsts;
 
