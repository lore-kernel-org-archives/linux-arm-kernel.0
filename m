From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed, 11 Dec 2013 19:50:16 +0400
Subject: [PATCH 0/2] serial: clps711x: UART driver refactor
Message-ID: <1386777016-24750-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a complex patch for refactoring CLPS711X serial driver.
Major changes:
- Eliminate <mach/hardware.h> usage.
- Devicetree support.

Patch created for adding in tty tree, but this changes need attention
from ARM and DT maintainers, so "ACK" will be useful here.

Alexander Shiyan (2):
  serial: clps711x: Driver refactor
  serial: clps711x: dts: Add bindings documentation for the CLPS711X
    UART

 .../bindings/serial/cirrus,clps711x-uart.txt       |  29 ++
 arch/arm/mach-clps711x/devices.c                   |  21 +
 drivers/tty/serial/clps711x.c                      | 448 ++++++++++++---------
 3 files changed, 304 insertions(+), 194 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/cirrus,clps711x-uart.txt

-- 
1.8.3.2
