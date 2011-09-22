From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 22 Sep 2011 16:27:25 +0300
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
Message-ID: <1316698045-23190-1-git-send-email-pdeschrijver@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch causes the kernel uncompressor to determine the physical address
of the SDRAM at runtime. This allows the kernel to boot on both tegra2 and
tegra3 even though SDRAM is at different physical addresses on both SoCs.

Change-Id: I91857a590946bbc54168c04bea3a5bd576d87824
Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 arch/arm/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4fda167..9fc0678 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -600,6 +600,7 @@ config ARCH_TEGRA
 	select HAVE_CLK
 	select HAVE_SCHED_CLOCK
 	select ARCH_HAS_CPUFREQ
+	select AUTO_ZRELADDR
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
-- 
1.7.7.rc0.72.g4b5ea.dirty
