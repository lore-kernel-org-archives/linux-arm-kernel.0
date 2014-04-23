From: robherring2@gmail.com (Rob Herring)
Date: Tue, 22 Apr 2014 20:18:05 -0500
Subject: [PATCH v2 05/21] ARM: dt: use default early_init_dt_alloc_memory_arch
In-Reply-To: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
References: <1398215901-25609-1-git-send-email-robherring2@gmail.com>
Message-ID: <1398215901-25609-6-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Now that ARM is using memblock instead of bootmem, the default version
of early_init_dt_alloc_memory_arch can be used.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
v2: no change

 arch/arm/kernel/devtree.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/kernel/devtree.c b/arch/arm/kernel/devtree.c
index c7419a5..dff9cc0 100644
--- a/arch/arm/kernel/devtree.c
+++ b/arch/arm/kernel/devtree.c
@@ -32,11 +32,6 @@ void __init early_init_dt_add_memory_arch(u64 base, u64 size)
 	arm_add_memory(base, size);
 }
 
-void * __init early_init_dt_alloc_memory_arch(u64 size, u64 align)
-{
-	return memblock_virt_alloc(size, align);
-}
-
 void __init arm_dt_memblock_reserve(void)
 {
 	u64 *reserve_map, base, size;
-- 
1.9.1
