From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 25 Oct 2010 10:01:15 +0100
Subject: [RFC PATCH 18/18] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
References: <20101025085812.25275.55757.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <20101025090115.25275.30532.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the ARM_LPAE and ARCH_PHYS_ADDR_T_64BIT Kconfig entries
allowing LPAE support to be compiled into the kernel.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/Kconfig |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 8493ed0..fb85a5f 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -615,6 +615,16 @@ config IO_36
 
 comment "Processor Features"
 
+config ARM_LPAE
+	bool "Support for the Large Physical Address Extension"
+	depends on MMU && CPU_V7
+	help
+	  Say Y if you have an ARMv7 processor supporting the LPAE page table
+	  format and you would like access memory beyond the 4GB limit.
+
+config ARCH_PHYS_ADDR_T_64BIT
+	def_bool ARM_LPAE
+
 config ARM_THUMB
 	bool "Support Thumb user binaries"
 	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V7 || CPU_FEROCEON
