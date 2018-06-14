From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 14 Jun 2018 13:30:35 +0200
Subject: [PATCH 0/4] arm64: dts: rockchip: add RK3399-Gru-Bob and prepare for
 Scarlet
Message-ID: <20180614113039.29117-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far the Gru series of ChromeOS devices has seen 3 public devices.
Two clamshell devices with the already supported Kevin and Bob
(aka Chromebook Flip C101PA), as well as one table-style device Scarlet.

So this series not only adds a devicetree file for Bob, but also prepares
for Scarlets arrival, in that common properties of the clamshell-devices
get moved into a rk3399-gru-chromebook.dtsi, similar to what we have on
RK3288-Veyron, as Scarlet does some things a bit differently.

Scarlet itself needs a bit more time, as its display is connected via
dual-dsi, where the patches are still pending.


Heiko Stuebner (4):
  arm64: dts: rockchip: move Chromebook-specific Gru-parts to a separate
    file
  arm64: dts: rockchip: add phandles to some nodes on rk3399-gru
  arm64: dts: rockchip: move core edp from rk3399-kevin to shared
    chromebook
  arm64: dts: rockchip: add Google Bob

 .../devicetree/bindings/arm/rockchip.txt      |   9 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3399-gru-bob.dts      |  79 ++++
 .../dts/rockchip/rk3399-gru-chromebook.dtsi   | 399 ++++++++++++++++++
 .../boot/dts/rockchip/rk3399-gru-kevin.dts    |  47 +--
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi  | 328 +-------------
 6 files changed, 496 insertions(+), 367 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-bob.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-gru-chromebook.dtsi

-- 
2.17.0
