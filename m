From: otavio@ossystems.com.br (Otavio Salvador)
Date: Wed, 11 Jul 2012 12:52:35 -0300
Subject: [PATCH] ARM: imx6q: ensure ANATOP controller is available
Message-ID: <1342021955-9556-1-git-send-email-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During imx6q initialization the usb charger detector is disabled but
for it, ANATOP controller symbols need to be available.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
Cc: Richard Zhao <richard.zhao@freescale.com>
---
PS: I did a build from scratch to ensure MFD_ANATOP only is enough

 arch/arm/mach-imx/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f4b1709..5fdfa0a 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -832,6 +832,7 @@ config SOC_IMX6Q
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_IMX6Q
+	select MFD_ANATOP
 
 	help
 	  This enables support for Freescale i.MX6 Quad processor.
-- 
1.7.10.4
