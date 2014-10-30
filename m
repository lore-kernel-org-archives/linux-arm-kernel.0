From: orca.chen@gmail.com (Min-Hua Chen)
Date: Fri, 31 Oct 2014 00:34:31 +0800
Subject: [PATCH] arm: use phys_addr_t to describe physical address
Message-ID: <CAHkaATTjqpySW2jH-X3g38BpP0AM-+xLsia-G7riit55WeCP8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Use phys_addr_t to describe physical_address. When LPAE
is enabled, physical address can be more than 32 bits, so
we have to use phys_addr_t to handle the case.

Signed-off-by: Min-Hua Chen <orca.chen@gmail.com>
---
 arch/arm/mm/mmu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9f98cec..858aa11 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1335,8 +1335,8 @@ static void __init kmap_init(void)
 static void __init map_lowmem(void)
 {
     struct memblock_region *reg;
-    unsigned long kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
-    unsigned long kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);
+    phys_addr_t kernel_x_start = round_down(__pa(_stext), SECTION_SIZE);
+    phys_addr_t kernel_x_end = round_up(__pa(__init_end), SECTION_SIZE);

     /* Map all the lowmem memory banks. */
     for_each_memblock(memory, reg) {
--
1.7.10.4

thanks,
Min-Hua
