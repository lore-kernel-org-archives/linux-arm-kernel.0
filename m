From: heiko@sntech.de (Heiko Stuebner)
Date: Sun, 27 Jul 2014 01:18:16 +0200
Subject: [PATCH v2 00/15] ARM: dts: rockchip: collected changes for existing
 boards
Message-ID: <1406416711-28006-1-git-send-email-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are collected dtsi changes to bring the existing dts files in line with
what the rk3288 does and add support for drivers that made it into a tree recently.

changes since v1:
- adapt to suggestions received for rk3288

Beniamino Galvani (3):
  ARM: dts: add i2c and regulator nodes to rk3188-radxarock
  ARM: dts: rockchip: add pwm nodes
  ARM: dts: rk3188-radxarock: add GPIO IR receiver node

Heiko Stuebner (12):
  ARM: dts: rockchip: add cru nodes and update device clocks to use it
  ARM: dts: rockchip: move oscillator input clock into main dtsi
  arm: dts: rockchip: remove obsolete clock gate definitions
  ARM: dts: rockchip: remove soc subnodes
  ARM: dts: rockchip: add handles for shared nodes that don't have one
    yet
  ARM: dts: uses handles to reference nodes for changes
  ARM: dts: rockchip: remove address from pinctrl nodes
  ARM: dts: rockchip: oder nodes by register address
  ARM: dts: add rk3066 and rk3188 i2c device nodes and pinctrl settings
  ARM: dts: rockchip: add tps65910 regulator for bqcurie2
  ARM: dts: rk3188-radxarock: enable sd-card slot
  ARM: dts: rockchip: add both clocks to uart nodes

 arch/arm/boot/dts/rk3066a-bqcurie2.dts | 210 +++++++++-----
 arch/arm/boot/dts/rk3066a-clocks.dtsi  | 299 -------------------
 arch/arm/boot/dts/rk3066a.dtsi         | 515 +++++++++++++++++++++------------
 arch/arm/boot/dts/rk3188-clocks.dtsi   | 289 ------------------
 arch/arm/boot/dts/rk3188-radxarock.dts | 216 +++++++++++---
 arch/arm/boot/dts/rk3188.dtsi          | 442 ++++++++++++++++++----------
 arch/arm/boot/dts/rk3xxx.dtsi          | 348 ++++++++++++++--------
 7 files changed, 1176 insertions(+), 1143 deletions(-)
 delete mode 100644 arch/arm/boot/dts/rk3066a-clocks.dtsi
 delete mode 100644 arch/arm/boot/dts/rk3188-clocks.dtsi

-- 
2.0.1
