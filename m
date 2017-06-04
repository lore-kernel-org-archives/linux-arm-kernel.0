From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 4 Jun 2017 23:07:29 +0200
Subject: [PATCH 3/3] arm/xen: Adjust one function call together with a
 variable assignment
In-Reply-To: <9b9230f4-0f00-e019-75b4-571e29b52998@users.sourceforge.net>
References: <9b9230f4-0f00-e019-75b4-571e29b52998@users.sourceforge.net>
Message-ID: <e479b745-f2da-b92e-02c3-f5ce27fc53ad@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Jun 2017 21:21:20 +0200

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/xen/p2m.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index f5f74ac637b9..e71eefa2e427 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -153,7 +153,8 @@ bool __set_phys_to_machine_multi(unsigned long pfn,
 	p2m_entry->mfn = mfn;
 
 	write_lock_irqsave(&p2m_lock, irqflags);
-	if ((rc = xen_add_phys_to_mach_entry(p2m_entry)) < 0) {
+	rc = xen_add_phys_to_mach_entry(p2m_entry);
+	if (rc < 0) {
 		write_unlock_irqrestore(&p2m_lock, irqflags);
 		return false;
 	}
-- 
2.13.0
