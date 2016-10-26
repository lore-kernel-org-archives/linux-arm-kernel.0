From: tony@atomide.com (Tony Lindgren)
Date: Wed, 26 Oct 2016 08:16:59 -0700
Subject: [PATCH 1/5] ARM: OMAP5: Fix build for PM code
In-Reply-To: <20161026151703.24730-1-tony@atomide.com>
References: <20161026151703.24730-1-tony@atomide.com>
Message-ID: <20161026151703.24730-2-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's CONFIG_SOC_OMAP5, not CONFIG_ARCH_OMAP5. Looks like make randconfig
builds have not hit this one yet.

Fixes: b3bf289c1c45 ("ARM: OMAP2+: Fix build with CONFIG_SMP and CONFIG_PM
is not set")
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -80,7 +80,7 @@ endif
 # Power Management
 omap-4-5-pm-common			= omap-mpuss-lowpower.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-4-5-pm-common)
-obj-$(CONFIG_ARCH_OMAP5)		+= $(omap-4-5-pm-common)
+obj-$(CONFIG_SOC_OMAP5)			+= $(omap-4-5-pm-common)
 obj-$(CONFIG_OMAP_PM_NOOP)		+= omap-pm-noop.o
 
 ifeq ($(CONFIG_PM),y)
-- 
2.9.3
