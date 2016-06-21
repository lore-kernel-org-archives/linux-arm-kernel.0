From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Tue, 21 Jun 2016 13:28:53 +0100
Subject: [PATCH] ARM: hisi: make unexported symbols static
Message-ID: <1466512133-31751-1-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The two functions hix5hd2_set_scu_boot_addr() and
hip01_set_boot_addr() are not declared or exported
outside arch/arm/mach-hisi/platsmp.c file. Avoid
the following warnings by making them static:

arch/arm/mach-hisi/platsmp.c:142:6: warning: symbol 'hip01_set_boot_addr' was not declared. Should it be static?
arch/arm/mach-hisi/platsmp.c:106:6: warning: symbol 'hix5hd2_set_scu_boot_addr' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-hisi/platsmp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index 47ed32c..e1d6764 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -103,7 +103,7 @@ static void __init hisi_common_smp_prepare_cpus(unsigned int max_cpus)
 	hisi_enable_scu_a9();
 }
 
-void hix5hd2_set_scu_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
+static void hix5hd2_set_scu_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
 {
 	void __iomem *virt;
 
@@ -139,7 +139,7 @@ static const struct smp_operations hix5hd2_smp_ops __initconst = {
 #define HIP01_BOOT_ADDRESS     0x80000000
 #define REG_SC_CTRL            0x000
 
-void hip01_set_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
+static void hip01_set_boot_addr(phys_addr_t start_addr, phys_addr_t jump_addr)
 {
 	void __iomem *virt;
 
-- 
2.8.1
