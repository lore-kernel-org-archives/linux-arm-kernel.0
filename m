From: andy.yan@rock-chips.com (Andy Yan)
Date: Thu,  3 Nov 2016 20:26:15 +0800
Subject: [PATCH 0/6] Add basic support for support for Rockchip RK1108 SOC
Message-ID: <1478175975-11779-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


RK1108 is embedded with an ARM Cortex-A7 single core and a DSP core.
It is designed for varies application scenario such as car DVR, sports
DV, secure camera and UAV camera.
This patch series add basic support for it, which can boot a board with
initramfs into shell.
More new feathers will come soon.


Andy Yan (4):
  pinctrl: rockchip: add support for rk1108
  ARM: dts: add basic support for Rockchip RK1108 SOC
  ARM: add low level debug uart for rk1108
  ARM: dts: rockchip: add rockchip RK1108 Evaluation board

Shawn Lin (2):
  dt-bindings: rockchip-dw-mshc: add RK1108 dw-mshc description
  clk: rockchip: add clock controller for rk1108

 Documentation/devicetree/bindings/arm/rockchip.txt |   3 +
 .../devicetree/bindings/mmc/rockchip-dw-mshc.txt   |   1 +
 arch/arm/Kconfig.debug                             |  30 ++
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk1108-evb.dts                   |  69 +++
 arch/arm/boot/dts/rk1108.dtsi                      | 420 +++++++++++++++++++
 arch/arm/mach-rockchip/rockchip.c                  |   1 +
 drivers/clk/rockchip/Makefile                      |   1 +
 drivers/clk/rockchip/clk-rk1108.c                  | 463 +++++++++++++++++++++
 drivers/clk/rockchip/clk.h                         |  14 +
 drivers/pinctrl/pinctrl-rockchip.c                 |  27 +-
 include/dt-bindings/clock/rk1108-cru.h             | 308 ++++++++++++++
 12 files changed, 1337 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/rk1108-evb.dts
 create mode 100644 arch/arm/boot/dts/rk1108.dtsi
 create mode 100644 drivers/clk/rockchip/clk-rk1108.c
 create mode 100644 include/dt-bindings/clock/rk1108-cru.h

-- 
2.7.4
