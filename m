From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 27 Apr 2015 23:38:09 +0200
Subject: [PATCH v2 0/4] Clk drivers for NXP LPC18xx family
Message-ID: <1430170693-28303-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for the two main clock peripherals in the
LPC18xx/43xx MCU family.

The Clock Generation Unit (CGU) is the base source of all clocks. It has
five external inputs and contains PLLs, dividers and muxes. The outputs
from the CGU are then routed to a Clock Control Unit (CCU) and a few
peripherals directly. There are two CCUs in the MCU. The CCU is a
collection of gates and a few dividers that sits between the CGU and
most of the peripherals.

Which clocks that are available depends on the specific device and it's
peripherals. It's possible in DT to setup the routing between the CGU
and the CCUs.

Changes since v1:
 - reorganize cgu clk structs
 - macros to create cgu clk structs
 - move drivers to nxp subdir
 - rebase on v4.1-rc1

Since there were no comments on v1. I hope that these drivers can
make it to Linux 4.1.

There are no dependencies in this patch set. The DTS changes will
be sent separately to arm-soc once this patch set goes upstream.

See the base support patch set for LPC18xx here:
http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2

Joachim Eastwood (4):
  clk: add lpc18xx cgu clk driver
  doc: dt: add documentation for lpc1850-cgu clk driver
  clk: add lpc18xx ccu clk driver
  doc: dt: add documentation for lpc1850-ccu clk driver

 .../devicetree/bindings/clock/lpc1850-ccu.txt      | 146 +++++
 .../devicetree/bindings/clock/lpc1850-cgu.txt      | 138 +++++
 drivers/clk/Makefile                               |   1 +
 drivers/clk/nxp/Makefile                           |   2 +
 drivers/clk/nxp/clk-lpc18xx-ccu.c                  | 318 +++++++++++
 drivers/clk/nxp/clk-lpc18xx-cgu.c                  | 628 +++++++++++++++++++++
 include/dt-bindings/clock/lpc18xx-ccu.h            |  74 +++
 include/dt-bindings/clock/lpc18xx-cgu.h            |  41 ++
 8 files changed, 1348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-ccu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/lpc1850-cgu.txt
 create mode 100644 drivers/clk/nxp/Makefile
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-ccu.c
 create mode 100644 drivers/clk/nxp/clk-lpc18xx-cgu.c
 create mode 100644 include/dt-bindings/clock/lpc18xx-ccu.h
 create mode 100644 include/dt-bindings/clock/lpc18xx-cgu.h

-- 
1.8.0
