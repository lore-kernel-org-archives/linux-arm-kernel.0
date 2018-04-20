From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 20 Apr 2018 15:28:34 +0200
Subject: [PATCH/RFC 8/8] arm64: renesas: Remove the ARCH_SHMOBILE Kconfig
 symbol
In-Reply-To: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
References: <1524230914-10175-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1524230914-10175-9-git-send-email-geert+renesas@glider.be>
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
---
This depends on the driver patches in this series, hence the RFC.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_VIDEO_RENESAS_CEU,
  - CONFIG_FB_SH_MOBILE_MERAM.
(changes for a renesas_defconfig .config)
---
 arch/arm64/Kconfig.platforms | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index d5aeac351fc3a776..49d8ed1ab84766dd 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -145,31 +145,8 @@ config ARCH_REALTEK
 	  This enables support for the ARMv8 based Realtek chipsets,
 	  like the RTD1295.
 
-config ARCH_ROCKCHIP
-	bool "Rockchip Platforms"
-	select ARCH_HAS_RESET_CONTROLLER
-	select GPIOLIB
-	select PINCTRL
-	select PINCTRL_ROCKCHIP
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
@@ -220,6 +197,25 @@ config ARCH_R8A77995
 	help
 	  This enables support for the Renesas R-Car D3 SoC.
 
+config ARCH_ROCKCHIP
+	bool "Rockchip Platforms"
+	select ARCH_HAS_RESET_CONTROLLER
+	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_ROCKCHIP
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
+config ARCH_SYNQUACER
+	bool "Socionext SynQuacer SoC Family"
+
 config ARCH_STRATIX10
 	bool "Altera's Stratix 10 SoCFPGA Family"
 	help
-- 
2.7.4
