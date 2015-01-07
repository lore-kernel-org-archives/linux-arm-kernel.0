From: rjui@broadcom.com (Ray Jui)
Date: Wed, 7 Jan 2015 11:22:43 -0800
Subject: [PATCH v3 0/5] Add common clock support for Broadcom iProc
 architecture
In-Reply-To: <Ray Jui <rjui@broadcom.com>
References: <Ray Jui <rjui@broadcom.com>
Message-ID: <1420658568-22879-1-git-send-email-rjui@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset contains the initial common clock support for Broadcom's iProc
family of SoCs. The iProc clock architecture comprises of various PLLs, e.g.,
ARMPLL, GENPLL, LCPLL0, MIPIPLL, and etc. An onboard crystal serves as the
basic reference clock for these PLLs. Each PLL may have several leaf clocks.
One special group of clocks is the ASIU clocks, which are dervied directly
from the crystal reference clock.

This patchset also contains the basic clock support for the Broadcom Cygnus
SoC, which implements the iProc clock architecture

Changes from v2:
 - Re-arrange Cygnus clock/pll init functions so each init function is right
   next to its clock table
 - Removed #defines for number of clocks in Cygnus. Have the number of clocks
   automatically determined based on array size of the clock table

Changes from v1:
 - Separate drivers/clk/Makefile change for drivers/clk/bcm out to a standalone patch

Ray Jui (5):
  clk: iproc: define Broadcom iProc clock binding
  clk: iproc: add initial common clock support
  clk: Change bcm clocks build dependency
  clk: cygnus: add clock support for Broadcom Cygnus
  ARM: dts: enable clock support for Broadcom Cygnus

 arch/arm/boot/dts/bcm-cygnus-clock.dtsi |  110 +++++--
 arch/arm/boot/dts/bcm-cygnus.dtsi       |    2 +-
 brcm,iproc-clocks.txt                   |  178 ++++++++++++
 drivers/clk/Makefile                    |    2 +-
 drivers/clk/bcm/Kconfig                 |    9 +
 drivers/clk/bcm/Makefile                |    2 +
 drivers/clk/bcm/clk-cygnus.c            |  277 ++++++++++++++++++
 drivers/clk/bcm/clk-iproc-armpll.c      |  286 ++++++++++++++++++
 drivers/clk/bcm/clk-iproc-asiu.c        |  275 ++++++++++++++++++
 drivers/clk/bcm/clk-iproc-clk.c         |  238 +++++++++++++++
 drivers/clk/bcm/clk-iproc-pll.c         |  483 +++++++++++++++++++++++++++++++
 drivers/clk/bcm/clk-iproc.h             |  155 ++++++++++
 include/dt-bindings/clock/bcm-cygnus.h  |   65 +++++
 13 files changed, 2055 insertions(+), 27 deletions(-)
 create mode 100644 brcm,iproc-clocks.txt
 create mode 100644 drivers/clk/bcm/clk-cygnus.c
 create mode 100644 drivers/clk/bcm/clk-iproc-armpll.c
 create mode 100644 drivers/clk/bcm/clk-iproc-asiu.c
 create mode 100644 drivers/clk/bcm/clk-iproc-clk.c
 create mode 100644 drivers/clk/bcm/clk-iproc-pll.c
 create mode 100644 drivers/clk/bcm/clk-iproc.h
 create mode 100644 include/dt-bindings/clock/bcm-cygnus.h

-- 
1.7.9.5
