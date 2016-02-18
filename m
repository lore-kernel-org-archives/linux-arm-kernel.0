From: chris.brandt@renesas.com (Chris Brandt)
Date: Thu, 18 Feb 2016 12:25:10 -0500
Subject: [PATCH] ARM: Allow MULTIPLATFORM to select XIP
Message-ID: <1455816310-11308-1-git-send-email-chris.brandt@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Multiplatform seems to be the way of the future, you should not restrict
from selecting XIP. Whether it makes sense or not depends on how you
configure the rest of the kernel (as in, removing individual platforms).
Also, it stands to reason that if you select MULTIPLATFORM and XIP_KERNEL,
you either know what you are doing...or have NO idea what you are doing.

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cc95ff8..2e4a127 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -327,7 +327,7 @@ config ARCH_MULTIPLATFORM
 	depends on MMU
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
-	select ARM_PATCH_PHYS_VIRT
+	select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
 	select COMMON_CLK
@@ -1919,7 +1919,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ARM_LPAE && !ARCH_MULTIPLATFORM
+	depends on !ARM_LPAE
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
-- 
1.9.1
