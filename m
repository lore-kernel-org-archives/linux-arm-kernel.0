From: heiko@sntech.de (Heiko Stuebner)
Date: Tue,  5 Sep 2017 12:57:32 +0200
Subject: [PATCH 0/7] ARM: dts: rockchip: add Utgard Mali nodes for some socs
Message-ID: <20170905105739.8330-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a mali-supply similar to the Midgard binding, the
compatibles for 3 Rockchip socs and the nodes for these.

The rk3036 and rk3188 gpus were tested, on the boards that
get their gpus enabled, using the current Lima resurrection
project and were able to probe the gpus sucessfully.

The only special thing Rockchip Malis do, is that all MMUs have
a shared interrupt and all PPs also have a shared interrupt, but
that works out well with the current binding.


Heiko Stuebner (7):
  dt-bindings: gpu: mali-utgard: Add Rockchip Utgard Malis
  dt-bindings: gpu: mali-utgard: add optional supply regulator
  ARM: dts: rockchip: add rk3036 gpu node
  ARM: dts: rockchip: enable the gpu on rk3036-kylin boards
  ARM: dts: rockchip: add rk322x gpu node
  ARM: dts: rockchip: add gpu nodes on rk3066/rk3188
  ARM: dts: rockchip: enable gpu on rk3188-radxarock

 .../devicetree/bindings/gpu/arm,mali-utgard.txt    | 10 +++++++++
 arch/arm/boot/dts/rk3036-kylin.dts                 |  5 +++++
 arch/arm/boot/dts/rk3036.dtsi                      | 19 +++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     | 24 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3188-radxarock.dts             |  4 ++++
 arch/arm/boot/dts/rk3188.dtsi                      | 24 ++++++++++++++++++++++
 arch/arm/boot/dts/rk322x.dtsi                      | 21 +++++++++++++++++++
 arch/arm/boot/dts/rk3xxx.dtsi                      | 11 ++++++++++
 8 files changed, 118 insertions(+)

-- 
2.14.1
