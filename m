From: josh.cartwright@ni.com (Josh Cartwright)
Date: Thu, 24 Jan 2013 12:59:22 -0600
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: remove unnecessary CONFIG_GPIOLIB
Message-ID: <bb37ce3392153c4cae3a2bc642f831683620473a.1359057921.git.josh.cartwright@ni.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 38669e045dbf8f62a008898a7fb1e93975b3817c ("ARM: vexpress: Start
using new Versatile Express infrastructure") introduces a hard
dependency to GPIOLIB for the multi_v7_defconfig:

   ARCH_MULTI_V7 -> ARCH_VEXPRESS -> ARCH_REQUIRE_GPIOLIB -> GPIOLIB

Remove unnecessary explicit CONFIG_GPIOLIB=y from multi_v7_defconfig.

Signed-off-by: Josh Cartwright <josh.cartwright@ni.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2eeff1e..6862e76 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -39,7 +39,6 @@ CONFIG_I2C=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
-CONFIG_GPIOLIB=y
 CONFIG_FB=y
 CONFIG_FB_ARMCLCD=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-- 
1.8.1.1
