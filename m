From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 9 Nov 2009 14:25:52 +0800
Subject: [PATCH 1/3] [ARM] pxa: introduce
Message-ID: <mailman.1.1257749437.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_MACH_ZYLONITE{300,320} for CPU_PXA* removing

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig  |   13 ++++++++++++-
 arch/arm/mach-pxa/Makefile |    7 ++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index e62572d..ca2bd59 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -46,12 +46,23 @@ config MACH_MAINSTONE
 	select PXA_HAVE_BOARD_IRQS

 config MACH_ZYLONITE
-	bool "PXA3xx Development Platform (aka Zylonite)"
+	bool
 	select PXA3xx
 	select PXA_SSP
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS

+config MACH_ZYLONITE300
+	bool "PXA3xx Development Platform (aka Zylonite) PXA300/310"
+	select CPU_PXA300
+	select CPU_PXA310
+	select MACH_ZYLONITE
+
+config MACH_ZYLONITE320
+	bool "PXA3xx Development Platform (aka Zylonite) PXA320"
+	select CPU_PXA320
+	select MACH_ZYLONITE
+
 config MACH_LITTLETON
 	bool "PXA3xx Form Factor Platform (aka Littleton)"
 	select PXA3xx
diff --git a/arch/arm/mach-pxa/Makefile b/arch/arm/mach-pxa/Makefile
index cdaf888..b5d29e6 100644
--- a/arch/arm/mach-pxa/Makefile
+++ b/arch/arm/mach-pxa/Makefile
@@ -29,11 +29,8 @@ obj-$(CONFIG_CPU_PXA930)	+= pxa930.o
 # Intel/Marvell Dev Platforms
 obj-$(CONFIG_ARCH_LUBBOCK)	+= lubbock.o
 obj-$(CONFIG_MACH_MAINSTONE)	+= mainstone.o
-ifeq ($(CONFIG_MACH_ZYLONITE),y)
-  obj-y				+= zylonite.o
-  obj-$(CONFIG_CPU_PXA300)	+= zylonite_pxa300.o
-  obj-$(CONFIG_CPU_PXA320)	+= zylonite_pxa320.o
-endif
+obj-$(CONFIG_MACH_ZYLONITE300)	+= zylonite.o zylonite_pxa300.o
+obj-$(CONFIG_MACH_ZYLONITE320)	+= zylonite.o zylonite_pxa320.o
 obj-$(CONFIG_MACH_LITTLETON)	+= littleton.o
 obj-$(CONFIG_MACH_TAVOREVB)	+= tavorevb.o
 obj-$(CONFIG_MACH_SAAR)		+= saar.o
-- 
1.6.3.3
