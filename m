From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 14 Feb 2013 15:01:30 +0100
Subject: [PATCH] ARM: kirkwood: add missing include for nsa310
Message-ID: <1360850491-1463387-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 92cb7625 "ARM: kirkwood: nsa310: cleanup includes and
unneeded code" was a little too quick, since there is still
an I2C_BOARD_INFO left in this file at the moment. Once
that is gone and replaced by a DT description of the devices,
the inclusion can be removed again

Without this patch, building kirkwood_defconfig results in:

arch/arm/mach-kirkwood/board-nsa310.c:42:74: error: array type has incomplete element type
arch/arm/mach-kirkwood/board-nsa310.c:43:2: error: implicit declaration of function 'I2C_BOARD_INFO' [-Werror=implicit-function-declaration]
arch/arm/mach-kirkwood/board-nsa310.c: In function 'nsa310_gpio_init':
arch/arm/mach-kirkwood/board-nsa310.c:71:3: error: 'pm_power_off' undeclared (first use in this function)
arch/arm/mach-kirkwood/board-nsa310.c:71:3: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-kirkwood/board-nsa310.c: In function 'nsa310_init':
arch/arm/mach-kirkwood/board-nsa310.c:83:2: error: implicit declaration of function 'i2c_register_board_info' [-Werror=implicit-function-declaration]
arch/arm/mach-kirkwood/board-nsa310.c:83:121: error: negative width in bit-field '<anonymous>'
arch/arm/mach-kirkwood/board-nsa310.c: At top level:
arch/arm/mach-kirkwood/board-nsa310.c:42:74: warning: 'nsa310_i2c_info' defined but not used [-Wunused-variable]
cc1: some warnings being treated as errors

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm/mach-kirkwood/board-nsa310.c | 1 +
 1 file changed, 1 insertion(+)


This file has been broken for a while in arm-soc,
so I'm applying the obvious fix directly to the
next/cleanup branch that introduced the problem.

diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
index 61c4b18..970174a 100644
--- a/arch/arm/mach-kirkwood/board-nsa310.c
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/gpio.h>
+#include <linux/i2c.h>
 #include <mach/kirkwood.h>
 #include <linux/of.h>
 #include "common.h"
-- 
1.8.1.2
