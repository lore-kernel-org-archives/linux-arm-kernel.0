From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 29 May 2017 09:22:21 +0200
Subject: [PATCH v2] soc: zte: Restrict SOC_ZTE to ARCH_ZX or COMPILE_TEST
Message-ID: <1496042541-2529-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ZTE SoC drivers are only useful when building for a ZTE ZX platform.

Fixes: 4c2c2e39713b8cfb ("soc: zte: pm_domains: Prepare for supporting ARMv8 zx2967 family")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Baoyou Xie <baoyou.xie@linaro.org>
---
v2:
  - Add Reviewed-by.
---
 drivers/soc/zte/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/zte/Kconfig b/drivers/soc/zte/Kconfig
index 20bde38ce2f912f5..e9d750c510cd9c90 100644
--- a/drivers/soc/zte/Kconfig
+++ b/drivers/soc/zte/Kconfig
@@ -2,6 +2,7 @@
 # ZTE SoC drivers
 #
 menuconfig SOC_ZTE
+	depends on ARCH_ZX || COMPILE_TEST
 	bool "ZTE SoC driver support"
 
 if SOC_ZTE
-- 
2.7.4
