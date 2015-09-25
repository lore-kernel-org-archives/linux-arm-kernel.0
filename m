From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 25 Sep 2015 15:51:03 +0100
Subject: [PATCH v1 4/8] xen/arm: vgic: ctlr stores a 32-bit hardware register
 so use uint32_t
In-Reply-To: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
References: <1443192667-16112-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1443192667-16112-5-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Julien Grall <julien.grall@citrix.com>
---
    Changes in v2:
        - Patch added
---
 xen/include/asm-arm/domain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xen/include/asm-arm/domain.h b/xen/include/asm-arm/domain.h
index c3f5a95..1a5bfd7 100644
--- a/xen/include/asm-arm/domain.h
+++ b/xen/include/asm-arm/domain.h
@@ -90,7 +90,7 @@ struct arch_domain
          * rank order.
          */
         spinlock_t lock;
-        int ctlr;
+        uint32_t ctlr;
         int nr_spis; /* Number of SPIs */
         unsigned long *allocated_irqs; /* bitmap of IRQs allocated */
         struct vgic_irq_rank *shared_irqs;
-- 
2.1.4
