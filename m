From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Tue, 26 Mar 2013 23:06:40 +0100
Subject: [PATCH v6 1/7] ARM: S3C24XX: move irq driver to drivers/irqchip
In-Reply-To: <201303262305.49725.heiko@sntech.de>
References: <201303262305.49725.heiko@sntech.de>
Message-ID: <201303262306.40673.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This move is necessary to make use of the irqchip infrastructure
for the following devicetree support for s3c24xx architectures.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/mach-s3c24xx/Makefile                               |    2 +-
 drivers/irqchip/Makefile                                     |    1 +
 arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c |    0
 3 files changed, 2 insertions(+), 1 deletion(-)
 rename arch/arm/mach-s3c24xx/irq.c => drivers/irqchip/irq-s3c24xx.c (100%)

diff --git a/arch/arm/mach-s3c24xx/Makefile b/arch/arm/mach-s3c24xx/Makefile
index be6e4d0..6f46ecf 100644
--- a/arch/arm/mach-s3c24xx/Makefile
+++ b/arch/arm/mach-s3c24xx/Makefile
@@ -14,7 +14,7 @@ obj-				:=
 
 # core
 
-obj-y				+= common.o irq.o
+obj-y				+= common.o
 
 obj-$(CONFIG_CPU_S3C2410)	+= s3c2410.o
 obj-$(CONFIG_S3C2410_CPUFREQ)	+= cpufreq-s3c2410.o
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 98e3b87..4d65a21 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -2,6 +2,7 @@ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
 
 obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
+obj-$(CONFIG_ARCH_S3C24XX)		+= irq-s3c24xx.o
 obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
 obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
diff --git a/arch/arm/mach-s3c24xx/irq.c b/drivers/irqchip/irq-s3c24xx.c
similarity index 100%
rename from arch/arm/mach-s3c24xx/irq.c
rename to drivers/irqchip/irq-s3c24xx.c
-- 
1.7.10.4
