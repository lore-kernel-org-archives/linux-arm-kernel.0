From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 17 Oct 2016 18:30:47 +0200
Subject: [PATCH 0/3] ARM: da850: new drivers for better LCDC support
Message-ID: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds two new drivers in order to better support the LCDC
rev1 present on the da850 boards.

The first patch adds a new memory driver which allows to write to the
DDR2/mDDR memory controller present on the da8xx SoCs.

The second patch adds a new bus driver which allows to interact with
the SYSCFG module of da8xx SoCs.

Both drivers are incomplete - they currently only implement the
functionalities required to correctly support the LCDC on da850
boards. The first driver only allows to specify the value of the PBBP
register, while the second allows to modify all master peripheral
priorities, but doesn't know about other syscfg registers yet.

Potential extensions of these drivers should be straightforward in the
future.

The last patch adds disabled nodes for the above drivers to da850.dtsi.

Tested on a da850-lcdk with a display connected over VGA.

Bartosz Golaszewski (3):
  ARM: memory: da8xx-ddrctl: new driver
  ARM: bus: da8xx-syscfg: new driver
  ARM: dts: da850: add the syscfg and ddrctl nodes

 .../devicetree/bindings/bus/ti,da850-syscfg.txt    |  63 +++++++
 .../memory-controllers/ti-da8xx-ddrctl.txt         |  25 +++
 arch/arm/boot/dts/da850.dtsi                       |  10 +
 drivers/bus/Kconfig                                |   8 +
 drivers/bus/Makefile                               |   2 +
 drivers/bus/da8xx-syscfg.c                         | 206 +++++++++++++++++++++
 drivers/memory/Kconfig                             |   8 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/da8xx-ddrctl.c                      |  77 ++++++++
 9 files changed, 400 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ti,da850-syscfg.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
 create mode 100644 drivers/bus/da8xx-syscfg.c
 create mode 100644 drivers/memory/da8xx-ddrctl.c

-- 
2.9.3
