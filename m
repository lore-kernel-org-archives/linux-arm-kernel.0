From: chris.brandt@renesas.com (Chris Brandt)
Date: Wed,  8 Feb 2017 22:30:44 -0500
Subject: [PATCH 2/2] ARM: shmobile: add renesas soc as a top level selection
In-Reply-To: <20170209033044.19513-1-chris.brandt@renesas.com>
References: <20170209033044.19513-1-chris.brandt@renesas.com>
Message-ID: <20170209033044.19513-3-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allows users to select "Renesas ARM SoCs" as opposed to multiplatform.
ARM_SINGLE_ARMV7 is then selected to help with the behind the scenes work
in the build scripts.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/Kconfig               | 4 ++++
 arch/arm/mach-shmobile/Kconfig | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 36107e7..9c468dd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -359,6 +359,10 @@ config ARCH_MULTIPLATFORM
 	select SPARSE_IRQ
 	select USE_OF
 
+config ARM_SOC_RENESAS_V7
+	bool "Renesas ARM SoCs"
+	select ARM_SINGLE_ARMV7
+
 config ARM_SINGLE_ARMV7M
 	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
 	depends on !MMU
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index ad7d604..1317aea 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -31,7 +31,7 @@ config ARCH_RMOBILE
 
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
-	depends on ARCH_MULTI_V7 && MMU
+	depends on (ARCH_MULTI_V7 || ARM_SOC_RENESAS_V7) && MMU
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select ARCH_SHMOBILE
 	select ARCH_SHMOBILE_MULTI
-- 
2.10.1
