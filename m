From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Wed,  9 Dec 2015 17:04:05 +0800
Subject: [PATCH v1 0/8] This serial of patches add dts/pinctrl/clock-tree/doc
 for rk3228
Message-ID: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

platform, with these patches, my evb board could boot into initramfs.


Jeffy Chen (8):
  pinctrl: rockchip: add support for the rk3228
  clk: rockchip: add dt-binding header for rk3228
  rockchip: add clock controller for rk3228
  dt-bindings: add documentation of rk3228 clock controller
  clk: rockchip: allow more than 2 parents for cpuclk
  ARM: rockchip: enable support for RK3228 SoCs
  ARM: dts: rockchip: add core rk3228 dtsi
  ARM: dts: rockchip: add rk3228-evb board

 .../bindings/clock/rockchip,rk3228-cru.txt         |  58 ++
 .../bindings/pinctrl/rockchip,pinctrl.txt          |   3 +-
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3228-evb.dts                   |  56 ++
 arch/arm/boot/dts/rk3228.dtsi                      | 478 +++++++++++++
 arch/arm/mach-rockchip/rockchip.c                  |   1 +
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-cpu.c                     |   4 +-
 drivers/clk/rockchip/clk-rk3228.c                  | 762 +++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |  11 +-
 drivers/pinctrl/pinctrl-rockchip.c                 |  53 ++
 include/dt-bindings/clock/rk3228-cru.h             | 220 ++++++
 12 files changed, 1644 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/rockchip,rk3228-cru.txt
 create mode 100644 arch/arm/boot/dts/rk3228-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3228.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk3228.c
 create mode 100644 include/dt-bindings/clock/rk3228-cru.h

-- 
2.1.4
