From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 15 Sep 2015 21:38:52 +0100
Subject: [RFC PATCH] ARM: enable highmem by default on ARMv6/ARMv7 CPUs
Message-ID: <E1Zbx08-0001A3-PQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARMv6 and ARMv7 normally have more than 1G of memory, so it makes sense
to have highmem enabled by default.  Users can still turn highmem off if
they wish by enabling the EXPERT option, which then allows the option to
be visible.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 02eb51b6d324..49250dc9856b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1694,8 +1694,9 @@ config HAVE_GENERIC_RCU_GUP
 	depends on ARM_LPAE
 
 config HIGHMEM
-	bool "High Memory Support"
+	bool "High Memory Support" if !(CPU_32v6 || CPU_32v7) || EXPERT
 	depends on MMU
+	default y if CPU_32v6 || CPU_32v7
 	help
 	  The address space of ARM processors is only 4 Gigabytes large
 	  and it has to accommodate user address space, kernel address
-- 
2.1.0
