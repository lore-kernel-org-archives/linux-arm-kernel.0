From: david@lechnology.com (David Lechner)
Date: Mon, 15 Jan 2018 11:29:31 -0600
Subject: [PATCH] ARM: davinci_all_defconfig: set CONFIG_DAVINCI_WATCHDOG=y
Message-ID: <1516037371-3932-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes CONFIG_DAVINCI_WATCHDOG from a module to a compiled-in
option. Since the reset function has been moved out of the mach code in
commit 0808d3260456 ("ARM: davinci: remove watchdog reset") and into the
watchdog driver, devices cannot reboot unless the watchdog driver is
loaded, so make it a compiled-in option so that we can always reboot, even
when modules are not loaded.

Cc: Sekhar Nori <nsekhar@ti.com>
Suggested-by: Adam Ford <aford173@gmail.com>
Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 62f853f..b400670 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -138,7 +138,7 @@ CONFIG_POWER_RESET_GPIO=y
 CONFIG_SYSCON_REBOOT_MODE=m
 CONFIG_BATTERY_LEGO_EV3=m
 CONFIG_WATCHDOG=y
-CONFIG_DAVINCI_WATCHDOG=m
+CONFIG_DAVINCI_WATCHDOG=y
 CONFIG_MFD_DM355EVM_MSP=y
 CONFIG_TPS6507X=y
 CONFIG_REGULATOR=y
-- 
2.7.4
