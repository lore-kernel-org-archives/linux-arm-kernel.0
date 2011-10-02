From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 16:45:52 +0200
Subject: [PATCH 22/30] mfd: build twl6030 only on omap2
In-Reply-To: <1317566760-25681-1-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
Message-ID: <1317566760-25681-23-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can only have one pwm driver built into the kernel, so make sure
that this one is only available on omap2 to avoid conflicts with
pwm drivers of other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Balaji T K <balajitk@ti.com>
Cc: Hemanth V <hemanthv@ti.com>
---
 drivers/mfd/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 48cce35..26bebe8 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -256,8 +256,8 @@ config MFD_TWL4030_AUDIO
 	default n
 
 config TWL6030_PWM
-	tristate "TWL6030 PWM (Pulse Width Modulator) Support"
-	depends on TWL4030_CORE
+	bool "TWL6030 PWM (Pulse Width Modulator) Support"
+	depends on TWL4030_CORE && ARCH_OMAP2
 	select HAVE_PWM
 	default n
 	help
-- 
1.7.5.4
