From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Aug 2011 16:03:39 +0100
Subject: [PATCH v7 16/16] ARM: LPAE: Add the Kconfig entries
In-Reply-To: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
References: <1312988619-16804-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <1312988619-16804-17-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the ARM_LPAE and ARCH_PHYS_ADDR_T_64BIT Kconfig entries
allowing LPAE support to be compiled into the kernel.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/Kconfig    |    2 +-
 arch/arm/mm/Kconfig |   13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2c71a8f..2a81b90 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1820,7 +1820,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ZBOOT_ROM
+	depends on !ZBOOT_ROM && !ARM_LPAE
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 88633fe..2df5504 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -629,6 +629,19 @@ config IO_36
 
 comment "Processor Features"
 
+config ARM_LPAE
+	bool "Support for the Large Physical Address Extension"
+	depends on MMU && CPU_V7
+	help
+	  Say Y if you have an ARMv7 processor supporting the LPAE page table
+	  format and you would like to access memory beyond the 4GB limit.
+
+config ARCH_PHYS_ADDR_T_64BIT
+	def_bool ARM_LPAE
+
+config ARCH_DMA_ADDR_T_64BIT
+	def_bool ARM_LPAE
+
 config ARM_THUMB
 	bool "Support Thumb user binaries"
 	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || CPU_FEROCEON
