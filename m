From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 20 May 2016 12:07:29 -0700
Subject: [PATCH 4/7] ARM: multi_v7_defconfig: Enable BCM7038 Watchdog
In-Reply-To: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
References: <1463771252-12805-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1463771252-12805-5-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The BCM7038 watchdog is used by all Broadcom STB SoCs but is not needed
for system reboot, we just turn it on as a module.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 07ad8f9a033b..13e5af6334ac 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -457,6 +457,7 @@ CONFIG_MESON_WATCHDOG=y
 CONFIG_DW_WATCHDOG=y
 CONFIG_DIGICOLOR_WATCHDOG=y
 CONFIG_BCM2835_WDT=y
+CONFIG_BCM7038_WDT=m
 CONFIG_MFD_AS3711=y
 CONFIG_MFD_AS3722=y
 CONFIG_MFD_ATMEL_FLEXCOM=y
-- 
2.7.4
