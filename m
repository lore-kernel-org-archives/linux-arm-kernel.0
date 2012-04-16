From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 16 Apr 2012 09:43:56 +0530
Subject: [PATCH V4 0/5] pinctrl: Add SPEAr pinctrl support
Message-ID: <cover.1334548272.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset replaces existing pinmux framework for SPEAr family of SoC with
generic pinctrl framework.

V3->V4
- Introduced devm_of_iomap()
- placed spaces around = in dts files
- Updated groups and function names in pinctrl bindings for SPEAr

V2->V3
- Add DT bindings for pinmux mappings for SPEAr
- Pass pin maps from dtb instead of mach-spear3xx/spear3*0.c files
- use of_iomap() instead of devm_ioremap() and platform_get_resource()

V1->V2
- Earlier padmux support removed
- single patch for spear pinctrl drivers broken into two: one for spear
  and other for 3xx family
- add pinctrl support in arch/arm/mach-spear3xx/ and dts files
- pinctrl-spear.* made as library instead of platform driver
- pinctrl-spear300, spear310, spear320 are now platform drivers
- other minor fixes.

Viresh Kumar (5):
  of: Implement managed of_iomap()
  SPEAr: Remove existing padmux support for SPEAr
  pinctrl: Add SPEAr pinctrl drivers
  pinctrl: Add SPEAr3xx pinctrl drivers
  SPEAr3xx: Add pinctrl support for boards

 .../devicetree/bindings/pinctrl/pinctrl_spear.txt  |  108 +
 Documentation/driver-model/devres.txt              |    1 +
 MAINTAINERS                                        |   23 +-
 arch/arm/boot/dts/spear300-evb.dts                 |   38 +
 arch/arm/boot/dts/spear300.dtsi                    |    5 +
 arch/arm/boot/dts/spear310-evb.dts                 |   61 +
 arch/arm/boot/dts/spear310.dtsi                    |    5 +
 arch/arm/boot/dts/spear320-evb.dts                 |   61 +
 arch/arm/boot/dts/spear320.dtsi                    |    7 +-
 arch/arm/mach-spear3xx/Kconfig                     |    3 +
 arch/arm/mach-spear3xx/include/mach/generic.h      |  128 -
 arch/arm/mach-spear3xx/spear300.c                  |  389 +---
 arch/arm/mach-spear3xx/spear310.c                  |  161 +-
 arch/arm/mach-spear3xx/spear320.c                  |  403 +---
 arch/arm/mach-spear3xx/spear3xx.c                  |  425 ---
 arch/arm/plat-spear/Kconfig                        |    1 +
 arch/arm/plat-spear/Makefile                       |    2 +-
 arch/arm/plat-spear/include/plat/padmux.h          |   92 -
 arch/arm/plat-spear/padmux.c                       |  164 -
 drivers/of/address.c                               |   22 +
 drivers/pinctrl/Kconfig                            |    2 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/spear/Kconfig                      |   34 +
 drivers/pinctrl/spear/Makefile                     |    7 +
 drivers/pinctrl/spear/pinctrl-spear.c              |  349 ++
 drivers/pinctrl/spear/pinctrl-spear.h              |  142 +
 drivers/pinctrl/spear/pinctrl-spear300.c           |  708 ++++
 drivers/pinctrl/spear/pinctrl-spear310.c           |  431 +++
 drivers/pinctrl/spear/pinctrl-spear320.c           | 3468 ++++++++++++++++++++
 drivers/pinctrl/spear/pinctrl-spear3xx.c           |  588 ++++
 drivers/pinctrl/spear/pinctrl-spear3xx.h           |   92 +
 include/linux/of_address.h                         |    5 +
 32 files changed, 6151 insertions(+), 1776 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/pinctrl_spear.txt
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
