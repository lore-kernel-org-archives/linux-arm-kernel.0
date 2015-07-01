From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 01 Jul 2015 22:45:49 +0100
Subject: [PATCH] ARM: add help text for HIGHPTE configuration entry
Message-ID: <E1ZAPpF-0003NZ-C5@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add some help text for the HIGHPTE configuration entry.  This comes from
the x86 entry, but reworded to be more a more accurate description of
what this option does.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 45df48ba0b12..cc0ea0c6cfc9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1661,6 +1661,12 @@ config HIGHMEM
 config HIGHPTE
 	bool "Allocate 2nd-level pagetables from highmem"
 	depends on HIGHMEM
+	help
+	  The VM uses one page of physical memory for each page table.
+	  For systems with a lot of processes, this can use a lot of
+	  precious low memory, eventually leading to low memory being
+	  consumed by page tables.  Setting this option will allow
+	  user-space 2nd level page tables to reside in high memory.
 
 config HW_PERF_EVENTS
 	bool "Enable hardware performance counter support for perf events"
-- 
2.1.0
