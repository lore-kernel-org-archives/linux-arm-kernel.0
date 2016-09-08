From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 08 Sep 2016 16:11:52 +0200
Subject: [GIT PULL 3/3] Rockchip dts64 changes for 4.9
In-Reply-To: <1770547.rOXegfrGOH@phil>
References: <1770547.rOXegfrGOH@phil>
Message-ID: <5210110.HMx7zZ3pZH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below main 64 bit devicetree changes for 4.9.

So if nothing stands out, please pull

Thanks
Heiko

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.9-rockchip-dts64-1

for you to fetch changes up to f606193a10e7d0eb6766ae525e9051417a59f8d9:

  arm64: dts: rockchip: add Type-C phy for RK3399 (2016-09-07 20:20:08 +0200)

----------------------------------------------------------------
64bit Rockchip devicetree changes containing support for the recently
added firmware reboot-flag support, one new board the Tronsmart Orion
based on the rk3368 and a large number of newly supported peripherals
for the rk3399 (type-c phy, usb2 phy, pcie controller and pcie phy,
gmac, arm-pmu using ppi partitioning, efuse, saradc) as well as some
smaller housekeeping and non-critical fixes.

----------------------------------------------------------------
Andy Yan (2):
      soc: rockchip: add reboot-mode header
      arm64: dts: rockchip: add syscon-reboot-mode DT node

Caesar Wang (5):
      arm64: dts: rockchip: add the saradc for rk3399
      arm64: dts: rockchip: add the gmac power domain on rk3399
      arm64: dts: rockchip: add the tcpc for rk3399 power domain
      arm64: dts: rockchip: change all interrupts cells to 4 on rk3399 SoCs
      arm64: dts: rockchip: support the pmu node for rk3399

Chris Zhong (1):
      arm64: dts: rockchip: add Type-C phy for RK3399

Douglas Anderson (1):
      arm64: dts: rockchip: Add pinctrl entry for 32k clock on rk3399

Elaine Zhang (1):
      arm64: dts: rockchip: add the power domain node for rk3399

Finley Xiao (1):
      arm64: dts: rockchip: add efuse0 device node for rk3399

Frank Wang (2):
      arm64: dts: rockchip: add usb2-phy support for rk3399
      arm64: dts: rockchip: configure usb2-phy support for rk3399-evb

Heiko Stuebner (1):
      Merge branch 'v4.9-shared/soc-hdr' into v4.9-armsoc/dts64

Matthias Brugger (1):
      arm64: dts: rockchip: Add basic support for orion-r68

Roger Chen (2):
      arm64: dts: rockchip: add the gmac needed node for rk3399
      arm64: dts: rockchip: enable the gmac for rk3399 evb board

Shawn Lin (4):
      arm64: dts: rockchip: remove broken-cd from sdio0
      arm64: dts: rockchip: add the PCIe PHY for RK3399
      arm64: dts: rockchip: add the PCIe controller support for RK3399
      arm64: dts: rockchip: configure PCIe support for rk3399-evb

Shunqian Zheng (1):
      arm64: dts: rockchip: set to CCI clock of RK3399 to 600M

Xing Zheng (1):
      arm64: dts: rockchip: fix the address map for WDT0 and WDT1

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    | 382 +++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  10 +
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  87 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 607 +++++++++++++++++++--
 include/dt-bindings/soc/rockchip,boot-mode.h       |  15 +
 8 files changed, 1053 insertions(+), 54 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
 create mode 100644 include/dt-bindings/soc/rockchip,boot-mode.h
