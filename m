From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue,  7 Jun 2016 20:03:49 +0100
Subject: [PATCH 5/5] mvebu: add definition for coherency_base
In-Reply-To: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1465326229-24787-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1465326229-24787-6-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the warning that coherency_base is not defined by adding
it to coherency.h (it is only used in the coherency_ll.S):

arch/arm/mach-mvebu/coherency.c:41:14: warning: symbol 'coherency_base' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/mach-mvebu/coherency.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/coherency.h b/arch/arm/mach-mvebu/coherency.h
index 54cb760..6067f14 100644
--- a/arch/arm/mach-mvebu/coherency.h
+++ b/arch/arm/mach-mvebu/coherency.h
@@ -14,6 +14,7 @@
 #ifndef __MACH_370_XP_COHERENCY_H
 #define __MACH_370_XP_COHERENCY_H
 
+extern void __iomem *coherency_base;	/* for coherency_ll.S */
 extern unsigned long coherency_phys_base;
 int set_cpu_coherent(void);
 
-- 
2.8.1
