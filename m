From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:07 +0100
Subject: [PATCH 54/69] clocksource/drivers/h8300_timer8: Separate the Kconfig
 option from the arch
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-54-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current Kconfig option is the H8300 arch option. In order to comply to the
current rule, let's create a specific option for the timer8 and select it
from the arch's Kconfig.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/h8300/Kconfig           | 1 +
 drivers/clocksource/Kconfig  | 3 +++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index dd3ac75..2e20333 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -17,6 +17,7 @@ config H8300
 	select HAVE_MEMBLOCK
 	select HAVE_DMA_ATTRS
 	select CLKSRC_OF
+	select H8300_TMR8
 
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index de331b8..73477b5 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -362,6 +362,9 @@ config CLKSRC_PXA
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
 
+config H8300_TMR8
+        bool
+
 config H8300_TMR16
         bool
 
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index 56bd16e..dc2b899 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -60,7 +60,7 @@ obj-$(CONFIG_CLKSRC_MIPS_GIC)		+= mips-gic-timer.o
 obj-$(CONFIG_CLKSRC_TANGO_XTAL)		+= tango_xtal.o
 obj-$(CONFIG_CLKSRC_IMX_GPT)		+= timer-imx-gpt.o
 obj-$(CONFIG_ASM9260_TIMER)		+= asm9260_timer.o
-obj-$(CONFIG_H8300)			+= h8300_timer8.o
+obj-$(CONFIG_H8300_TMR8)		+= h8300_timer8.o
 obj-$(CONFIG_H8300_TMR16)		+= h8300_timer16.o
 obj-$(CONFIG_H8300_TPU)			+= h8300_tpu.o
 obj-$(CONFIG_CLKSRC_ST_LPC)		+= clksrc_st_lpc.o
-- 
1.9.1
