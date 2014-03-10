From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Mon, 10 Mar 2014 14:40:03 -0700
Subject: [PATCH v2 0/7] tty: xuartps: Rebranding + DT documentation
Message-ID: <1394487610-2419-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series rebrands the Xilinx PS UART driver as Cadence UART and
documents its DT bindings (+ some clean up along the way).

The rebranding goes as far as reasonable. Things like file name, kconfig
symbols and other things with user space impact are left as is. Please
refer to the discussion in the RFC threads[1-2] for more details.

Similar the DT binding has been extended. In addition to the new and
preferred Cadence binding, the current xuartps binding is maintained.
Though, only the Cadence names for clock-names are documented.

References:
 [1]  https://lkml.org/lkml/2014/3/4/405
 [2]  https://lkml.org/lkml/2014/3/7/450

v2:
 - no changes regarding the patches
 - fixed (I sincerely hope) email recipients

Changes from the latest RFC:
 - squashed function/symbol renaming into 'tty: xuartps: Rebrand driver
   as Cadence UART'
 - Revised the commit message of 'tty: xuartps: Don't write IRQ disable
   register to enable interrupts' (was 'tty: xuartps: Remove bogus
   comment and register write'

   	Thanks,
	S?ren

Soren Brinkmann (7):
  tty: xuartps: Clean up
  tty: xuartps: Print warning in clock notifier
  tty: xuartps: Refactor read-modify-writes
  tty: xuartps: Don't write IRQ disable register to enable interrupts
  tty: xuartps: Rebrand driver as Cadence UART
  tty: cadence: Document DT binding
  ARM: zynq: DT: Migrate UART to Cadence binding

 .../devicetree/bindings/serial/cdns,uart.txt       |   20 +
 arch/arm/boot/dts/zynq-7000.dtsi                   |    8 +-
 drivers/tty/serial/Kconfig                         |    9 +-
 drivers/tty/serial/xilinx_uartps.c                 | 1116 ++++++++++----------
 include/uapi/linux/serial_core.h                   |    2 +-
 5 files changed, 560 insertions(+), 595 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt

-- 
1.9.0.1.g4196000
