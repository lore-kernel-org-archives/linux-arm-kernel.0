From: rajanikanth.hv@stericsson.com (Rajanikanth H.V)
Date: Mon, 1 Oct 2012 09:38:29 +0530
Subject: [PATCH 0/4] Implement device tree support for ab8500 BM Devices
Message-ID: <1349064513-31301-1-git-send-email-rajanikanth.hv@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

This patch-set adds device tree support for ab8500 battery-managed
devices. This removes the redundant platform structure maintained
across bm devices and implements common DT probe routine across all the
modules.

Rajanikanth H.V (4):
  mfd: ab8500: add devicetree support for fuelgauge
  mfd: ab8500: add devicetree support for Btemp
  mfd: ab8500: add devicetree support for charger
  mfd: ab8500: add devicetree support for charging algorithm

 Documentation/devicetree/bindings/mfd/ab8500.txt   |   27 +-
 .../bindings/power_supply/ab8500/btemp.txt         |   29 ++
 .../bindings/power_supply/ab8500/chargalg.txt      |   36 ++
 .../bindings/power_supply/ab8500/charger.txt       |   44 ++
 .../devicetree/bindings/power_supply/ab8500/fg.txt |   86 +++
 arch/arm/boot/dts/dbx5x0.dtsi                      |   40 +-
 drivers/mfd/ab8500-core.c                          |    4 +
 drivers/power/Kconfig                              |    6 -
 drivers/power/Makefile                             |    2 +-
 drivers/power/ab8500_bmdata.c                      |  549 ++++++++++++++++++++
 drivers/power/ab8500_btemp.c                       |   57 +-
 drivers/power/ab8500_charger.c                     |   65 ++-
 drivers/power/ab8500_fg.c                          |   76 ++-
 drivers/power/abx500_chargalg.c                    |   62 ++-
 include/linux/mfd/abx500.h                         |   37 +-
 include/linux/mfd/abx500/ab8500-bm.h               |    7 +
 16 files changed, 1028 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/btemp.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/chargalg.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/charger.txt
 create mode 100644 Documentation/devicetree/bindings/power_supply/ab8500/fg.txt
 create mode 100644 drivers/power/ab8500_bmdata.c

-- 
1.7.9.5
