From: bhupesh.sharma@freescale.com (Bhupesh Sharma)
Date: Thu, 15 Oct 2015 12:17:41 +0530
Subject: [PATCH v3 01/12] arm64: Use generic Layerscape SoC family naming
In-Reply-To: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
References: <1444891672-32117-1-git-send-email-bhupesh.sharma@freescale.com>
Message-ID: <1444891672-32117-2-git-send-email-bhupesh.sharma@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Freescale will be a spinning-out a set of ARMv8 based SoCs which
will be based on a similar overall SoC architecture. So, this patch
converts the existing infrastructure in the arm64/dts, arm64/Kconfig
and arm64/configs to use the generic convention ARCH_LAYERSCAPE
in place of the more specific FSL_LS2085A, to save code duplication
later-on.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
---
 Documentation/devicetree/bindings/arm/fsl.txt |    4 ++--
 arch/arm64/Kconfig.platforms                  |    6 +++---
 arch/arm64/boot/dts/freescale/Makefile        |    2 +-
 arch/arm64/configs/defconfig                  |    2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.txt b/Documentation/devicetree/bindings/arm/fsl.txt
index 2a3ba73..744b4de 100644
--- a/Documentation/devicetree/bindings/arm/fsl.txt
+++ b/Documentation/devicetree/bindings/arm/fsl.txt
@@ -128,8 +128,8 @@ Example:
 		reg = <0x0 0x1ee0000 0x0 0x10000>;
 	};
 
-Freescale LS2085A SoC Device Tree Bindings
-------------------------------------------
+Freescale ARMv8 based Layerscape SoC family Device Tree Bindings
+----------------------------------------------------------------
 
 LS2085A ARMv8 based Simulator model
 Required root node properties:
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 967571d..4043c35 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -29,10 +29,10 @@ config ARCH_EXYNOS7
 	help
 	  This enables support for Samsung Exynos7 SoC family
 
-config ARCH_FSL_LS2085A
-	bool "Freescale LS2085A SOC"
+config ARCH_LAYERSCAPE
+	bool "ARMv8 based Freescale Layerscape SoC family"
 	help
-	  This enables support for Freescale LS2085A SOC.
+	  This enables support for the Freescale Layerscape SoC family.
 
 config ARCH_HISI
 	bool "Hisilicon SoC Family"
diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
index 4f2de3e7..fc6fca3c 100644
--- a/arch/arm64/boot/dts/freescale/Makefile
+++ b/arch/arm64/boot/dts/freescale/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_FSL_LS2085A) += fsl-ls2085a-simu.dtb
+dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-ls2085a-simu.dtb
  
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index fc97b84..49f416a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -34,7 +34,7 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
-CONFIG_ARCH_FSL_LS2085A=y
+CONFIG_ARCH_LAYERSCAPE=y
 CONFIG_ARCH_HISI=y
 CONFIG_ARCH_MEDIATEK=y
 CONFIG_ARCH_ROCKCHIP=y
-- 
1.7.9.5
