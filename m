From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 26 Nov 2018 11:07:16 +0100
Subject: [GIT PULL 3/3] Rockchip dts64 updates for 4.21
In-Reply-To: <49803144.2ZsBJmaiIN@phil>
References: <49803144.2ZsBJmaiIN@phil>
Message-ID: <34315565.W3E18QRAdZ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:

  Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git v4.21-rockchip-dts64-1

for you to fetch changes up to cdd46460fe278e04d8ee665d975aa2962036838f:

  arm64: dts: rockchip: Add all CPUs in cooling maps (2018-11-19 14:45:35 +0100)

----------------------------------------------------------------
New dts for Gru-Scarlet (tablet device), default backlight brightness
for all Gru devices, rk3399 spi dma properties, some improvements for
the rk3399-sapphire board (fan, chosen, backlight), hs200 mode for the
emmc on the rock64 and declaring all cpu cores in the cooling maps
instead of just cpu0.

----------------------------------------------------------------
Emil Renner Berthing (1):
      arm64: dts: rockchip: add rk3399 SPI DMAs

Enric Balletbo i Serra (1):
      arm64: dts: rockchip: Use default brightness table for rk3399-gru

Heiko Stuebner (1):
      arm64: dts: rockchip: add Gru Scarlet devicetrees

Vasily Khoruzhick (1):
      arm64: dts: rockchip: enable HS200 for eMMC on rock64

Vicente Bergas (3):
      arm64: dts: rockchip: add fan on rk3399-sapphire board
      arm64: dts: rockchip: add chosen node on rk3399-sapphire
      arm64: dts: rockchip: move backlight from rk3399 sapphire to excavator

Viresh Kumar (1):
      arm64: dts: rockchip: Add all CPUs in cooling maps

 Documentation/devicetree/bindings/arm/rockchip.txt |  34 ++
 arch/arm64/boot/dts/rockchip/Makefile              |   2 +
 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts     |   1 +
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |   5 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  15 +-
 .../boot/dts/rockchip/rk3399-gru-chromebook.dtsi   |   8 -
 arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts  |   8 +-
 .../boot/dts/rockchip/rk3399-gru-scarlet-inx.dts   |  33 ++
 .../boot/dts/rockchip/rk3399-gru-scarlet-kd.dts    |  33 ++
 .../boot/dts/rockchip/rk3399-gru-scarlet.dtsi      | 594 +++++++++++++++++++++
 .../dts/rockchip/rk3399-sapphire-excavator.dts     |  46 +-
 arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi  |  77 +--
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  22 +-
 13 files changed, 819 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-inx.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet-kd.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-scarlet.dtsi
