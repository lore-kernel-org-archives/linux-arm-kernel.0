From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Jul 2011 00:15:23 +0200
Subject: [PATCH] mach-integrator: update defconfig
Message-ID: <1311891323-18021-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Integrator defconfig with some sensible defaults:
- NOHZ (tickless) and HRTIMERS turned on
- Compile using EABI, let's assume recent compilers are used
  now (tested using GCC 4.4.1)
- Remove forced 32MiB at command line, the bootloader usually
  knows this better
- Enable the MTD Physmap flash driver, so that the changes done
  earlier by Marc Zyngier replacing integrator-flash takes
  effect

This has been tested on the real hardware Integrator AP with an
ARM920T core module.

Cc: Marc Zyngier <Marc.Zyngier@arm.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 7196ade..baf4301 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -1,5 +1,6 @@
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
+CONFIG_TINY_RCU=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
@@ -11,17 +12,20 @@ CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_CPU_ARM720T=y
 CONFIG_CPU_ARM920T=y
 CONFIG_PCI=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_PREEMPT=y
+CONFIG_AEABI=y
 CONFIG_LEDS=y
 CONFIG_LEDS_CPU=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_CMDLINE="console=ttyAM0,38400n8 root=/dev/nfs ip=bootp mem=32M"
+CONFIG_CMDLINE="console=ttyAM0,38400n8 root=/dev/nfs ip=bootp"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_FPE_NWFPE=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -32,7 +36,6 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_AFS_PARTS=y
 CONFIG_MTD_CHAR=y
@@ -40,6 +43,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
+CONFIG_MTD_PHYSMAP=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -68,4 +72,3 @@ CONFIG_NFSD_V3=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
-CONFIG_DEBUG_ERRORS=y
-- 
1.7.6
