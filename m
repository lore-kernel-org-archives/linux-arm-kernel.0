From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 May 2018 13:18:09 +0200
Subject: [PATCH 11/14] arm: shmobile: Change platform dependency to
 ARCH_RENESAS
In-Reply-To: <cover.1526639075.git.horms+renesas@verge.net.au>
References: <cover.1526639075.git.horms+renesas@verge.net.au>
Message-ID: <d9be9ceb1f72c7ac216ba164b6b15cf19e6e56b4.1526639075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Since commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
ARCH_RENESAS is a more appropriate platform dependency than the legacy
ARCH_SHMOBILE, hence use the former.

This will allow to drop ARCH_SHMOBILE on ARM in the near future.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/Kconfig  | 2 +-
 arch/arm/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7f8e7f4b88f..2d34c0a44877 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1467,7 +1467,7 @@ config ARM_PSCI
 config ARCH_NR_GPIO
 	int
 	default 2048 if ARCH_SOCFPGA
-	default 1024 if ARCH_BRCMSTB || ARCH_SHMOBILE || ARCH_TEGRA || \
+	default 1024 if ARCH_BRCMSTB || ARCH_RENESAS || ARCH_TEGRA || \
 		ARCH_ZYNQ
 	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
 		SOC_DRA7XX || ARCH_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index e4e537f27339..a92f5a876d96 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -212,7 +212,7 @@ machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx
 machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
 machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
 machine-$(CONFIG_ARCH_SA1100)		+= sa1100
-machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
+machine-$(CONFIG_ARCH_RENESAS)	 	+= shmobile
 machine-$(CONFIG_ARCH_SIRF)		+= prima2
 machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_ARCH_STI)		+= sti
-- 
2.11.0
