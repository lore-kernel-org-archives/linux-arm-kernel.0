From: olof@lixom.net (Olof Johansson)
Date: Wed,  4 Jan 2012 15:29:12 -0800
Subject: [PATCH] ARM: tegra: select required CPU and L2 errata options
Message-ID: <1325719752-818-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only one of the L2 erratas are needed on T30, but T20/25
needs a few more.

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 arch/arm/mach-tegra/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 373652d..a2c76ee 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -10,6 +10,9 @@ config ARCH_TEGRA_2x_SOC
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
+	select ARM_ERRATA_742230
+	select PL310_ERRATA_753970 if CACHE_PL310
+	select PL310_ERRATA_769419 if CACHE_L2X0
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
@@ -23,6 +26,7 @@ config ARCH_TEGRA_3x_SOC
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	select USE_OF
+	select PL310_ERRATA_769419 if CACHE_L2X0
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
-- 
1.7.8.GIT
