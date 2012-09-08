From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 07 Sep 2012 18:39:58 -0600
Subject: [PATCH 6/6] ARM: OMAP2+: clean up PRCM sections of the Makefile
In-Reply-To: <20120908002614.4648.31150.stgit@dusk.lan>
References: <20120908002614.4648.31150.stgit@dusk.lan>
Message-ID: <20120908003956.4648.85021.stgit@dusk.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clean up the PRCM sections of the Makefile; this saves a few lines.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/Makefile |   35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 89e0daf..eb203ec 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -88,67 +88,52 @@ obj-$(CONFIG_ARCH_OMAP4)		+= cpuidle44xx.o
 endif
 
 # PRCM
-omap-prcm-4-5-common			=  prcm.o cminst44xx.o cm44xx.o \
+obj-y					+= prcm.o prm_common.o
+obj-$(CONFIG_ARCH_OMAP2)		+= cm2xxx_3xxx.o prm2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= cm2xxx_3xxx.o prm2xxx_3xxx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
+obj-$(CONFIG_SOC_AM33XX)		+= prm33xx.o cm33xx.o
+omap-prcm-4-5-common			=  cminst44xx.o cm44xx.o prm44xx.o \
 					   prcm_mpu44xx.o prminst44xx.o \
 					   vc44xx_data.o vp44xx_data.o \
 					   prm44xx.o
-obj-y					+= prm_common.o
-obj-$(CONFIG_ARCH_OMAP2)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= vc3xxx_data.o vp3xxx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+= prcm.o prm33xx.o cm33xx.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common) prm44xx.o
+obj-$(CONFIG_ARCH_OMAP4)		+= $(omap-prcm-4-5-common)
 obj-$(CONFIG_SOC_OMAP5)			+= $(omap-prcm-4-5-common)
 
 # OMAP voltage domains
-voltagedomain-common			:= voltage.o vc.o vp.o
-obj-$(CONFIG_ARCH_OMAP2)		+= $(voltagedomain-common)
+obj-y					+= voltage.o vc.o vp.o
 obj-$(CONFIG_ARCH_OMAP2)		+= voltagedomains2xxx_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= voltagedomains3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(voltagedomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= voltagedomains44xx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+= $(voltagedomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= voltagedomains33xx_data.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(voltagedomain-common)
 
 # OMAP powerdomain framework
-powerdomain-common			+= powerdomain.o powerdomain-common.o
-obj-$(CONFIG_ARCH_OMAP2)		+= $(powerdomain-common)
+obj-y					+= powerdomain.o powerdomain-common.o
 obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx_data.o
 obj-$(CONFIG_ARCH_OMAP2)		+= powerdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= powerdomains2xxx_3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= powerdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= powerdomains2xxx_3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(powerdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= powerdomains44xx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+= $(powerdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= powerdomains33xx_data.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(powerdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= powerdomain44xx.o
 
 # PRCM clockdomain control
-clockdomain-common			+= clockdomain.o
-obj-$(CONFIG_ARCH_OMAP2)		+= $(clockdomain-common)
+obj-y					+= clockdomain.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_SOC_OMAP2420)		+= clockdomains2420_data.o
 obj-$(CONFIG_SOC_OMAP2430)		+= clockdomains2430_data.o
-obj-$(CONFIG_ARCH_OMAP3)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomain2xxx_3xxx.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains2xxx_3xxx_data.o
 obj-$(CONFIG_ARCH_OMAP3)		+= clockdomains3xxx_data.o
-obj-$(CONFIG_ARCH_OMAP4)		+= $(clockdomain-common)
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomain44xx.o
 obj-$(CONFIG_ARCH_OMAP4)		+= clockdomains44xx_data.o
-obj-$(CONFIG_SOC_AM33XX)		+= $(clockdomain-common)
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomain33xx.o
 obj-$(CONFIG_SOC_AM33XX)		+= clockdomains33xx_data.o
-obj-$(CONFIG_SOC_OMAP5)			+= $(clockdomain-common)
 obj-$(CONFIG_SOC_OMAP5)			+= clockdomain44xx.o
 
 # Clock framework
