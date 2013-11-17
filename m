From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sun, 17 Nov 2013 16:31:34 +0000
Subject: [PATCH] xen/arm: p2m_init and p2m_lock should be static
Message-ID: <1384705894-8285-1-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm/xen/p2m.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 0f842e8..b31ee1b2 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -25,7 +25,7 @@ struct xen_p2m_entry {
 	struct rb_node rbnode_phys;
 };
 
-rwlock_t p2m_lock;
+static rwlock_t p2m_lock;
 struct rb_root phys_to_mach = RB_ROOT;
 EXPORT_SYMBOL_GPL(phys_to_mach);
 static struct rb_root mach_to_phys = RB_ROOT;
@@ -201,7 +201,7 @@ bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 }
 EXPORT_SYMBOL_GPL(__set_phys_to_machine);
 
-int p2m_init(void)
+static int p2m_init(void)
 {
 	rwlock_init(&p2m_lock);
 	return 0;
-- 
1.7.2.5
