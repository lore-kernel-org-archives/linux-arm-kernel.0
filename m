From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Dec 2010 19:18:55 +0000
Subject: [PATCH] TWD: enable one-shot mode
Message-ID: <20101224191855.GJ20587@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow one shot timer mode to be used with the TWD.  This allows
NOHZ mode to be used on SMP systems using the TWD localtimer.

Tested on Versatile Express.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
Acks/Tested-by's would be appreciated, thanks.

Merry Christmas.

 arch/arm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5634dce..4a6c4d7 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1282,6 +1282,7 @@ config HAVE_ARM_SCU
 config HAVE_ARM_TWD
 	bool
 	depends on SMP
+	select TICK_ONESHOT
 	help
 	  This options enables support for the ARM timer and watchdog unit
 
