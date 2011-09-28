From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 28 Sep 2011 04:07:47 +0300
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
Message-ID: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch causes the kernel uncompressor to determine the physical address
of the SDRAM at runtime. This allows the kernel to boot on both tegra20 and
tegra30 even though SDRAM is at different physical addresses on both SoCs.

Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 472a7f8..474737b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -596,6 +596,7 @@ config ARCH_TEGRA
 	select HAVE_CLK
 	select HAVE_SCHED_CLOCK
 	select ARCH_HAS_CPUFREQ
+	select AUTO_ZRELADDR
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
-- 
1.7.0.4
