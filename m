From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  2 Jun 2016 14:14:30 +0200
Subject: [PATCH] arm64: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
Message-ID: <1464869670-7208-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces:

- "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
  now be selected directly.

- "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
  is now selectable by everyone, so we need not declare our
  intent to select it.

Cc: Michael B?sch <m@bues.ch>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM64/AArch64 maintainers:
Please apply this patch directly for cleanups.
---
 arch/arm64/Kconfig           |  1 -
 arch/arm64/Kconfig.platforms | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 76747d92bc72..2cfbf83b2498 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -12,7 +12,6 @@ config ARM64
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 7ef1d05859ae..fe66708e9a20 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -16,15 +16,15 @@ config ARCH_ALPINE
 config ARCH_BCM_IPROC
 	bool "Broadcom iProc SoC Family"
 	select COMMON_CLK_IPROC
+	select GPIOLIB
 	select PINCTRL
-	select ARCH_REQUIRE_GPIOLIB
 	help
 	  This enables support for Broadcom iProc based SoCs
 
 config ARCH_BERLIN
 	bool "Marvell Berlin SoC Family"
-	select ARCH_REQUIRE_GPIOLIB
 	select DW_APB_ICTL
+	select GPIOLIB
 	select PINCTRL
 	help
 	  This enables support for Marvell Berlin SoC Family
@@ -89,7 +89,7 @@ config ARCH_QCOM
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
 	select ROCKCHIP_TIMER
@@ -129,11 +129,11 @@ config ARCH_STRATIX10
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select HAVE_CLK
 	select PINCTRL
 	select RESET_CONTROLLER
@@ -158,8 +158,8 @@ config ARCH_UNIPHIER
 
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
-	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_VERSATILE
+	select GPIOLIB
 	select POWER_RESET_VEXPRESS
 	select VEXPRESS_CONFIG
 	help
-- 
2.4.11
