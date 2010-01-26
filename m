From: tony@atomide.com (Tony Lindgren)
Date: Tue, 26 Jan 2010 11:37:48 -0800
Subject: [PATCH 3/3] ARM: Select CPU_32v6K for CPU_V7 only if ARCH_OMAP2 is
	not selected
In-Reply-To: <20100126193311.15134.24078.stgit@baageli.muru.com>
References: <20100126193311.15134.24078.stgit@baageli.muru.com>
Message-ID: <20100126193748.15134.4837.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise the kernel built with both CPU_V6 and CPU_V7 will not
boot on omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mm/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index baf6384..4c2e90d 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -399,7 +399,7 @@ config CPU_V6
 config CPU_32v6K
 	bool "Support ARM V6K processor extensions" if !SMP
 	depends on CPU_V6
-	default y if SMP && !ARCH_MX3
+	default y if SMP && !(ARCH_MX3 || ARCH_OMAP2)
 	help
 	  Say Y here if your ARMv6 processor supports the 'K' extension.
 	  This enables the kernel to use some instructions not present
@@ -410,7 +410,7 @@ config CPU_32v6K
 # ARMv7
 config CPU_V7
 	bool "Support ARM V7 processor" if ARCH_INTEGRATOR || MACH_REALVIEW_EB || MACH_REALVIEW_PBX
-	select CPU_32v6K
+	select CPU_32v6K if !ARCH_OMAP2
 	select CPU_32v7
 	select CPU_ABRT_EV7
 	select CPU_PABRT_V7
