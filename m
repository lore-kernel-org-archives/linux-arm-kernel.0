From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 21 Oct 2015 17:11:05 +0800
Subject: [PATCH] bus: sunxi-rsb: Allow building sunxi-rsb as a module
Message-ID: <1445418665-14138-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner Reduced Serial Bus support is only needed for sun[89]i
platforms. Having it built-in for multi-platform kernels leads to
a bigger kernel image, without any benefit for non sun[89]i systems.

The driver already exports the needed symbols and supports module
loading/unloading. Change the Kconfig symbol to tristate to allow
the user to build it as a module.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---

Hi Arnd,

Maxime requested we make the RSB driver and subsequent PMIC drivers
tristate. Please squash this patch into patch 2 of the RSB series
when you apply them.


Thanks
ChenYu

---
 drivers/bus/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/Kconfig b/drivers/bus/Kconfig
index e921b8c72f8c..78382de19ed9 100644
--- a/drivers/bus/Kconfig
+++ b/drivers/bus/Kconfig
@@ -122,7 +122,7 @@ config SIMPLE_PM_BUS
 	  "External Bus Interface") as found on several Renesas ARM SoCs.
 
 config SUNXI_RSB
-	bool "Allwinner sunXi Reduced Serial Bus Driver"
+	tristate "Allwinner sunXi Reduced Serial Bus Driver"
 	  default MACH_SUN8I || MACH_SUN9I
 	  depends on ARCH_SUNXI
 	  select REGMAP
-- 
2.6.1
