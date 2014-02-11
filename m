From: robherring2@gmail.com (Rob Herring)
Date: Tue, 11 Feb 2014 15:11:54 -0600
Subject: [PATCH 4/9] ARM: Select V6K instead of V6 by default for
 multi-platform
In-Reply-To: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
References: <1392153119-23248-1-git-send-email-robherring2@gmail.com>
Message-ID: <1392153119-23248-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

MULTI_V6 should default to V6K as it is more optimal than V6. Any
platform which is not V6K should select CPU_V6 which will enable the
less optimal code paths.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Anton Vorontsov <anton@enomsg.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                | 2 +-
 arch/arm/mach-cns3xxx/Kconfig   | 2 +-
 arch/arm/mach-imx/Kconfig       | 1 -
 arch/arm/mach-picoxcell/Kconfig | 1 -
 4 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7560be4..f350ca5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -910,7 +910,7 @@ config ARCH_MULTI_V4_V5
 config ARCH_MULTI_V6
 	bool "ARMv6 based platforms (ARM11)"
 	select ARCH_MULTI_V6_V7
-	select CPU_V6
+	select CPU_V6K
 
 config ARCH_MULTI_V7
 	bool "ARMv7 based platforms (Cortex-A, PJ4, Scorpion, Krait)"
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index c6f58a1..b16b29a 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -1,9 +1,9 @@
 config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
 	select ARM_GIC
-	select CPU_V6K
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
+	select CPU_V6
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index ff24473..41ffd43 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -114,7 +114,6 @@ config SOC_IMX31
 config SOC_IMX35
 	bool
 	select ARCH_MXC_IOMUX_V3
-	select CPU_V6K
 	select HAVE_EPIT
 	select MXC_AVIC
 	select SMP_ON_UP if SMP
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index c88ff74..eca9eb1 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -2,7 +2,6 @@ config ARCH_PICOXCELL
 	bool "Picochip PicoXcell" if ARCH_MULTI_V6
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
-	select CPU_V6K
 	select DW_APB_TIMER_OF
 	select HAVE_TCM
 	select NO_IOPORT
-- 
1.8.3.2
