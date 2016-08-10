From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2016 10:52:12 +0200
Subject: [PATCH] ARM: defconfig: update the Integrator defconfig
Message-ID: <1470819132-27804-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Integrators defconfig have changed due to changes in
Kconfig for the CPU types, they use the physmap OF NOR
driver and syscon for LEDs.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC folks: please apply this directly to wherever
defconfig updates go.
---
 arch/arm/configs/integrator_defconfig | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 71f14675d009..869faae67201 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -13,15 +13,8 @@ CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
-CONFIG_ARCH_INTEGRATOR_CP=y
 CONFIG_INTEGRATOR_IMPD1=y
-CONFIG_CPU_ARM720T=y
-CONFIG_CPU_ARM920T=y
-CONFIG_CPU_ARM922T=y
-CONFIG_CPU_ARM926T=y
-CONFIG_CPU_ARM1020=y
-CONFIG_CPU_ARM1022=y
-CONFIG_CPU_ARM1026=y
+CONFIG_ARCH_INTEGRATOR_CP=y
 CONFIG_PCI=y
 CONFIG_PREEMPT=y
 CONFIG_AEABI=y
@@ -33,7 +26,6 @@ CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
-CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -51,7 +43,7 @@ CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_ADV_OPTIONS=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_PROC_DEVICETREE=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -71,6 +63,7 @@ CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_SYSCON=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
-- 
2.7.4
