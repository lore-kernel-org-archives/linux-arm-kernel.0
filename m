From: david@lechnology.com (David Lechner)
Date: Tue, 20 Dec 2016 14:23:01 -0600
Subject: [PATCH 0/3] TI DA8xx/OMAPL13x/AM17xx/AM18xx UART
Message-ID: <1482265384-715-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx UART.
This SoCs have a non-standard register for UART power management that needs
special handling in the UART driver.

David Lechner (3):
  doc: DT: Add ti,da830-uart to serial/8250 bindings
  serial: 8250: Add new port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx
  ARM: da850: Add ti,da830-uart compatible for serial ports

 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 arch/arm/boot/dts/da850.dtsi                      |  9 ++++++---
 drivers/tty/serial/8250/8250_of.c                 |  1 +
 drivers/tty/serial/8250/8250_port.c               | 22 ++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |  3 ++-
 include/uapi/linux/serial_reg.h                   |  8 ++++++++
 6 files changed, 40 insertions(+), 4 deletions(-)

-- 
2.7.4
