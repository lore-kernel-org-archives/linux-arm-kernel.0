From: alex.elder@linaro.org (Alex Elder)
Date: Tue, 03 Dec 2013 21:54:54 -0600
Subject: [PATCH 0/3] clk: bcm281xx: define Broadcom kona clocks
Message-ID: <529EA78E.7060904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Kona clock control units (CCUs) and
clocks, used by Broadcom BCM281xx family SoCs.  Kona CCUs are
represented by nodes in the device tree, and the names of the clocks
provided by a CCU are included in its node.  Implementation details
of those clocks are defined in a C file separate from the code that
implements the functionality used by most of the common clock
framework.

This series depends on:
    "Update Kona drivers to use clocks"
    https://lkml.org/lkml/2013/11/14/450

This series (along with a version of those prerequisite patches) is
available in the "review/bcm-kona-clocks" branch of this git
repository:
    git://git.linaro.org/people/elder/linux.git

					-Alex

Alex Elder (3):
  clk: bcm281xx: define kona clock binding
  clk: bcm281xx: add initial clock framework support
  ARM: dts: bcm281xx: define real clocks

 .../devicetree/bindings/clock/bcm-kona-clock.txt   |   95 ++
 arch/arm/boot/dts/bcm11351.dtsi                    |  222 +++--
 drivers/clk/Kconfig                                |    1 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/bcm/Kconfig                            |    8 +
 drivers/clk/bcm/Makefile                           |    3 +
 drivers/clk/bcm/clk-bcm281xx.c                     |  416 ++++++++
 drivers/clk/bcm/clk-kona-setup.c                   |  774 +++++++++++++++
 drivers/clk/bcm/clk-kona.c                         | 1033
++++++++++++++++++++
 drivers/clk/bcm/clk-kona.h                         |  416 ++++++++
 include/dt-bindings/clock/bcm281xx.h               |   65 ++
 11 files changed, 2973 insertions(+), 61 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/clock/bcm-kona-clock.txt
 create mode 100644 drivers/clk/bcm/Kconfig
 create mode 100644 drivers/clk/bcm/Makefile
 create mode 100644 drivers/clk/bcm/clk-bcm281xx.c
 create mode 100644 drivers/clk/bcm/clk-kona-setup.c
 create mode 100644 drivers/clk/bcm/clk-kona.c
 create mode 100644 drivers/clk/bcm/clk-kona.h
 create mode 100644 include/dt-bindings/clock/bcm281xx.h

-- 1.7.9.5
