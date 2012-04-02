From: viresh.kumar@st.com (Viresh Kumar)
Date: Mon, 2 Apr 2012 11:12:46 +0530
Subject: [GIT PULL] ARM: spear-soc DT support for 3.5
Message-ID: <4F793C56.2030605@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Olof,

The following changes since commit dd775ae2549217d3ae09363e3edb305d0fa19928:

  Linux 3.4-rc1 (2012-03-31 16:24:09 -0700)

are available in the git repository at:

  git://git.stlinux.com/spear/linux-2.6.git spear-dt

for you to fetch changes up to 8f21ec99c7b78c3f0baf6bbf2e438da68da3dc08:

  SPEAr: Update defconfigs (2012-04-02 09:03:59 +0530)

----------------------------------------------------------------
Stefan Roese (1):
      ARM: SPEAr600: Change FSMC and SMI clock names

Viresh Kumar (8):
      SPI/Pl022: Include types.h to remove compilation warnings
      SPEAr: Use CLKDEV_INIT for defining clk_lookups
      SPEAr3xx: Add clock instance of usb hosts - ehci and ohci 0 and 1
      SPEAr6xx: Add compilation support for dtbs using 'make dtbs'
      SPEAr3xx: Replace printk() with pr_*()
      ARM: SPEAr3xx: Add device-tree support to SPEAr3xx architecture
      SPEAr: Add PL080 DMA support for 3xx and 6xx
      SPEAr: Update defconfigs

 Documentation/arm/SPEAr/overview.txt            |   13 +-
 Documentation/devicetree/bindings/arm/spear.txt |   18 ++
 arch/arm/boot/dts/spear300-evb.dts              |  183 +++++++++++
 arch/arm/boot/dts/spear300.dtsi                 |   72 +++++
 arch/arm/boot/dts/spear310-evb.dts              |  111 +++++++
 arch/arm/boot/dts/spear310.dtsi                 |   75 +++++
 arch/arm/boot/dts/spear320-evb.dts              |  112 +++++++
 arch/arm/boot/dts/spear320.dtsi                 |   90 ++++++
 arch/arm/boot/dts/spear3xx.dtsi                 |  144 +++++++++
 arch/arm/boot/dts/spear600-evb.dts              |    4 +
 arch/arm/boot/dts/spear600.dtsi                 |    8 +
 arch/arm/configs/spear3xx_defconfig             |   52 +++-
 arch/arm/configs/spear6xx_defconfig             |   41 ++-
 arch/arm/mach-spear3xx/Kconfig                  |   34 +--
 arch/arm/mach-spear3xx/Makefile                 |   13 +-
 arch/arm/mach-spear3xx/Makefile.boot            |    4 +
 arch/arm/mach-spear3xx/clock.c                  |  182 +++++++-----
 arch/arm/mach-spear3xx/include/mach/generic.h   |   31 +--
 arch/arm/mach-spear3xx/include/mach/hardware.h  |    3 -
 arch/arm/mach-spear3xx/include/mach/spear.h     |    9 +-
 arch/arm/mach-spear3xx/spear300.c               |  294 ++++++++++++++++--
 arch/arm/mach-spear3xx/spear300_evb.c           |   75 -----
 arch/arm/mach-spear3xx/spear310.c               |  329 +++++++++++++++++++--
 arch/arm/mach-spear3xx/spear310_evb.c           |   81 -----
 arch/arm/mach-spear3xx/spear320.c               |  328 +++++++++++++++++++--
 arch/arm/mach-spear3xx/spear320_evb.c           |   79 -----
 arch/arm/mach-spear3xx/spear3xx.c               |  148 +++++----
 arch/arm/mach-spear6xx/Makefile.boot            |    2 +
 arch/arm/mach-spear6xx/clock.c                  |   80 +++---
 arch/arm/mach-spear6xx/spear6xx.c               |  372 ++++++++++++++++++++++-
 arch/arm/plat-spear/Kconfig                     |    3 +-
 arch/arm/plat-spear/Makefile                    |    2 +-
 arch/arm/plat-spear/include/plat/pl080.h        |   21 ++
 arch/arm/plat-spear/pl080.c                     |   79 +++++
 include/linux/amba/pl022.h                      |    2 +
 35 files changed, 2507 insertions(+), 587 deletions(-)
 create mode 100644 arch/arm/boot/dts/spear300-evb.dts
 create mode 100644 arch/arm/boot/dts/spear300.dtsi
 create mode 100644 arch/arm/boot/dts/spear310-evb.dts
 create mode 100644 arch/arm/boot/dts/spear310.dtsi
 create mode 100644 arch/arm/boot/dts/spear320-evb.dts
 create mode 100644 arch/arm/boot/dts/spear320.dtsi
 create mode 100644 arch/arm/boot/dts/spear3xx.dtsi
 delete mode 100644 arch/arm/mach-spear3xx/spear300_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear310_evb.c
 delete mode 100644 arch/arm/mach-spear3xx/spear320_evb.c
 create mode 100644 arch/arm/plat-spear/include/plat/pl080.h
 create mode 100644 arch/arm/plat-spear/pl080.c

-- 
viresh
