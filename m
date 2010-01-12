From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 11 Jan 2010 18:05:42 -0700
Subject: [PATCH 08/10] OMAP powerdomain: rearrange struct powerdomain to save
	some memory
In-Reply-To: <20100112010258.6275.97999.stgit@localhost.localdomain>
References: <20100112010258.6275.97999.stgit@localhost.localdomain>
Message-ID: <20100112010540.6275.80664.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch rearranges the order of structure members in struct powerdomain
to avoid wasting memory due to alignment restrictions.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/include/plat/powerdomain.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index c590e2f..87e13f8 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -73,12 +73,12 @@ struct powerdomain {
 	/* Powerdomain name */
 	const char *name;
 
-	/* the address offset from CM_BASE/PRM_BASE */
-	const s16 prcm_offs;
-
 	/* Used to represent the OMAP chip types containing this pwrdm */
 	const struct omap_chip_id omap_chip;
 
+	/* the address offset from CM_BASE/PRM_BASE */
+	const s16 prcm_offs;
+
 	/* Possible powerdomain power states */
 	const u8 pwrsts;
 
