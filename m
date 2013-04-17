From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Wed, 17 Apr 2013 16:29:32 -0400
Subject: [PATCH 1/3] arm: dts: introduce config HAS_BANDGAP
In-Reply-To: <1366230574-31547-1-git-send-email-eduardo.valentin@ti.com>
References: <1366230574-31547-1-git-send-email-eduardo.valentin@ti.com>
Message-ID: <1366230574-31547-2-git-send-email-eduardo.valentin@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce HAS_BANDGAP config entry. This config is a
boolean value so that arch code can flag is they
feature a bandgap device.

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-omap at vger.kernel.org
Cc: linux-kernel at vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/Kconfig            | 3 +++
 arch/arm/mach-omap2/Kconfig | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index abf4467..04abc7c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -179,6 +179,9 @@ config ARCH_HAS_CPUFREQ
 	  and that the relevant menu configurations are displayed for
 	  it.
 
+config ARCH_HAS_BANDGAP
+	bool
+
 config GENERIC_HWEIGHT
 	bool
 	default y
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 9ef5e9e..c36b0e7 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -4,6 +4,7 @@ config ARCH_OMAP
 config ARCH_OMAP2PLUS
 	bool "TI OMAP2/3/4/5 SoCs with device tree support" if (ARCH_MULTI_V6 || ARCH_MULTI_V7)
 	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
-- 
1.8.2.1.342.gfa7285d
