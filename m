From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 06 Aug 2017 11:51:04 +0200
Subject: [GIT PULL 4/4] Rockchip dts64 changes for 4.14
In-Reply-To: <12145142.47nS8LyXIe@phil>
References: <12145142.47nS8LyXIe@phil>
Message-ID: <3713539.z1Eee8O6DN@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.14-rockchip-dts64-1

for you to fetch changes up to 45a995c054e116ea9578dd6186be35f65cc0a7d0:

  arm64: dts: rockchip: update dynamic-power-coefficient for rk3399 (2017-08-01 01:00:55 +0200)

----------------------------------------------------------------
64bit Rockchip devicetree changes containing fixes for pinctrl typos
and the use of keep-power-in-suspend in non-sdio nodes as well as the
removal of the deprecated num-slots property from dwmmc nodes.

rk3328 gets support for spdif, io-domains and usb (including enablement
of usb on the evaluation board), while rk3368 gains support for spdif.

The biggest chunk of course aims for the rk3399 with a number of pcie
changes, support for the mali gpu, a new power-domain, sdmmc support
on the firefly board and dynamic-power-coefficients.

The gru family also gets support for their quite central pwm regulators
using the newly introduced vctrl regulator types.

----------------------------------------------------------------
Brian Norris (1):
      arm64: dts: rockchip: set rk3399 dynamic CPU power coefficients

Caesar Wang (5):
      arm64: dts: rockchip: add SdioAudio pd control for rk3399
      dt-bindings: gpu: add the RK3399 mali for rockchip specifics
      arm64: dts: rockchip: add ARM Mali GPU node for RK3399 SoCs
      arm64: dts: rockchip: enable the GPU for RK3399-GRU
      arm64: dts: rockchip: update dynamic-power-coefficient for rk3399

David Wu (1):
      arm64: dts: rockchip: Add rk3328 io-domain node

Klaus Goger (1):
      arm64: dts: rockchip: fix typo in mmc pinctrl

Matthias Kaehlcke (2):
      arm64: dts: rockchip: Update CPU regulator voltage ranges for Gru
      arm64: dts: rockchip: Use vctrl regulators for dynamic CPU voltages on Gru/Kevin

Shawn Lin (6):
      arm64: dts: rockchip: change clkreq mode for rk3399-evb
      arm64: dts: rockchip: remove num-slots from all platforms
      arm64: dts: rockchip: remove abused keep-power-in-suspend
      arm64: dts: rockchip: change clkreq mode for rk3399-firefly
      arm64: dts: rockchip: kill pcie_clkreqn and pcie_clkreqnb for rk3399
      arm64: dts: rockchip: enable sdmmc controller on rk3399-firefly

Sugar Zhang (2):
      arm64: dts: rockchip: add rk3368 spdif node
      arm64: dts: rockchip: add rk3328 spdif node

William Wu (2):
      arm64: dts: rockchip: add usb2 nodes for RK3328 SoCs
      arm64: dts: rockchip: enable usb2 for RK3328 evaluation board

 .../devicetree/bindings/gpu/arm,mali-midgard.txt   |   1 +
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts        |  24 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  94 ++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       |   1 -
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts    |   1 -
 .../boot/dts/rockchip/rk3368-orion-r68-meta.dts    |   2 -
 arch/arm64/boot/dts/rockchip/rk3368-px5-evb.dts    |   3 -
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts        |   2 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  19 ++++
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |   2 +-
 arch/arm64/boot/dts/rockchip/rk3399-firefly.dts    |  15 ++-
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |  44 ++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       | 119 ++++++++++++++-------
 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi   |  33 ++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi       |  33 ++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  41 +++++--
 16 files changed, 374 insertions(+), 60 deletions(-)
