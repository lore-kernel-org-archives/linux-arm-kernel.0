From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 30 Sep 2015 11:45:17 +0100
Subject: [PATCH v5 02/22] arm/xen: Drop pte_mfn and mfn_pte
In-Reply-To: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443609937-25278-3-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

They are not used in common code expect in one place in balloon.c which is
only compiled when Linux is using PV MMU. It's not the case on ARM.

Rather than worrying how to handle the 64KB case, drop them.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Reviewed-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

---
Cc: Russell King <linux@arm.linux.org.uk>

    Changes in v4:
        - Add Stefano's reviewed

    Changes in v3:
        - Patch added
---
 arch/arm/include/asm/xen/page.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 1279563..98c9fc3 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -13,9 +13,6 @@
 
 #define phys_to_machine_mapping_valid(pfn) (1)
 
-#define pte_mfn	    pte_pfn
-#define mfn_pte	    pfn_pte
-
 /* Xen machine address */
 typedef struct xmaddr {
 	phys_addr_t maddr;
-- 
2.1.4
