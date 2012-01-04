From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed,  4 Jan 2012 01:39:54 +0100
Subject: [PATCH] mach-integrator: defconfig for both AP and CP
Message-ID: <1325637594-20818-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the Integrator defconfig to include the hardware
found on the Integrator/CP: SMC91X, CLCD, MMCI/PL180. Further
the sometimes disrupting VGA_CONSOLE is disabled (those who
have a VGA card can enable it) and typical default VFAT
layouts of the MMC cards are supported by enabling VFAT and
CP437 encoding of the file system.

After this my default kernels boot successfully on Integrator
AP and CP alike.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 1103f62..a8314c3 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -57,18 +57,24 @@ CONFIG_NETDEVICES=y
 CONFIG_NET_ETHERNET=y
 CONFIG_NET_PCI=y
 CONFIG_E100=y
+CONFIG_SMC91X=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIAL_AMBA_PL010=y
 CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
+CONFIG_FB_ARMCLCD=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
 CONFIG_FB_MATROX_MYSTIQUE=y
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_MMC=y
+CONFIG_MMC_ARMMMCI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_PL030=y
 CONFIG_EXT2_FS=y
+CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
 CONFIG_CRAMFS=y
@@ -78,5 +84,7 @@ CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_ISO8859_1=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-- 
1.7.6.4
