From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 17 Jan 2014 22:25:38 +0200
Subject: [PATCH 1/3] ARM: DRA7XX/AM43XX: randconfig fixes
In-Reply-To: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
References: <1389990340-23358-1-git-send-email-t-kristo@ti.com>
Message-ID: <1389990340-23358-2-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DRA7XX and AM43XX were missing common clock code from the Makefile, which
causes build breakage in DRA7XX / AM43XX only builds once clock support
for these SoCs is added. Add the missing entries to the Makefile as
preparation of this.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/Makefile |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 088305f..96a990f 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -191,6 +191,9 @@ obj-$(CONFIG_ARCH_OMAP4)		+= dpll3xxx.o dpll44xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= $(clock-common) dpll3xxx.o
 obj-$(CONFIG_SOC_OMAP5)			+= $(clock-common)
 obj-$(CONFIG_SOC_OMAP5)			+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_DRA7XX)		+= $(clock-common)
+obj-$(CONFIG_SOC_DRA7XX)		+= dpll3xxx.o dpll44xx.o
+obj-$(CONFIG_SOC_AM43XX)		+= $(clock-common) dpll3xxx.o
 
 # OMAP2 clock rate set data (old "OPP" data)
 obj-$(CONFIG_SOC_OMAP2420)		+= opp2420_data.o
-- 
1.7.9.5
