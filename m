From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Oct 2013 15:52:34 +0200
Subject: [PATCH] ARM: integrator: update defconfig
Message-ID: <1381413154-16145-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the integrator defconfig, apart from the usual
re-shuffling of symbols due to restructuring of the kernel Kconfig
this will also:

- Enable IM-PD1 so all hardware is enabled out-of-the-box
- Enable the LEDs class and heartbeat trigger, so that the
  LED driver in plat-versatile/ is compiled.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/integrator_defconfig | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index a8314c3..ecd6161 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -1,15 +1,17 @@
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
-CONFIG_TINY_RCU=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
+CONFIG_PARTITION_ADVANCED=y
 CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_ARCH_INTEGRATOR_CP=y
+CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_CPU_ARM720T=y
 CONFIG_CPU_ARM920T=y
 CONFIG_CPU_ARM922T=y
@@ -44,24 +46,20 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_AFS_PARTS=y
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
+CONFIG_PROC_DEVICETREE=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
-CONFIG_NET_PCI=y
 CONFIG_E100=y
 CONFIG_SMC91X=y
 # CONFIG_KEYBOARD_ATKBD is not set
 # CONFIG_SERIO_SERPORT is not set
-CONFIG_SERIAL_AMBA_PL010=y
-CONFIG_SERIAL_AMBA_PL010_CONSOLE=y
 CONFIG_FB=y
 CONFIG_FB_MODE_HELPERS=y
 CONFIG_FB_ARMCLCD=y
-- 
1.8.3.1
