From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 15 Sep 2015 21:37:50 +0100
Subject: [PATCH] ARM: make highpte an expert option
Message-ID: <E1Zbwz8-00016Z-5C@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When highmem is enabled, there's little reason not to also enable
highpte support as well.  Rather than leaving this to chance, make
it an expert option, and default it to be enabled if highmem is
enabled.  Add some help text to the option while we're here.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 17ac5d26ebaa..02eb51b6d324 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1711,8 +1711,9 @@ config HIGHMEM
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
