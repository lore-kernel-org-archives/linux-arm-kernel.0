From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 24 Apr 2014 08:34:36 -0300
Subject: [PATCH] ARM: mvebu: Select HAVE_ARM_TWD only if SMP is enabled
Message-ID: <1398339276-5754-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HAVE_ARM_TWD depends on SMP, so we should only select it if
SMP is enabled, as the others platforms do.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 arch/arm/mach-mvebu/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 7bb92b1..8c9fd60 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -41,7 +41,7 @@ config MACH_ARMADA_375
 	select ARMADA_375_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_375
@@ -57,7 +57,7 @@ config MACH_ARMADA_38X
 	select ARMADA_38X_CLK
 	select CPU_V7
 	select HAVE_ARM_SCU
-	select HAVE_ARM_TWD
+	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MACH_MVEBU_V7
 	select PINCTRL_ARMADA_38X
-- 
1.9.1
