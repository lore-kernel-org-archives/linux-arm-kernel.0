From: scott.branden@broadcom.com (Scott Branden)
Date: Wed, 29 Aug 2018 10:21:27 -0700
Subject: [PATCH] arm64: defconfig: enable EFI_ARMSTUB_DTB_LOADER
Message-ID: <1535563287-24803-1-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable EFI_ARMSTUB_DTB_LOADER to add support for the dtb= command line
parameter to function with efi loader.

Required to boot on existing bootloaders that do not support devicetree
provided by the platform or by the bootloader.

Fixes: 3d7ee348aa41 ("efi/libstub/arm: Add opt-in Kconfig option for the DTB loader")
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f67e8d5..157cac9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -114,6 +114,7 @@ CONFIG_ARM_ARMADA_37XX_CPUFREQ=y
 CONFIG_ARM_BIG_LITTLE_CPUFREQ=y
 CONFIG_ARM_SCPI_CPUFREQ=y
 CONFIG_ARM_TEGRA186_CPUFREQ=y
+CONFIG_EFI_ARMSTUB_DTB_LOADER=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
-- 
2.5.0
