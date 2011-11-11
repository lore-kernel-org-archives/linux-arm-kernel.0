From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 11 Nov 2011 15:37:14 +0800
Subject: [PATCH v2] arm/imx: fix the references to ARCH_MX3
In-Reply-To: <1320914372-4416-3-git-send-email-shawn.guo@linaro.org>
References: <1320914372-4416-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <1320997034-10051-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config symbol ARCH_MX3 has been removed by commit 'a89cf59
arm/imx: merge i.MX3 and i.MX6', and it should not be referenced
any more.

The patch also change ARCH_MX* to SOC_IMX* for other platforms.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
Changes since v1:
 * Drop changes on drivers/dma/Kconfig, as Sascha alreay has a patch
   to fix it.
 * Change ARCH_MX* to SOC_IMX* for other platforms as well.

 arch/arm/mach-imx/Makefile.boot |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index 22d8588..cfede57 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -1,22 +1,26 @@
-zreladdr-$(CONFIG_ARCH_MX1)	+= 0x08008000
-params_phys-$(CONFIG_ARCH_MX1)	:= 0x08000100
-initrd_phys-$(CONFIG_ARCH_MX1)	:= 0x08800000
+zreladdr-$(CONFIG_SOC_IMX1)	+= 0x08008000
+params_phys-$(CONFIG_SOC_IMX1)	:= 0x08000100
+initrd_phys-$(CONFIG_SOC_IMX1)	:= 0x08800000
 
-zreladdr-$(CONFIG_MACH_MX21)	+= 0xC0008000
-params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
-initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
+zreladdr-$(CONFIG_SOC_IMX21)	+= 0xC0008000
+params_phys-$(CONFIG_SOC_IMX21)	:= 0xC0000100
+initrd_phys-$(CONFIG_SOC_IMX21)	:= 0xC0800000
 
-zreladdr-$(CONFIG_ARCH_MX25)	+= 0x80008000
-params_phys-$(CONFIG_ARCH_MX25)	:= 0x80000100
-initrd_phys-$(CONFIG_ARCH_MX25)	:= 0x80800000
+zreladdr-$(CONFIG_SOC_IMX25)	+= 0x80008000
+params_phys-$(CONFIG_SOC_IMX25)	:= 0x80000100
+initrd_phys-$(CONFIG_SOC_IMX25)	:= 0x80800000
 
-zreladdr-$(CONFIG_MACH_MX27)	+= 0xA0008000
-params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
-initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
+zreladdr-$(CONFIG_SOC_IMX27)	+= 0xA0008000
+params_phys-$(CONFIG_SOC_IMX27)	:= 0xA0000100
+initrd_phys-$(CONFIG_SOC_IMX27)	:= 0xA0800000
 
-zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
-params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
-initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
+zreladdr-$(CONFIG_SOC_IMX31)	+= 0x80008000
+params_phys-$(CONFIG_SOC_IMX31)	:= 0x80000100
+initrd_phys-$(CONFIG_SOC_IMX31)	:= 0x80800000
+
+zreladdr-$(CONFIG_SOC_IMX35)	+= 0x80008000
+params_phys-$(CONFIG_SOC_IMX35)	:= 0x80000100
+initrd_phys-$(CONFIG_SOC_IMX35)	:= 0x80800000
 
 zreladdr-$(CONFIG_SOC_IMX6Q)	+= 0x10008000
 params_phys-$(CONFIG_SOC_IMX6Q)	:= 0x10000100
-- 
1.7.4.1
