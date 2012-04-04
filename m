From: viresh.kumar@st.com (Viresh Kumar)
Date: Wed, 4 Apr 2012 17:05:32 +0530
Subject: [PATCH V2 0/4] pinctrl: Add SPEAr pinctrl support
Message-ID: <cover.1333538869.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset replaces existing pinmux framework for SPEAr family of SoC with
generic pinctrl framework.

V1->V2
- Earlier padmux support removed
- single patch for spear pinctrl drivers broken into two: one for spear and
  other for 3xx family
- add pinctrl support in arch/arm/mach-spear3xx/ and dts files
- pinctrl-spear.* made as library instead of platform driver
- pinctrl-spear300, spear310, spear320 are now platform drivers
- other minor fixes.

Viresh Kumar (4):
  SPEAr: Remove existing padmux support for SPEAr
  pinctrl: Add SPEAr pinctrl drivers
  pinctrl: Add SPEAr3xx pinctrl drivers
  SPEAr3xx: Add pinctrl support for boards

 .../devicetree/bindings/pinmux/pinmux_spear.txt    |   28 +
 MAINTAINERS                                        |   23 +-
 arch/arm/boot/dts/spear300-evb.dts                 |    4 +
 arch/arm/boot/dts/spear300.dtsi                    |    5 +
 arch/arm/boot/dts/spear310.dtsi                    |    5 +
 arch/arm/boot/dts/spear320-evb.dts                 |    4 +
 arch/arm/boot/dts/spear320.dtsi                    |    7 +-
 arch/arm/mach-spear3xx/Kconfig                     |    3 +
 arch/arm/mach-spear3xx/include/mach/generic.h      |  128 -
 arch/arm/mach-spear3xx/spear300.c                  |  408 +---
 arch/arm/mach-spear3xx/spear310.c                  |  185 +-
 arch/arm/mach-spear3xx/spear320.c                  |  426 +---
 arch/arm/mach-spear3xx/spear3xx.c                  |  425 ---
 arch/arm/plat-spear/Kconfig                        |    1 +
 arch/arm/plat-spear/Makefile                       |    2 +-
 arch/arm/plat-spear/include/plat/padmux.h          |   92 -
 arch/arm/plat-spear/padmux.c                       |  164 -
 drivers/pinctrl/Kconfig                            |    2 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/spear/Kconfig                      |   34 +
 drivers/pinctrl/spear/Makefile                     |    7 +
 drivers/pinctrl/spear/pinctrl-spear.c              |  301 ++
 drivers/pinctrl/spear/pinctrl-spear.h              |  142 +
 drivers/pinctrl/spear/pinctrl-spear300.c           |  708 ++++
 drivers/pinctrl/spear/pinctrl-spear310.c           |  431 +++
 drivers/pinctrl/spear/pinctrl-spear320.c           | 3468 ++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear3xx.c           |  621 ++++
 drivers/pinctrl/spear/pinctrl-spear3xx.h           |  102 +
 28 files changed, 5961 insertions(+), 1767 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinmux/pinmux_spear.txt
 delete mode 100644 arch/arm/plat-spear/include/plat/padmux.h
 delete mode 100644 arch/arm/plat-spear/padmux.c
 create mode 100644 drivers/pinctrl/spear/Kconfig
 create mode 100644 drivers/pinctrl/spear/Makefile
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear.h
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear300.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear310.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear320.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear3xx.c
 create mode 100644 drivers/pinctrl/spear/pinctrl-spear3xx.h

-- 
1.7.9
