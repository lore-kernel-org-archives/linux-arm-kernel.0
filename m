From: wangzhou.bry@gmail.com (Zhou Wang)
Date: Wed, 26 Nov 2014 14:43:31 +0800
Subject: [PATCH v2 1/2] ARM: hip04: set ARCH_NR_GPIO to 128
In-Reply-To: <1416984212-619-1-git-send-email-wangzhou.bry@gmail.com>
References: <1416984212-619-1-git-send-email-wangzhou.bry@gmail.com>
Message-ID: <1416984212-619-2-git-send-email-wangzhou.bry@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set ARCH_NR_GPIO for Hisilicon Soc Hip04, which has 4 GPIO
controllers with 32 GPIOs each.

Signed-off-by: Zhou Wang <wangzhou.bry@gmail.com>
---
 arch/arm/Kconfig           |    1 +
 arch/arm/mach-hisi/Kconfig |    1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 89c4b5c..26aae1e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1509,6 +1509,7 @@ config ARCH_NR_GPIO
 	default 352 if ARCH_VT8500
 	default 288 if ARCH_ROCKCHIP
 	default 264 if MACH_H4700
+	default 128 if ARCH_HIP04
 	default 0
 	help
 	  Maximum number of GPIOs in the system.
diff --git a/arch/arm/mach-hisi/Kconfig b/arch/arm/mach-hisi/Kconfig
index cd19433..ed4542a 100644
--- a/arch/arm/mach-hisi/Kconfig
+++ b/arch/arm/mach-hisi/Kconfig
@@ -28,6 +28,7 @@ config ARCH_HIP04
 	select HAVE_ARM_ARCH_TIMER
 	select MCPM if SMP
 	select MCPM_QUAD_CLUSTER if SMP
+	select GPIO_DWAPB
 	help
 	  Support for Hisilicon HiP04 SoC family
 
-- 
1.7.9.5
