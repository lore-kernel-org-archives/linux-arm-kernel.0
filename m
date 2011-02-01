From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Tue,  1 Feb 2011 20:17:38 +0530
Subject: [PATCH v1 0/9] pruss mfd drivers
Message-ID: <1296571667-12049-1-git-send-email-subhasish@mistralsolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Programmable Realtime Unit (PRU) is basically a 32-bit RISC
processor available within TI's DA8XX SOCs. It consists of local
instruction and data RAM and also has access to SOC resources
via a Switched Central Resource (SCR).

There are two PRU's available within DA8XX SOC's PRUSS, hence providing
two execution cores. Devices/Protocols can be emulated on these utilizing
either both or only one of the PRUs independently.

The rational behind the MFD driver being the fact that multiple devices can
be implemented on the cores independently.
It's also possible, as in our case, to implement a single device on both
the PRU's resulting in improved load sharing.

A detailed description is also available here:
http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem

version 1:
==========
* added pruss mfd driver.
* added pruss mfd board and platform changes.
* added pruss SocketCAN driver.
* added pruss SocketCAN board and platform changes.
* added pruss SocketCAN GPIOs.
* added previous review comments.

Subhasish Ghosh (9):
  mfd: pruss mfd driver.
  da850: pruss board specific additions.
  da850: pruss platform specific additions.
  can: pruss CAN driver.
  da850: pruss CAN board specific additions.
  da850: pruss CAN platform specific additions.
  mfd: pruss CAN private data.
  da850: pruss CAN board specific changes for gpios.
  da850: pruss CAN platform specific changes for gpios.

 arch/arm/mach-davinci/board-da850-evm.c     |   75 ++
 arch/arm/mach-davinci/da850.c               |   12 +
 arch/arm/mach-davinci/devices-da8xx.c       |   65 ++
 arch/arm/mach-davinci/include/mach/da8xx.h  |    2 +
 arch/arm/mach-davinci/include/mach/mux.h    |    5 +
 drivers/mfd/Kconfig                         |   10 +
 drivers/mfd/Makefile                        |    1 +
 drivers/mfd/da8xx_pru.c                     |  403 +++++++++
 drivers/net/can/Kconfig                     |    1 +
 drivers/net/can/Makefile                    |    1 +
 drivers/net/can/da8xx_pruss/Kconfig         |   73 ++
 drivers/net/can/da8xx_pruss/Makefile        |    7 +
 drivers/net/can/da8xx_pruss/pruss_can.c     |  759 +++++++++++++++++
 drivers/net/can/da8xx_pruss/pruss_can_api.c | 1224 +++++++++++++++++++++++++++
 drivers/net/can/da8xx_pruss/pruss_can_api.h |  290 +++++++
 include/linux/mfd/pruss/da8xx_pru.h         |  106 +++
 include/linux/mfd/pruss/da8xx_prucore.h     |   74 ++
 17 files changed, 3108 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/da8xx_pru.c
 create mode 100644 drivers/net/can/da8xx_pruss/Kconfig
 create mode 100644 drivers/net/can/da8xx_pruss/Makefile
 create mode 100644 drivers/net/can/da8xx_pruss/pruss_can.c
 create mode 100644 drivers/net/can/da8xx_pruss/pruss_can_api.c
 create mode 100644 drivers/net/can/da8xx_pruss/pruss_can_api.h
 create mode 100644 include/linux/mfd/pruss/da8xx_pru.h
 create mode 100644 include/linux/mfd/pruss/da8xx_prucore.h

-- 
1.7.2.3
