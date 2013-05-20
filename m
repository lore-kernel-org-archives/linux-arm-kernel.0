From: gang.chen@asianux.com (Chen Gang)
Date: Mon, 20 May 2013 16:54:07 +0800
Subject: [PATCH] ARM: S5PV210: dependency issue,
 S5P_SLEEP is depend on ARM_CPU_SUSPEND
Message-ID: <5199E4AF.7040607@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


When randconfig with MMU for arm s5pv210 (and select all cpu type),
need let S5P_SLEEP depend on ARM_CPU_SUSPEND, or will cause issue below:

  arch/arm/plat-samsung/built-in.o: In function `s3c_cpu_resume':
  arch/arm/plat-samsung/s5p-sleep.S:83: undefined reference to `cpu_resume'


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/plat-samsung/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index f8ed2de..1d38541 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -483,6 +483,7 @@ config S5P_PM
 
 config S5P_SLEEP
 	bool
+	select ARM_CPU_SUSPEND
 	help
 	  Internal config node to apply common S5P sleep management code.
 	  Can be selected by S5P and newer SoCs with similar sleep procedure.
-- 
1.7.7.6
