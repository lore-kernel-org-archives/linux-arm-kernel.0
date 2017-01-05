From: david@lechnology.com (David Lechner)
Date: Thu,  5 Jan 2017 12:54:16 -0600
Subject: [PATCH v3 0/4] TI DA8xx/OMAPL13x/AM17xx/AM18xx/66AK2x UART
Message-ID: <1483642460-6891-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds a new UART port type for TI DA8xx/OMAPL13x/AM17xx/AM18xx/66AK2x
UART. These SoCs have a non-standard register for UART power management that
needs special handling in the UART driver.

Greg, the first two patches will need to go through your tree. Sekhar and
Santosh will pick up the 3 and 4 patches respectively.

v3 changes:
* Shortened list of SoCs to "DA8xx/66AK2x"

v2 changes:
* Added references to C66x SoC in various places, which I assume is an OK
  shorthand for TI Keystone processors.
* New patch for Keystone device tree. This is untested as I don't have any
  Keystone boards.

David Lechner (4):
  doc: DT: Add ti,da830-uart to serial/8250 bindings
  serial: 8250: Add new port type for TI DA8xx/66AK2x
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
