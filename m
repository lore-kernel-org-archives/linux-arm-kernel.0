From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 17 Oct 2017 19:40:05 +0200
Subject: [GIT PULL 1/2] Rockchip dts32 updates for 4.15 part1
Message-ID: <5843673.lOC77YXMZV@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

please find below the first round of Rockchip dts32 updates targetted
for 4.15.

Thanks
Heiko

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.15-rockchip-dts32-1

for you to fetch changes up to 345b40f1e50759d09144c4aa044d07823d77c283:

  ARM: dts: rockchip: Enable thermal on rk3288-vyasa board (2017-10-14 21:10:31 +0200)

----------------------------------------------------------------
One new board the Vyasa from Amarula Solutions using a rk3288
and core lvds node for the newly added driver+binding.
Also bindings + nodes for the Mali-Utgard GPUs found on some
Rockchip socs like rk3036 and rk3188. With the recently revived
Lima project they can even render a red triangle to a png file.

----------------------------------------------------------------
Heiko Stuebner (9):
      dt-bindings: gpu: mali-utgard: Add Rockchip Utgard Malis
      dt-bindings: gpu: mali-utgard: add optional supply regulator
      dt-bindings: gpu: mali-utgard: add optional power-domain reference
      ARM: dts: rockchip: add rk3036 gpu node
      ARM: dts: rockchip: enable the gpu on rk3036-kylin boards
      ARM: dts: rockchip: add rk322x gpu node
      ARM: dts: rockchip: add gpu nodes on rk3066/rk3188
      ARM: dts: rockchip: enable gpu on rk3188-radxarock
      ARM: dts: rockchip: fix mali400 ppmmu interrupt names

Jagan Teki (4):
      dt-bindings: Add vendor prefix for Amarula Solutions
      ARM: dts: rockchip: Add rk3288 vyasa board
      ARM: dts: rockchip: enable vops and hdmi output on rk3288-vyasa
      ARM: dts: rockchip: Enable mali GPU node on rk3288-vyasa

Michael Trimarchi (1):
      ARM: dts: rockchip: Enable thermal on rk3288-vyasa board

Sandy Huang (1):
      ARM: dts: rockchip: add LVDS node for rk3288

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 .../devicetree/bindings/gpu/arm,mali-utgard.txt    |  16 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/rk3036-kylin.dts                 |   5 +
 arch/arm/boot/dts/rk3036.dtsi                      |  19 ++
 arch/arm/boot/dts/rk3066a.dtsi                     |  24 ++
 arch/arm/boot/dts/rk3188-radxarock.dts             |   4 +
 arch/arm/boot/dts/rk3188.dtsi                      |  24 ++
 arch/arm/boot/dts/rk322x.dtsi                      |  21 ++
 arch/arm/boot/dts/rk3288-vyasa.dts                 | 347 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi                      |  52 +++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  11 +
 13 files changed, 530 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk3288-vyasa.dts
