From: hvaibhav@ti.com (Vaibhav Hiremath)
Date: Sun, 20 Nov 2011 22:49:06 +0530
Subject: [RFC PATCH 02/11] arm:omap:am33xx: Integrate voltage domain data
In-Reply-To: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
References: <1321809555-13833-1-git-send-email-hvaibhav@ti.com>
Message-ID: <1321809555-13833-3-git-send-email-hvaibhav@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Afzal Mohammed <afzal@ti.com>

Hook up AM33XX voltage domain info to OMAP framework.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
---
 arch/arm/mach-omap2/Makefile |    2 ++
 arch/arm/mach-omap2/io.c     |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b33a85f..d4a9a61 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -95,6 +95,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common) \
 					   voltagedomains2xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common) \
 					   voltagedomains3xxx_data.o
+obj-$(CONFIG_SOC_OMAPAM33XX)		+= $(voltagedomain-common) \
+					   voltagedomains33xx_data.o
 obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common) \
 					   voltagedomains44xx_data.o

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index e958c04..b67d2ca 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -465,6 +465,7 @@ void __init am33xx_init_early(void)
 {
 	omap2_set_globals_am33xx();
 	omap_common_init_early();
+	am33xx_voltagedomains_init();
 	omap3xxx_clk_init();
 }
 #endif
--
1.7.0.4
