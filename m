From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue,  9 Apr 2013 00:52:10 +0200
Subject: [PATCH v3 2/9] ARM: mvebu: Limit the DMA zone when LPAE is selected
In-Reply-To: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
References: <1365461538-30702-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1365461538-30702-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When LPAE is activated on Armada XP, all registers and IOs are still
32bit, the 40bit extension is on the CPU to DRAM path (windows) only.
That means that all the DMA transfer are restricted to the low 32 bits
address space. This is limitation is achieved by selecting ZONE_DMA.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 440b13e..db1bbc8 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -13,6 +13,7 @@ config ARCH_MVEBU
 	select MVEBU_CLK_CORE
 	select MVEBU_CLK_CPU
 	select MVEBU_CLK_GATING
+	select ZONE_DMA if ARM_LPAE
 
 if ARCH_MVEBU
 
-- 
1.7.9.5
