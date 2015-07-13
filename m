From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 13 Jul 2015 23:20:10 +0200
Subject: [PATCH v2 0/2] Add support for PL172 memory-controller
Message-ID: <1436822412-20171-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a memory driver and documentation for the ARM
PL172. This driver  makes it possible to configure the static
memory chip selects on the ARM PL172 MultiPort Memory Controller
from a set of properties in DT. Configuration of dynamic memory
(SDRAM) is not supported and is left to the boot loader. The
intended usage is to setup timing and configuration for static
memory devices like NAND and NOR Flash before they are probed by
a driver. Pretty much what like all the other memory drivers do.

As drivers/memory doesn't seem to have a maintainer of it's own
I hope this patch set can go through the armsoc-drivers branch.

The previous version of the patch set didn't recive recivce much
feedback and the cover letter can be found here:
http://marc.info/?l=devicetree&m=143024189625522&w=2

DT bindings for PL172 is based on the bindings for the TI AEMIF
memory controller. PL172 can be found on a number of NXP devices
like the LPC18xx family.

Tested on Embedded Artists' LPC4357 Developer's Kit with NOR Flash
(SST39VF320) and 74LCV16374 (gpio-74x164) on MPMC.

Changes since v1:
 - Add proper commit messages
 - Misc clean ups

Joachim Eastwood (2):
  memory: add ARM PL172 MultiPort Memory Controller driver
  doc: dt: add documentation for pl172 memory bindings

 .../bindings/memory-controllers/arm,pl172.txt      | 125 +++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/pl172.c                             | 302 +++++++++++++++++++++
 4 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/arm,pl172.txt
 create mode 100644 drivers/memory/pl172.c

-- 
1.8.0
