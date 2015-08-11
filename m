From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 11 Aug 2015 15:32:33 +0100
Subject: [PATCH] ARM: make highpte an expert option
Message-ID: <E1ZPAbR-00005g-Op@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When highmem is enabled, there's little reason not to also enable
highpte support as well.  Rather than leaving this to chance, make
it an expert option, and default it to be enabled if highmem is
enabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index adf2412ba4d4..f418885d9c3d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1708,8 +1708,9 @@ config HIGHMEM
 	  If unsure, say n.
 
 config HIGHPTE
-	bool "Allocate 2nd-level pagetables from highmem"
+	bool "Allocate 2nd-level pagetables from highmem" if EXPERT
 	depends on HIGHMEM
+	default y
 	help
 	  The VM uses one page of physical memory for each page table.
 	  For systems with a lot of processes, this can use a lot of
-- 
2.1.0
