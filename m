From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 14 Feb 2012 13:39:39 -0700
Subject: [PATCH] ARM: tegra: select required CPU and L2 errata options
Message-ID: <1329251979-14805-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM IP revisions in Tegra are:
Tegra20: CPU r1p1, PL310 r2p0
Tegra30: CPU A01=r2p7/>=A02=r2p9, NEON r2p3-50, PL310 r3p1-50

Based on work by Olof Johansson, although the actual list of errata is
somewhat different here, since I added a bunch more and removed one PL310
erratum that doesn't seem applicable.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, should this be CC: stable?

 arch/arm/mach-tegra/Kconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 32b420a..1978f59 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -12,6 +12,13 @@ config ARCH_TEGRA_2x_SOC
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_742230
+	select ARM_ERRATA_751472
+	select ARM_ERRATA_754327
+	select ARM_ERRATA_764369
+	select PL310_ERRATA_727915 if CACHE_L2X0
+	select PL310_ERRATA_769419 if CACHE_L2X0
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
@@ -27,6 +34,11 @@ config ARCH_TEGRA_3x_SOC
 	select USB_ULPI if USB_SUPPORT
 	select USB_ULPI_VIEWPORT if USB_SUPPORT
 	select USE_OF
+	select ARM_ERRATA_743622
+	select ARM_ERRATA_751472
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_764369
+	select PL310_ERRATA_769419 if CACHE_L2X0
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
 	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
-- 
1.7.0.4
