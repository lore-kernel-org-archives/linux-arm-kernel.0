From: joel@jms.id.au (Joel Stanley)
Date: Mon,  9 May 2016 22:02:46 +0930
Subject: [PATCH 1/4] drivers/clocksouree/moxart: Add kbuild symbol
In-Reply-To: <1462797169-14512-1-git-send-email-joel@jms.id.au>
References: <1462797169-14512-1-git-send-email-joel@jms.id.au>
Message-ID: <1462797169-14512-2-git-send-email-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a Kconfig entry for this driver so other SoCs can select it. This
updates the moxart Kconfig in order to select the symbol.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/mach-moxart/Kconfig | 2 +-
 drivers/clocksource/Kconfig  | 9 +++++++++
 drivers/clocksource/Makefile | 2 +-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 180d9d216719..505fab683b81 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -3,9 +3,9 @@ menuconfig ARCH_MOXART
 	depends on ARCH_MULTI_V4
 	select CPU_FA526
 	select ARM_DMA_MEM_BUFFERABLE
-	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
 	select ARCH_REQUIRE_GPIOLIB
+	select MOXART_TIMER
 	select PHYLIB if NETDEVICES
 	help
 	  Say Y here if you want to run your kernel on hardware with a
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index c346be650892..9a54d1ce4ce7 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -411,4 +411,13 @@ config CLKSRC_ST_LPC
 	  Enable this option to use the Low Power controller timer
 	  as clocksource.
 
+config MOXART_TIMER
+	bool "Moxart timer" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS && HAS_IOMEM
+	select CLKSRC_OF
+	select CLKSRC_MMIO
+	help
+	  Enables the support for the timer used in the Moxart and Aspeed
+	  system on chips.
+
 endmenu
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index dc2b8997f6e6..14fe8172c174 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -22,7 +22,7 @@ obj-$(CONFIG_ORION_TIMER)	+= time-orion.o
 obj-$(CONFIG_ARCH_BCM2835)	+= bcm2835_timer.o
 obj-$(CONFIG_ARCH_CLPS711X)	+= clps711x-timer.o
 obj-$(CONFIG_ARCH_ATLAS7)	+= timer-atlas7.o
-obj-$(CONFIG_ARCH_MOXART)	+= moxart_timer.o
+obj-$(CONFIG_MOXART_TIMER)	+= moxart_timer.o
 obj-$(CONFIG_ARCH_MXS)		+= mxs_timer.o
 obj-$(CONFIG_CLKSRC_PXA)	+= pxa_timer.o
 obj-$(CONFIG_ARCH_PRIMA2)	+= timer-prima2.o
-- 
2.8.1
