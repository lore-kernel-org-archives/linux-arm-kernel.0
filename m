From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 21 Jul 2014 10:36:11 +0200
Subject: [PATCH 3/3] ARM: exynos_defconfig: Enable cpuidle driver
In-Reply-To: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
References: <1405931771-24100-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1405931771-24100-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpuidle driver for Exynos supports all SoCs now. AFTR is supported
only on Exynos4210 and Exynos5250 (WFI is used on other). Add the driver
to default exynos config.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index fc7d1683bf67..237434e26565 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -24,6 +24,12 @@ CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
+CONFIG_CPU_IDLE=y
+CONFIG_CPU_IDLE_MULTIPLE_DRIVERS=y
+CONFIG_CPU_IDLE_GOV_LADDER=y
+CONFIG_CPU_IDLE_GOV_MENU=y
+CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
+CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_RUNTIME=y
-- 
1.9.1
