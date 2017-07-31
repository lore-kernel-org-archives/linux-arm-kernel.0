From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 31 Jul 2017 18:04:09 +0800
Subject: [PATCH 00/14] Support more devices on rockchip rv1108
Message-ID: <1501495449-21290-1-git-send-email-andy.yan@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This series try to support i2c/spi/pwm/saradc/pmic/watchdog and
the full clk tree on rockchip rv1108 soc.


Andy Yan (12):
  pinctrl: rockchip: add input schmitt support for rv1108
  dt-bindings: i2c: rk3x: add support for rv1108
  i2c: rk3x: add support for rv1108
  ARM: dts: rockchip: add i2c dt node for rv1108
  spi: rockchip: add compatible string for rv1108 spi
  ARM: dts: rockchip: add spi dt node for rv1108
  ARM: dts: rockchip: add pwm dt node for rv1108
  ARM: dts: rockchip: add watchdog dt node for rv1108
  ARM: dts: rockchip: add saradc support for rv1108
  ARM: dts: rockchip: add pwm backlight for rv1108 evb
  ARM: dts: rockchip: add pmic rk805 dt node for rv1108 evb
  ARM: dts: rockchip: add accelerometer bma250e dt node for rv1108 evb

Elaine Zhang (2):
  clk: rockchip: add more clk ids for rv1108
  clk: rockchip: support more clks for rv1108

 Documentation/devicetree/bindings/i2c/i2c-rk3x.txt |   1 +
 .../devicetree/bindings/spi/spi-rockchip.txt       |   1 +
 arch/arm/boot/dts/rv1108-evb.dts                   | 158 +++++++
 arch/arm/boot/dts/rv1108.dtsi                      | 249 ++++++++++
 drivers/clk/rockchip/clk-rv1108.c                  | 513 ++++++++++++++++-----
 drivers/i2c/busses/i2c-rk3x.c                      |   9 +
 drivers/pinctrl/pinctrl-rockchip.c                 |  31 ++
 drivers/spi/spi-rockchip.c                         |   1 +
 include/dt-bindings/clock/rv1108-cru.h             | 128 ++++-
 9 files changed, 964 insertions(+), 127 deletions(-)

-- 
2.7.4
