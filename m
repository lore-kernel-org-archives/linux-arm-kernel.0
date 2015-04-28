From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 28 Apr 2015 19:24:37 +0200
Subject: [PATCH 0/2] Add support for PL172 memory-controller
Message-ID: <1430241879-30046-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for setting up static memory devices on
a ARM PrimeCell MultiPort Memory Controller (PL172) from DT. Dynamic
memory (SDRAM) is not supported in this patch set.

DT bindings for PL172 is based on the bindings for the TI AEMIF
memory controller. PL172 can be found on a number of NXP devices
like the LPC18xx family.

Tested on Embedded Artists' LPC4357 Developer's Kit with NOR Flash
(SST39VF320) and 74LCV16374 (gpio-74x164) on MPMC.

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
