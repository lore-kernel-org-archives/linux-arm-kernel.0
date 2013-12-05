From: tim.kryger@linaro.org (Tim Kryger)
Date: Thu, 5 Dec 2013 15:30:55 -0800
Subject: [RESEND PATCH] ARM: bcm_defconfig: Do not expect appended DTB
Message-ID: <1386286255-4338-1-git-send-email-tim.kryger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bootloaders used with Broadcom mobile SoCs are capable of handling
a device tree separately from the zImage so there is no need for this
option to be enabled.

Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
Reviewed-by: Markus Mayer <markus.mayer@linaro.org>
---
 arch/arm/configs/bcm_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
index 6e49310..b152367 100644
--- a/arch/arm/configs/bcm_defconfig
+++ b/arch/arm/configs/bcm_defconfig
@@ -35,7 +35,6 @@ CONFIG_AEABI=y
 # CONFIG_COMPACTION is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
-CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 mem=128M"
 CONFIG_CPU_IDLE=y
 CONFIG_VFP=y
-- 
1.8.0.1
