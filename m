From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 15 Mar 2018 23:22:59 +0100
Subject: [GIT PULL 4/4] Rockchip dts64 changes for 4.17
In-Reply-To: <12470502.BUvxkRrZk8@phil>
References: <12470502.BUvxkRrZk8@phil>
Message-ID: <1852590.WiPauY1nNm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.17-rockchip-dts64-1

for you to fetch changes up to 3783f1eb8a8db3747e753c4aa972124e1309db4e:

  arm64: dts: rockchip: remove keep-power-in-suspend from sdhci of rk3399-sapphire (2018-03-13 13:01:03 +0100)

----------------------------------------------------------------
The rk3399 gained support its Cadence displayport controller and some
minor additions like pins for 2ch i2s0 and the cif test clocks as well
as a default rate for ACLK_VIO that should be 400MHz according to the TRM.

The rk3328 got uart dmas fixed - a non-critical fix, as nobody was using
that so far.

New boards are the rk3328-based roc-rk3328-cc, the rk3368-based Lion-SOM
+ baseborad from Theobroma Systems and a standalone variant of the Sapphire
board, as a lot of people where using that without the Exkavator baseboard.

Sapphire also saw a lot of small cleanups of things that are not part
of the actual Sapphire board, but the baseboard instead. The rk3399-puma
board got i2s and tsadc support and Gru got its DP node enabled.

----------------------------------------------------------------
Chris Zhong (2):
      arm64: dts: rockchip: add cdn-dp node for rk3399.
      arm64: dts: rockchip: enable DP for rk3399-gru

Heiko Stuebner (2):
      arm64: dts: rockchip: move rk3399-sapphire sdio to excavator baseboard
      arm64: dts: rockchip: add a standalone version of the rk3399 sapphire

Klaus Goger (7):
      arm64: dts: rockchip: enable tsadc on rk3399-puma
      arm64: dts: rockchip: add i2s0-2ch-bus pins on rk3399
      dt-bindings: add RK3368-uQ7 SoM and EVK base board
      arm64: dts: rockchip: add RK3368-uQ7 (Lion) SoM
      arm64: dts: rockchip: add Haikou baseboard with RK3368-uQ7 SoM
      arm64: dts: rockchip: move i2s0 node from baseboard to SoM on rk3399-puma
      arm64: dts: rockchip: enable I2S codec on rk3399-puma-haikou

Levin Du (1):
      arm64: dts: rockchip: add roc-rk3328-cc board

Robin Murphy (1):
      arm64: dts: rockchip: Fix RK3328 UART DMAs

Shawn Lin (1):
      arm64: dts: rockchip: remove keep-power-in-suspend from sdhci of rk3399-sapphire

Shunqian Zheng (2):
      arm64: dts: rockchip: Add cif test clocks for rk3399
      arm64: dts: rockchip: assign clock rate for ACLK_VIO on rk3399

Vicente Bergas (3):
      arm64: dts: rockchip: vdd_log on rk3399-sapphire is not an i2c slave
      arm64: dts: rockchip: move rk3399-sapphire i2s2 to daughterboard
      arm64: dts: rockchip: move rk3399-sapphire pwr_btn to daughterboard

 Documentation/devicetree/bindings/arm/rockchip.txt |  12 +
 arch/arm64/boot/dts/rockchip/Makefile              |   3 +
 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts     | 267 +++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   6 +-
 .../arm64/boot/dts/rockchip/rk3368-lion-haikou.dts | 146 ++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi      | 317 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi       |  13 +-
 .../arm64/boot/dts/rockchip/rk3399-puma-haikou.dts |  71 ++++-
 arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi      |  28 ++
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  44 ++-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts   |  12 +
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |  67 +++--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  79 ++++-
 13 files changed, 993 insertions(+), 72 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3328-roc-cc.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion-haikou.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-lion.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dts
