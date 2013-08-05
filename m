From: robherring2@gmail.com (Rob Herring)
Date: Mon,  5 Aug 2013 17:50:08 -0500
Subject: [PATCH 4/5] ARM: highbank: select ARCH_HAS_HOLES_MEMORYMODEL
In-Reply-To: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
References: <1375743009-28972-1-git-send-email-robherring2@gmail.com>
Message-ID: <1375743009-28972-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

On Midway, the first 4G of memory starts at 0 and the rest of memory
(4GB+) starts at 0x2_00000000, so we need to enable pfn_valid checks
by selecting ARCH_HAS_HOLES_MEMORYMODEL.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/mach-highbank/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index efe4961..8b2948f 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -1,6 +1,7 @@
 config ARCH_HIGHBANK
 	bool "Calxeda ECX-1000/2000 (Highbank/Midway)" if ARCH_MULTI_V7
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_HAS_OPP
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
-- 
1.8.1.2
