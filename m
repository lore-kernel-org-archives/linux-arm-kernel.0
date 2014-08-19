From: van.freenix@gmail.com (Peng Fan)
Date: Tue, 19 Aug 2014 11:21:31 +0800
Subject: [PATCH] arm: Do not overwrite __machine_arch_type
Message-ID: <1408418491-29330-1-git-send-email-van.freenix@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If using DT_MACHINE_START when enabled CONFIG_OF, the nr of mdesc is ~0.
The value of __machine_arch_type is passsed from bootloader using reigster
r1, and assigned in head-common.S. Remove this line to avoid overwrite it.

Signed-off-by: Peng Fan <van.freenix@gmail.com>
---
 arch/arm/kernel/devtree.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index 11c54de..3a04486 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -243,8 +243,5 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
 
 	early_init_dt_scan_nodes();
 
-	/* Change machine number to match the mdesc we're using */
-	__machine_arch_type = mdesc->nr;
-
 	return mdesc;
 }
-- 
1.8.4
