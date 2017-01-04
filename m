From: david@lechnology.com (David Lechner)
Date: Wed,  4 Jan 2017 14:30:10 -0600
Subject: [PATCH v2 0/4] TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x UART
Message-ID: <1483561814-21953-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
UART. This SoCs have a non-standard register for UART power management that
needs special handling in the UART driver.

v2 changes:
* Added references to C66x SoC in various places, which I assume is an OK
  shorthand for TI Keystone processors.
* New patch for Keystone device tree. This is untested as I don't have any
  Keystone boards.


David Lechner (4):
  doc: DT: Add ti,da830-uart to serial/8250 bindings
  serial: 8250: Add new port type for TI
    DA8xx/OMAPL13x/AM17xx/AM18xx/C66x
  ARM: da850: Add ti,da830-uart compatible for serial ports
  ARM: dts: keystone: Add "ti,da830-uart" compatible string

 Documentation/devicetree/bindings/serial/8250.txt |  1 +
 arch/arm/boot/dts/da850.dtsi                      |  9 ++++++---
 arch/arm/boot/dts/keystone-k2g.dtsi               |  2 +-
 arch/arm/boot/dts/keystone-k2l.dtsi               |  4 ++--
 arch/arm/boot/dts/keystone.dtsi                   |  4 ++--
 drivers/tty/serial/8250/8250_of.c                 |  1 +
 drivers/tty/serial/8250/8250_port.c               | 22 ++++++++++++++++++++++
 include/uapi/linux/serial_core.h                  |  3 ++-
 include/uapi/linux/serial_reg.h                   |  8 ++++++++
 9 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.7.4
