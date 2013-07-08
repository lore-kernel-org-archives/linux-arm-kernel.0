From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  8 Jul 2013 18:38:09 -0300
Subject: [PATCH] ARM: Kconfig: Let ARM_ERRATA_364296 not depend on CONFIG_SMP
Message-ID: <1373319489-9467-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx_v6_v7_defconfig handles both multi-core and single-core SoCs, and it has 
CONFIG_SMP=y selected by default.

With such config we cannot select ARM_ERRATA_364296, as it depends on !SMP.

Let ARM_ERRATA_364296 be undependent on CONFIG_SMP, so that we can select
this erratum for the ARM1136 SoCs, even if CONFIG_SMP=y is enabled.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0ac9be6..ba412e0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1316,7 +1316,7 @@ config ARM_ERRATA_754327
 
 config ARM_ERRATA_364296
 	bool "ARM errata: Possible cache data corruption with hit-under-miss enabled"
-	depends on CPU_V6 && !SMP
+	depends on CPU_V6
 	help
 	  This options enables the workaround for the 364296 ARM1136
 	  r0p2 erratum (possible cache data corruption with
-- 
1.8.1.2
