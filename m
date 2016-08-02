From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  2 Aug 2016 09:46:21 +0200
Subject: [PATCH] arm64: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
Message-ID: <1470123981-9800-1-git-send-email-linus.walleij@linaro.org>
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
I see you must have missed this patch. Please ACK this rebased
version so I can send it upstream in this (v4.8) merge window.
---
 arch/arm64/Kconfig           |  1 -
 arch/arm64/Kconfig.platforms | 12 ++++++------
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9f8b99e20557..227a6171fce4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,7 +14,6 @@ config ARM64
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index bb2616b16157..4fb0bef0f094 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -15,8 +15,8 @@ config ARCH_ALPINE
 
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_OF
+	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_BCM2835
 	select ARM_AMBA
@@ -29,15 +29,15 @@ config ARCH_BCM2835
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
@@ -108,7 +108,7 @@ config ARCH_QCOM
 config ARCH_ROCKCHIP
 	bool "Rockchip Platforms"
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
 	select ROCKCHIP_TIMER
@@ -154,11 +154,11 @@ config ARCH_STRATIX10
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
@@ -183,8 +183,8 @@ config ARCH_UNIPHIER
 
 config ARCH_VEXPRESS
 	bool "ARMv8 software model (Versatile Express)"
-	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_VERSATILE
+	select GPIOLIB
 	select PM
 	select PM_GENERIC_DOMAINS
 	select POWER_RESET_VEXPRESS
-- 
2.7.4
