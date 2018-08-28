From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Aug 2018 17:10:11 +0200
Subject: [PATCH v2 2/2] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig symbol
In-Reply-To: <20180828151011.14065-1-geert+renesas@glider.be>
References: <20180828151011.14065-1-geert+renesas@glider.be>
Message-ID: <20180828151011.14065-3-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol for Renesas 64-bit ARM SoCs has always been
ARCH_RENESAS, with ARCH_SHMOBILE being selected to reuse drivers shared
with Renesas 32-bit ARM and/or Renesas SuperH SH-Mobile SoCs.

Commit 9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS")
started the conversion from ARCH_SHMOBILE to ARCH_RENESAS for Renesas
32-bit SoCs.  Now all drivers for Renesas ARM SoCs have gained proper
ARCH_RENESAS platform dependencies, there is no longer a need to select
ARCH_SHMOBILE.

With ARCH_SHMOBILE gone, move the ARCH_RENESAS section up, to restore
alphabetical sort order.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Drop RFC, now all dependencies have been merged,
  - Move ARCH_SYNQUACER after ARCH_STRATIX10,
  - Rebase.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_VIDEO_RENESAS_CEU.
(changes for a renesas_defconfig .config)
---
 arch/arm64/Kconfig.platforms | 44 ++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 531ea508aa6ba3f4..52610071fdc189bf 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -152,32 +152,8 @@ config ARCH_REALTEK
 	  This enables support for the ARMv8 based Realtek chipsets,
 	  like the RTD1295.
 
-config ARCH_ROCKCHIP
-	bool "Rockchip Platforms"
-	select ARCH_HAS_RESET_CONTROLLER
-	select GPIOLIB
-	select PINCTRL
-	select PINCTRL_ROCKCHIP
-	select PM
-	select ROCKCHIP_TIMER
-	help
-	  This enables support for the ARMv8 based Rockchip chipsets,
-	  like the RK3368.
-
-config ARCH_SEATTLE
-	bool "AMD Seattle SoC Family"
-	help
-	  This enables support for AMD Seattle SOC Family
-
-config ARCH_SHMOBILE
-	bool
-
-config ARCH_SYNQUACER
-	bool "Socionext SynQuacer SoC Family"
-
 config ARCH_RENESAS
 	bool "Renesas SoC Platforms"
-	select ARCH_SHMOBILE
 	select PINCTRL
 	select PM
 	select PM_GENERIC_DOMAINS
@@ -234,11 +210,31 @@ config ARCH_R8A77995
 	help
 	  This enables support for the Renesas R-Car D3 SoC.
 
+config ARCH_ROCKCHIP
+	bool "Rockchip Platforms"
+	select ARCH_HAS_RESET_CONTROLLER
+	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_ROCKCHIP
+	select PM
+	select ROCKCHIP_TIMER
+	help
+	  This enables support for the ARMv8 based Rockchip chipsets,
+	  like the RK3368.
+
+config ARCH_SEATTLE
+	bool "AMD Seattle SoC Family"
+	help
+	  This enables support for AMD Seattle SOC Family
+
 config ARCH_STRATIX10
 	bool "Altera's Stratix 10 SoCFPGA Family"
 	help
 	  This enables support for Altera's Stratix 10 SoCFPGA Family.
 
+config ARCH_SYNQUACER
+	bool "Socionext SynQuacer SoC Family"
+
 config ARCH_TEGRA
 	bool "NVIDIA Tegra SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
-- 
2.17.1
