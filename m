From: benoit.thebaudeau@advansee.com (=?utf-8?Q?Beno=C3=AEt_Th=C3=A9baudeau?=)
Date: Wed, 27 Jun 2012 22:28:26 +0200 (CEST)
Subject: [PATCH] ARM: imx: fix i.MX35 CPU architecture
Message-ID: <147037481.185152.1340828906821.JavaMail.root@advansee.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The data sheet of the i.MX35 says it is an ARM1136JF-S processor, version r1p3,
which, according to section "B.1. New instructions" of the ARM1136JF-S and
ARM1136J-S Technical Reference Manual, makes the i.MX35 CPU architecture not
only ARMv6, but ARMv6k.

Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Beno?t Th?baudeau <benoit.thebaudeau@advansee.com>
---
 .../arch/arm/mach-imx/Kconfig                      |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/Kconfig linux-next-HEAD-49289f3/arch/arm/mach-imx/Kconfig
index eff4db5..0345e85 100644
--- linux-next-HEAD-49289f3.orig/arch/arm/mach-imx/Kconfig
+++ linux-next-HEAD-49289f3/arch/arm/mach-imx/Kconfig
@@ -73,7 +73,7 @@ config SOC_IMX31
 
 config SOC_IMX35
 	bool
-	select CPU_V6
+	select CPU_V6K
 	select ARCH_MXC_IOMUX_V3
 	select COMMON_CLK
 	select HAVE_EPIT
