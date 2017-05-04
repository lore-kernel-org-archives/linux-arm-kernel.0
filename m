From: marex@denx.de (Marek Vasut)
Date: Thu,  4 May 2017 12:26:30 +0200
Subject: [PATCH] ARM: socfpga: Increase max number of GPIOs
Message-ID: <20170504102630.10487-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the maximum number of GPIOs on SoCFPGA as this platform
can have many GPIO controllers in the FPGA part.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c1a35f15838..108c203a8b29 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1460,6 +1460,7 @@ config ARM_PSCI
 # selected platforms.
 config ARCH_NR_GPIO
 	int
+	default 2048 if ARCH_SOCFPGA
 	default 1024 if ARCH_BRCMSTB || ARCH_SHMOBILE || ARCH_TEGRA || \
 		ARCH_ZYNQ
 	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 || \
-- 
2.11.0
