From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 16:44:35 -0600
Subject: [PATCH] ARM: dt: tegra: rename board files to match SoC
Message-ID: <1339454675-927-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Most ARM ${board}.dts files are already named ${soc}-${board}.dts. This
change modifies the Tegra board files to be named the same way for
consistency.

Once a related change is made in U-Boot, this will cause both U-Boot and
the kernel to use the same names for the .dts files and SoC identifiers,
thus allowing U-Boot's recently added "soc" and "board" environment
variables to be used to construct the name of Tegra .dtb files, and hence
allow board-generic U-Boot bootcmd scripts to be written.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 .../dts/{tegra-harmony.dts => tegra20-harmony.dts} |    0
 .../dts/{tegra-paz00.dts => tegra20-paz00.dts}     |    0
 .../{tegra-seaboard.dts => tegra20-seaboard.dts}   |    0
 .../{tegra-trimslice.dts => tegra20-trimslice.dts} |    0
 .../dts/{tegra-ventana.dts => tegra20-ventana.dts} |    0
 .../dts/{tegra-cardhu.dts => tegra30-cardhu.dts}   |    0
 arch/arm/mach-tegra/Makefile.boot                  |   12 ++++++------
 7 files changed, 6 insertions(+), 6 deletions(-)
 rename arch/arm/boot/dts/{tegra-harmony.dts => tegra20-harmony.dts} (100%)
 rename arch/arm/boot/dts/{tegra-paz00.dts => tegra20-paz00.dts} (100%)
 rename arch/arm/boot/dts/{tegra-seaboard.dts => tegra20-seaboard.dts} (100%)
 rename arch/arm/boot/dts/{tegra-trimslice.dts => tegra20-trimslice.dts} (100%)
 rename arch/arm/boot/dts/{tegra-ventana.dts => tegra20-ventana.dts} (100%)
 rename arch/arm/boot/dts/{tegra-cardhu.dts => tegra30-cardhu.dts} (100%)

diff --git a/arch/arm/boot/dts/tegra-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra-harmony.dts
rename to arch/arm/boot/dts/tegra20-harmony.dts
diff --git a/arch/arm/boot/dts/tegra-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra-paz00.dts
rename to arch/arm/boot/dts/tegra20-paz00.dts
diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra20-seaboard.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra-seaboard.dts
rename to arch/arm/boot/dts/tegra20-seaboard.dts
diff --git a/arch/arm/boot/dts/tegra-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra-trimslice.dts
rename to arch/arm/boot/dts/tegra20-trimslice.dts
diff --git a/arch/arm/boot/dts/tegra-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra-ventana.dts
rename to arch/arm/boot/dts/tegra20-ventana.dts
diff --git a/arch/arm/boot/dts/tegra-cardhu.dts b/arch/arm/boot/dts/tegra30-cardhu.dts
similarity index 100%
rename from arch/arm/boot/dts/tegra-cardhu.dts
rename to arch/arm/boot/dts/tegra30-cardhu.dts
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index 9a82094..8040345 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -2,9 +2,9 @@ zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= 0x00008000
 params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
 
-dtb-$(CONFIG_MACH_HARMONY) += tegra-harmony.dtb
-dtb-$(CONFIG_MACH_PAZ00) += tegra-paz00.dtb
-dtb-$(CONFIG_MACH_SEABOARD) += tegra-seaboard.dtb
-dtb-$(CONFIG_MACH_TRIMSLICE) += tegra-trimslice.dtb
-dtb-$(CONFIG_MACH_VENTANA) += tegra-ventana.dtb
-dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra-cardhu.dtb
+dtb-$(CONFIG_MACH_HARMONY) += tegra20-harmony.dtb
+dtb-$(CONFIG_MACH_PAZ00) += tegra20-paz00.dtb
+dtb-$(CONFIG_MACH_SEABOARD) += tegra20-seaboard.dtb
+dtb-$(CONFIG_MACH_TRIMSLICE) += tegra20-trimslice.dtb
+dtb-$(CONFIG_MACH_VENTANA) += tegra20-ventana.dtb
+dtb-$(CONFIG_ARCH_TEGRA_3x_SOC) += tegra30-cardhu.dtb
-- 
1.7.0.4
