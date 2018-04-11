From: ran.wang_1@nxp.com (Ran Wang)
Date: Wed, 11 Apr 2018 14:35:46 +0800
Subject: [PATCH v2 1/6] powerpc/pm: Fix suspend=n in menuconfig for e500mc
 platforms.
Message-ID: <20180411063551.30368-1-ran.wang_1@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also, unselect FSL_PMC which is for older platfroms instead.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - no change

 arch/powerpc/Kconfig |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 73ce5dd..ed60c83 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -316,7 +316,7 @@ config ARCH_HIBERNATION_POSSIBLE
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
-		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
+		   FSL_SOC_BOOKE || PPC_86xx || PPC_PSERIES \
 		   || 44x || 40x
 
 config PPC_DCR_NATIVE
@@ -940,8 +940,6 @@ config FSL_PCI
 
 config FSL_PMC
 	bool
-	default y
-	depends on SUSPEND && (PPC_85xx || PPC_86xx)
 	help
 	  Freescale MPC85xx/MPC86xx power management controller support
 	  (suspend/resume). For MPC83xx see platforms/83xx/suspend.c
-- 
1.7.1
