From: yunzhi.li@deephi.tech (Yunzhi Li)
Date: Mon,  7 Aug 2017 17:33:22 +0800
Subject: [PATCH] ARM: hisi: Fix typo in comment
Message-ID: <20170807093322.26050-1-yunzhi.li@deephi.tech>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the rc vs. pc typo. There is no a register named rc, I felt
confused when I read this assembler command in comment.

Signed-off-by: Yunzhi Li <yunzhi.li@deephi.tech>
---

 arch/arm/mach-hisi/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 91bb02dec20f..da5689ababf7 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -109,7 +109,7 @@ static void hix5hd2_set_scu_boot_addr(phys_addr_t start_addr, phys_addr_t jump_a
 
 	virt = ioremap(start_addr, PAGE_SIZE);
 
-	writel_relaxed(0xe51ff004, virt);	/* ldr pc, [rc, #-4] */
+	writel_relaxed(0xe51ff004, virt);	/* ldr pc, [pc, #-4] */
 	writel_relaxed(jump_addr, virt + 4);	/* pc jump phy address */
 	iounmap(virt);
 }
-- 
2.11.0
