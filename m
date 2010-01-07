From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Thu, 07 Jan 2010 14:39:21 +1100
Subject: [PATCH 3/3] arm: export arm_add_memory
In-Reply-To: <1262835561.887063.943450380979.0.gpush@pororo>
Message-ID: <1262835561.888252.461260980683.3.gpush@pororo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We'd like to add memory from the device tree, so make arm_add_memory
non-static and add a prototype in setup.h

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 arch/arm/include/asm/setup.h |    2 ++
 arch/arm/kernel/setup.c      |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/setup.h b/arch/arm/include/asm/setup.h
index 3b6f461..3fa2555 100644
--- a/arch/arm/include/asm/setup.h
+++ b/arch/arm/include/asm/setup.h
@@ -225,6 +225,8 @@ extern struct meminfo meminfo;
 
 extern char cmd_line[COMMAND_LINE_SIZE];
 
+extern int arm_add_memory(unsigned long start, unsigned long size);
+
 #endif  /*  __KERNEL__  */
 
 #endif
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 4206286..84fd876 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -383,7 +383,7 @@ static struct machine_desc * __init setup_machine(unsigned int nr)
 	return list;
 }
 
-static int __init arm_add_memory(unsigned long start, unsigned long size)
+int __init arm_add_memory(unsigned long start, unsigned long size)
 {
 	struct membank *bank = &meminfo.bank[meminfo.nr_banks];
 
