From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 21 Dec 2011 01:40:35 +0800
Subject: [RFC PATCH v3 0/5] pinctrl: imx: add pinnmux support
Message-ID: <1324402840-32451-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main changes of this new patch series are add dt binding
support in pinctrl core for pinmux mappings and shows an example
on using the standard API provided by pinctrl core to register
pinmux mappings from dts file.
Then we can remove the old board specifc pinmux mappings from
generic soc specific code (e.g. mach-imx6q.c).

Change v2->v3:
- change the name from of_get_child_number to of_get_child_count
- pinctrl: add dt binding support for pinmux mappings
- Add phandle for pinmux mappings for imx6q
- binding pinmux mappings via pinctrl core API
- follow the dt convention to use dash '-' for property name

Changes v1->v2:
- add a cover letter
- remove the pin functon and group defines out of driver
- parsing data from device tree for imx6q support
- a few minor fixes suggested by Shawn

Dong Aisheng (5):
  dt: add of_get_child_count helper function
  pinctrl: add dt binding support for pinmux mappings
  pinctrl: imx: add pinctrl imx driver
  ARM: imx6q: using pinmux subsystem
  mmc: sdhci-esdhc-imx: using pinmux subsystem

 .../devicetree/bindings/pinctrl/pinctrl-imx.txt    |   59 +++
 .../devicetree/bindings/pinctrl/pinctrl.txt        |   33 ++
 arch/arm/boot/dts/imx6q-sabreauto.dts              |   32 ++
 arch/arm/boot/dts/imx6q.dtsi                       |    1 +
 arch/arm/mach-imx/Kconfig                          |    1 +
 drivers/mmc/host/sdhci-esdhc-imx.c                 |   20 +
 drivers/pinctrl/Kconfig                            |   20 +
 drivers/pinctrl/Makefile                           |    3 +
 drivers/pinctrl/pinctrl-imx-core.c                 |  450 ++++++++++++++++++++
 drivers/pinctrl/pinctrl-imx-core.h                 |   86 ++++
 drivers/pinctrl/pinctrl-imx53.c                    |  443 +++++++++++++++++++
 drivers/pinctrl/pinctrl-imx6q.c                    |  433 +++++++++++++++++++
 drivers/pinctrl/pinmux.c                           |  101 +++++
 include/linux/of.h                                 |   16 +
 include/linux/pinctrl/machine.h                    |    6 +
 15 files changed, 1704 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl-imx.txt
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl.txt
 create mode 100644 drivers/pinctrl/pinctrl-imx-core.c
 create mode 100644 drivers/pinctrl/pinctrl-imx-core.h
 create mode 100644 drivers/pinctrl/pinctrl-imx53.c
 create mode 100644 drivers/pinctrl/pinctrl-imx6q.c
