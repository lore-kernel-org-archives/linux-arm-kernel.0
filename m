From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Sat,  9 Jan 2016 13:07:31 +0000
Subject: [PATCH V2 0/2] serial: bcm2835: add bcm2835 auxiliar uart driver
Message-ID: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

This patch series adds the bcm2835aux uart driver, which is created
as a wrapper arround the 8250 driver (based on recommendations by
Stephen Warren)

The device tree patch itself is not included yet because this
patch requires the clk-bcm2835aux driver, which is right now only
in clk-next, but should become available with 4.5.

Martin Sperl (2):
  dt/bindings: serial: bcm2835: add binding documentation for
    bcm2835-aux-uart
  serial: bcm2835: add driver for bcm2835-aux-uart

 .../bindings/serial/brcm,bcm2835-aux-uart.txt      |   18 +++
 drivers/tty/serial/8250/8250_bcm2835aux.c          |  143 ++++++++++++++++++++
 drivers/tty/serial/8250/Kconfig                    |    8 ++
 drivers/tty/serial/8250/Makefile                   |    1 +
 4 files changed, 170 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/brcm,bcm2835-aux-uart.txt
 create mode 100644 drivers/tty/serial/8250/8250_bcm2835aux.c

-- 
1.7.10.4
