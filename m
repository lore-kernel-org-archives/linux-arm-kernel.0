From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 28 Dec 2012 12:25:47 -0200
Subject: [PATCH] ARM: mach-imx: Kconfig: Do not select Babbage for
 MACH_IMX51_DT
Message-ID: <1356704747-14845-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When mx51 dt support was added it was necessary to select MACH_MX51_BABBAGE in
order to get the mx51 dt built without errors.

At that time, there was no pinctrl support for mx51 yet.

Currently there is no need to select MACH_MX51_BABBAGE anymore.

Reported-by: Matt Sealy <matt@genesi-usa.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1ad0d76..ae3bd54 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -756,7 +756,6 @@ comment "i.MX51 machines:"
 
 config MACH_IMX51_DT
 	bool "Support i.MX51 platforms from device tree"
-	select MACH_MX51_BABBAGE
 	select SOC_IMX51
 	help
 	  Include support for Freescale i.MX51 based platforms
-- 
1.7.9.5
