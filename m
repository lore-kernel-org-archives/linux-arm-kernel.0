From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Sep 2013 13:36:36 +0200
Subject: [PATCH] ARM: ux500: u8500_defconfig: add missing cpuidle option
Message-ID: <1380540996-18521-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the commit d3f2950f2adeea3da0317e952914b59adaa4cdb3, the option
ARM_U8500_CPUIDLE was added to the Kconfig but not reflected in the
default config file, hence the cpuidle driver is no longer enabled
since this commit.

Enable it again by adding the missing option in the default config file.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a0025dc..4bd93bf 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -20,6 +20,7 @@ CONFIG_CMDLINE="root=/dev/ram0 console=ttyAMA2,115200n8"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
+CONFIG_ARM_U8500_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_PM_RUNTIME=y
-- 
1.7.9.5
