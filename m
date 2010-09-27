From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 27 Sep 2010 17:48:33 +0900
Subject: [PATCH] ARM: Samsung: S5PC210: Place the common SPARSEMEM at
	CPU_S5PV310
Message-ID: <20100927084833.GA3059@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

In case of s5pc210 CPU. It uses the SPARSEMEN as default memory configuration
So move to CPU_S5PV310 config.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 331b5bd..9bf4d5c 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -12,6 +12,7 @@ if ARCH_S5PV310
 config CPU_S5PV310
 	bool
 	select PLAT_S5P
+	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Enable S5PV310 CPU support
 
@@ -30,14 +31,12 @@ config S5PV310_SETUP_I2C2
 config MACH_SMDKV310
 	bool "SMDKV310"
 	select CPU_S5PV310
-	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Machine support for Samsung SMDKV310
 
 config MACH_UNIVERSAL_C210
 	bool "Mobile UNIVERSAL_C210 Board"
 	select CPU_S5PV310
-	select ARCH_SPARSEMEM_ENABLE
 	help
 	  Machine support for Samsung Mobile Universal S5PC210 Reference
 	  Board. S5PC210(MCP) is one of package option of S5PV310
-- 
1.5.3.3
