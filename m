From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 4 Jun 2017 23:05:35 +0200
Subject: [PATCH 1/3] arm/xen: Improve a size determination in
 __set_phys_to_machine_multi()
In-Reply-To: <9b9230f4-0f00-e019-75b4-571e29b52998@users.sourceforge.net>
References: <9b9230f4-0f00-e019-75b4-571e29b52998@users.sourceforge.net>
Message-ID: <7f2ec975-9a2b-132d-77f0-559fd7eadc30@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 4 Jun 2017 20:50:55 +0200

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 arch/arm/xen/p2m.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/xen/p2m.c b/arch/arm/xen/p2m.c
index 0ed01f2d5ee4..11e78432b663 100644
--- a/arch/arm/xen/p2m.c
+++ b/arch/arm/xen/p2m.c
@@ -144,5 +144,5 @@ bool __set_phys_to_machine_multi(unsigned long pfn,
 		return true;
 	}
 
-	p2m_entry = kzalloc(sizeof(struct xen_p2m_entry), GFP_NOWAIT);
+	p2m_entry = kzalloc(sizeof(*p2m_entry), GFP_NOWAIT);
 	if (!p2m_entry) {
-- 
2.13.0
