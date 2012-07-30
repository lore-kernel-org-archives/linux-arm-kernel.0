From: svenkatr@ti.com (Venkatraman S)
Date: Mon, 30 Jul 2012 13:17:49 +0530
Subject: [PATCH] ARM: topology: fix section mismatch warning for
 init_cpu_topology
Message-ID: <1343634469-29712-1-git-send-email-svenkatr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get rid of this warning..
arch/arm/kernel/built-in.o(.text+0xac78): Section mismatch in reference
from the function init_cpu_topology() to the function
 .init.text:parse_dt_topology()
The function init_cpu_topology() references
the function __init parse_dt_topology().
This is often because init_cpu_topology lacks a __init
annotation or the annotation of parse_dt_topology is wrong.

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index 198b084..26c12c6 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -321,7 +321,7 @@ void store_cpu_topology(unsigned int cpuid)
  * init_cpu_topology is called at boot when only one cpu is running
  * which prevent simultaneous write access to cpu_topology array
  */
-void init_cpu_topology(void)
+void __init init_cpu_topology(void)
 {
 	unsigned int cpu;
 
-- 
1.7.11.1.25.g0e18bef
