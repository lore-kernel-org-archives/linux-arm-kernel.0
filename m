From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 25 Apr 2011 20:31:18 +0200
Subject: [PATCH 08/14] at91: move gpio to drivers/gpio
In-Reply-To: <20110425180847.GA12904@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
Message-ID: <1303756284-26529-8-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 MAINTAINERS                                        |    1 +
 arch/arm/mach-at91/Makefile                        |    2 +-
 drivers/gpio/Makefile                              |    1 +
 .../mach-at91/gpio.c => drivers/gpio/at91_gpio.c   |    0
 4 files changed, 3 insertions(+), 1 deletions(-)
 rename arch/arm/mach-at91/gpio.c => drivers/gpio/at91_gpio.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1380312..30ba179 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -654,6 +654,7 @@ W:	http://maxim.org.za/at91_26.html
 W:	http://www.linux4sam.org
 S:	Supported
 F:	arch/arm/mach-at91/
+F:	drivers/gpio/at91_gpio.c
 
 ARM/BCMRING ARM ARCHITECTURE
 M:	Jiandong Zheng <jdzheng@broadcom.com>
diff --git a/arch/arm/mach-at91/Makefile b/arch/arm/mach-at91/Makefile
index 9cac68d..6aa38f9 100644
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-obj-y		:= irq.o gpio.o soc.o
+obj-y		:= irq.o soc.o
 obj-m		:=
 obj-n		:=
 obj-		:=
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index becef59..3c3a3a6 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_GPIOLIB)		+= gpiolib.o
 
 obj-$(CONFIG_GPIO_ADP5520)	+= adp5520-gpio.o
 obj-$(CONFIG_GPIO_ADP5588)	+= adp5588-gpio.o
+obj-$(CONFIG_ARCH_AT91)		+= at91_gpio.o
 obj-$(CONFIG_GPIO_BASIC_MMIO)	+= basic_mmio_gpio.o
 obj-$(CONFIG_GPIO_LANGWELL)	+= langwell_gpio.o
 obj-$(CONFIG_GPIO_MAX730X)	+= max730x.o
diff --git a/arch/arm/mach-at91/gpio.c b/drivers/gpio/at91_gpio.c
similarity index 100%
rename from arch/arm/mach-at91/gpio.c
rename to drivers/gpio/at91_gpio.c
-- 
1.7.4.1
