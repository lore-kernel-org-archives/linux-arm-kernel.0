From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Jun 2011 13:37:54 -0600
Subject: [PATCH 1/2] gpio/tegra: Move Tegra gpio driver to drivers/gpio
Message-ID: <20110615193734.23641.8004.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As part of the gpio driver consolidation, this patch moves the Tegra driver
into drivers/gpio

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

If there are no objections, I'll merge this via gpio/next

g.

 arch/arm/mach-tegra/Makefile |    1 -
 drivers/gpio/Makefile        |    1 +
 drivers/gpio/gpio-tegra.c    |    0 
 3 files changed, 1 insertions(+), 1 deletions(-)
 rename arch/arm/mach-tegra/gpio.c => drivers/gpio/gpio-tegra.c (100%)

diff --git a/arch/arm/mach-tegra/Makefile b/arch/arm/mach-tegra/Makefile
index 823c703..ed58ef9 100644
--- a/arch/arm/mach-tegra/Makefile
+++ b/arch/arm/mach-tegra/Makefile
@@ -4,7 +4,6 @@ obj-y                                   += io.o
 obj-y                                   += irq.o
 obj-y                                   += clock.o
 obj-y                                   += timer.o
-obj-y                                   += gpio.o
 obj-y                                   += pinmux.o
 obj-y                                   += powergate.o
 obj-y					+= fuse.o
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 68e3bfd..0fbdd75 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_STMPE)	+= gpio-stmpe.o
 obj-$(CONFIG_GPIO_SX150X)	+= gpio-sx150x.o
 obj-$(CONFIG_GPIO_TC3589X)	+= gpio-tc3589x.o
+obj-$(CONFIG_ARCH_TEGRA)	+= gpio-tegra.o
 obj-$(CONFIG_GPIO_TIMBERDALE)	+= gpio-timberdale.o
 obj-$(CONFIG_GPIO_TPS65910)	+= gpio-tps65910.o
 obj-$(CONFIG_GPIO_TWL4030)	+= gpio-twl4030.o
diff --git a/arch/arm/mach-tegra/gpio.c b/drivers/gpio/gpio-tegra.c
similarity index 100%
rename from arch/arm/mach-tegra/gpio.c
rename to drivers/gpio/gpio-tegra.c
