From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 12 Mar 2014 12:02:54 -0700
Subject: [PATCH v3 0/9] tty: xuartps: Rebranding + DT documentation
Message-ID: <1394650983-24780-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is a fixed and extended v3. I picked up Michal's patches and
incorporated them into the series. Those are the first two patches.
The 'rebranding' patch is correspondingly extended to convert the new
code as well.

The erroneously changed compatibility string has been reverted back to
what it should be.

	S?ren

Michal Simek (2):
  tty: xuartps: Fix kernel-doc errors in the driver
  tty: xuartps: Initialize ports according to aliases

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
 drivers/tty/serial/xilinx_uartps.c                 | 1129 ++++++++++----------
 include/uapi/linux/serial_core.h                   |    2 +-
 5 files changed, 570 insertions(+), 598 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cdns,uart.txt

-- 
1.9.0.1.g4196000
