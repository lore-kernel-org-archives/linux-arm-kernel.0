From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 21 Dec 2017 19:31:00 +0100
Subject: [GIT PULL 2/2] Rockchip dts64 changes for 4.16
In-Reply-To: <2013174.TmhWXT9G0E@phil>
References: <2013174.TmhWXT9G0E@phil>
Message-ID: <2062410.Qz0JYku65n@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.16-rockchip-dts64-1

for you to fetch changes up to 13bc2c0a6a14f430abaa6a859792418644b7febd:

  arm64: dts: rockchip: Add efuse device node for RK3328 SoC (2017-12-20 13:12:13 +0100)

----------------------------------------------------------------
General RK3399 gets Mipi nodes, fixes for usb3 support and better support
for the type-c phys. The Kevin Chromebooks based on rk3399 now can use their
internal edp displays. RK3328 gets its efuse node and Mali450 gpu node,
which actually produces already some nice results with the WIP Lima driver.

----------------------------------------------------------------
Brian Norris (1):
      arm64: dts: rockchip: add rk3399 DSI0 reset

Enric Balletbo i Serra (5):
      arm64: dts: rockchip: add pd_usb3 power-domain node for rk3399
      arm64: dts: rockchip: add the aclk_usb3 clocks for USB3 on rk3399
      arm64: dts: rockchip: add reset property for dwc3 controllers on rk3399
      arm64: dts: rockchip: add usb3-phy otg-port support for rk3399
      arm64: dts: rockchip: add extcon nodes and enable tcphy rk3399-gru

Finley Xiao (1):
      arm64: dts: rockchip: Add efuse device node for RK3328 SoC

Heiko Stuebner (2):
      dt-bindings: gpu: mali-utgard: add rockchip,rk3328-mali compatible
      arm64: dts: rockchip: add rk3328 mali gpu node

Jeffy Chen (1):
      arm64: dts: rockchip: Enable edp disaplay on kevin

Nickey Yang (2):
      arm64: dts: rockchip: add mipi_dsi1 support for rk3399
      arm64: dts: rockchip: update mipi cells for RK3399

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           | 47 ++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  | 29 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 42 +++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           | 85 +++++++++++++++++++---
 5 files changed, 195 insertions(+), 9 deletions(-)
