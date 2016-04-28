From: chunkeey@googlemail.com (Christian Lamparter)
Date: Thu, 28 Apr 2016 11:05:12 +0200
Subject: [RFC v4 2/8] gpio: rename gpio-generic.c into gpio-mmio.c
In-Reply-To: <cover.1461806071.git.chunkeey@googlemail.com>
References: <cover.1461806071.git.chunkeey@googlemail.com>
Message-ID: <5d6d06726e8ed05aea6cae0aaa9166b10c408dd0.1461806071.git.chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch renames the gpio-generic.c into gpio-mmio.c.
This is because currently the file only contains code
for a memory-mapped GPIO driver. There isn't any support
for ioports or other resource type.

Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 drivers/gpio/Makefile                        | 3 +++
 drivers/gpio/{gpio-generic.c => gpio-mmio.c} | 0
 2 files changed, 3 insertions(+)
 rename drivers/gpio/{gpio-generic.c => gpio-mmio.c} (100%)

diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 74eb1a7..991598e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -12,6 +12,9 @@ obj-$(CONFIG_GPIO_ACPI)		+= gpiolib-acpi.o
 # Device drivers. Generally keep list sorted alphabetically
 obj-$(CONFIG_GPIO_GENERIC)	+= gpio-generic.o
 
+# directly supported by gpio-generic
+gpio-generic-$(CONFIG_GPIO_GENERIC)	+= gpio-mmio.o
+
 obj-$(CONFIG_GPIO_104_DIO_48E)	+= gpio-104-dio-48e.o
 obj-$(CONFIG_GPIO_104_IDIO_16)	+= gpio-104-idio-16.o
 obj-$(CONFIG_GPIO_104_IDI_48)	+= gpio-104-idi-48.o
diff --git a/drivers/gpio/gpio-generic.c b/drivers/gpio/gpio-mmio.c
similarity index 100%
rename from drivers/gpio/gpio-generic.c
rename to drivers/gpio/gpio-mmio.c
-- 
2.8.1
