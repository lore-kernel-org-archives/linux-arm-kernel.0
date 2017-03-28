From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Mar 2017 17:52:31 +0200
Subject: [GIT PULL 1/3] Rockchip dts32 updates for 4.12 part1
Message-ID: <5178456.jWASpzTAdU@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

This set is the first round of devicetree updates for 4.12. It comes
in 3 parts, 32bit dts, general 64bit dts and the 64bit dts based on
Olof's shared symlink branch.
As always tags describe what's in there.

So if nothing stands out, please pull.


Thanks
Heiko

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git tags/v4.12-rockchip-dts32-1

for you to fetch changes up to 94bbdd77247d8c16eed5f55dddcf1cbc38d06cc4:

  ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc for rk3188 (2017-03-22 16:49:39 +0100)

----------------------------------------------------------------
Contains one new board, the Tinkerboard from Asus based on the rk3288,
definitions for the mmc resets in the socs reset controller, sound
support for the Rock2, dma support for mmc controllers on the rk3188
and a led-fix for the MiQi board and and irq-fix for older Cortex-A9 socs.

----------------------------------------------------------------
Alexander Kochetkov (1):
      ARM: dts: rockchip: setup DMA-channels for mmc0 and emmc for rk3188

Eddie Cai (2):
      dt-bindings: add rk3288-based Asus Tinker board
      ARM: dts: rockchip: add dts for RK3288-Tinker board

Heiko Stuebner (5):
      ARM: dts: rockchip: add rk3288 dw-mmc resets
      ARM: dts: rockchip: add rk3036 dw-mmc resets
      ARM: dts: rockchip: add rk3066/rk3188 dw-mmc resets
      ARM: dts: rockchip: add rk322x dw-mmc resets
      ARM: dts: rockchip: fix PPI misconfiguration on Cortex-A9 socs

Romain Perier (1):
      ARM: dts: rockchip: Add support for ES8388 to the Radxa Rock 2

Willy Tarreau (1):
      ARM: dts: rockchip: fix the MiQi board's LED definition

 Documentation/devicetree/bindings/arm/rockchip.txt |   3 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3036.dtsi                      |   6 +
 arch/arm/boot/dts/rk3188.dtsi                      |   4 +-
 arch/arm/boot/dts/rk322x.dtsi                      |   2 +
 arch/arm/boot/dts/rk3288-miqi.dts                  |  12 +-
 arch/arm/boot/dts/rk3288-rock2-som.dtsi            |   2 +-
 arch/arm/boot/dts/rk3288-rock2-square.dts          |  41 ++
 arch/arm/boot/dts/rk3288-tinker.dts                | 536 +++++++++++++++++++++
 arch/arm/boot/dts/rk3288.dtsi                      |   8 +
 arch/arm/boot/dts/rk3xxx.dtsi                      |  16 +-
 11 files changed, 616 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3288-tinker.dts
