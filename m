From: joshc@codeaurora.org (Josh Cartwright)
Date: Thu, 15 Aug 2013 14:50:24 -0500
Subject: [PATCH RFC 0/3] Add support for the System Power Management Interface
 (SPMI)
Message-ID: <cover.1376596224.git.joshc@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Power Management Interface (SPMI) is a high-speed,
low-latency, bi-directional, two-wire serial bus suitable for real-time
control of voltage and frequency scaled multi-core application
processors and its power management of auxiliary components. SPMI
obsoletes a number of legacy, custom point-to-point interfaces and
provides a low pin count, high-speed control bus for up to 4 Master and
16 Slave devices.

SPMI is specified by the MIPI (Mobile Industry Process Interface)
Alliance [1].

Introduced in this patchset are the core SPMI bus components, as well an
implementation of an SPMI controller, the "PMIC arbiter", which is used
on several Qualcomm SoCs to communicate with off-chip Power Management
ICs (PMICs).  Notably missing from this patchset is an implementation of
a spmi device/slave driver, which is still forthcoming.  With this
patchset in it's current state, it is possible to perform register
accesses to a slave via debugfs.

[1]: http://www.mipi.org/specifications/system-power-management-interface

Josh Cartwright (1):
  spmi: document the PMIC arbiter SPMI bindings

Kenneth Heitke (2):
  spmi: Linux driver framework for SPMI
  spmi: Add MSM PMIC Arbiter SPMI controller

 .../devicetree/bindings/spmi/spmi-pmic-arb.txt     |  26 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/of/Kconfig                                 |   6 +
 drivers/of/Makefile                                |   1 +
 drivers/of/of_spmi.c                               |  74 +++
 drivers/spmi/Kconfig                               |  24 +
 drivers/spmi/Makefile                              |   9 +
 drivers/spmi/spmi-dbgfs.c                          | 591 +++++++++++++++++++++
 drivers/spmi/spmi-dbgfs.h                          |  37 ++
 drivers/spmi/spmi-pmic-arb.c                       | 499 +++++++++++++++++
 drivers/spmi/spmi.c                                | 449 ++++++++++++++++
 include/linux/mod_devicetable.h                    |   8 +
 include/linux/of_spmi.h                            |  37 ++
 include/linux/spmi.h                               | 337 ++++++++++++
 15 files changed, 2101 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spmi/spmi-pmic-arb.txt
 create mode 100644 drivers/of/of_spmi.c
 create mode 100644 drivers/spmi/Kconfig
 create mode 100644 drivers/spmi/Makefile
 create mode 100644 drivers/spmi/spmi-dbgfs.c
 create mode 100644 drivers/spmi/spmi-dbgfs.h
 create mode 100644 drivers/spmi/spmi-pmic-arb.c
 create mode 100644 drivers/spmi/spmi.c
 create mode 100644 include/linux/of_spmi.h
 create mode 100644 include/linux/spmi.h

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
