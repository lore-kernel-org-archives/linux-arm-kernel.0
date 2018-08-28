From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 28 Aug 2018 17:10:10 +0200
Subject: [PATCH v2 1/2] ARM: shmobile: Remove the ARCH_SHMOBILE Kconfig symbol
In-Reply-To: <20180828151011.14065-1-geert+renesas@glider.be>
References: <20180828151011.14065-1-geert+renesas@glider.be>
Message-ID: <20180828151011.14065-2-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All drivers for Renesas ARM SoCs have gained proper ARCH_RENESAS
platform dependencies.  Hence finish the conversion from ARCH_SHMOBILE
to ARCH_RENESAS for Renesas 32-bit ARM SoCs, as started by commit
9b5ba0df4ea4f940 ("ARM: shmobile: Introduce ARCH_RENESAS").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
v2:
  - Add Acked-by,
  - Drop RFC, now all dependencies have been merged,
  - Rebase.

JFTR, after this, the following symbols for drivers supporting only
Renesas SuperH "SH-Mobile" SoCs can no longer be selected:
  - CONFIG_KEYBOARD_SH_KEYSC,
  - CONFIG_VIDEO_SH_VOU,
  - CONFIG_DRM_SHMOBILE[*].
(changes for a shmobile_defconfig .config)

[*] CONFIG_DRM_SHMOBILE has a dependency on ARM, but it was never wired
    up.
    From the use of sh_mobile_meram, I guess it was meant for SH-Mobile
    AP4 on Mackerel or AP4EVB, which are long gone.  So the only
    remaining upstream platforms that could make use of it are legacy
    SuperH SH-Mobile SoCs.
---
 arch/arm/mach-shmobile/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 94e9431d92b87405..1dfe3b80bae9e4fd 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,6 +1,3 @@
-config ARCH_SHMOBILE
-	bool
-
 config PM_RMOBILE
 	bool
 	select PM
@@ -30,7 +27,6 @@ config ARCH_RMOBILE
 menuconfig ARCH_RENESAS
 	bool "Renesas ARM SoCs"
 	depends on ARCH_MULTI_V7 && MMU
-	select ARCH_SHMOBILE
 	select ARM_GIC
 	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
-- 
2.17.1
