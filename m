From: david.wu@rock-chips.com (David Wu)
Date: Thu, 29 Jun 2017 20:27:46 +0800
Subject: [PATCH 0/5] Add rk3328 pwm support
Message-ID: <1498739271-27431-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two features of rk3328 pwm module.
 - PWM APB and function clocks are different.
 - Add pwm atomic hardware update

David Wu (5):
  pwm: rockchip: Add APB and function both clocks support
  pwm: rockchip: Remove the judge from return value of pwm_config
  pwm: rockchip: Move the configuration of polarity from pwm_enable() to
    pwm_config()
  pwm: rockchip: Add atomic updated feature for rk3328
  Arm64: dts: rockchip: Add pwm nodes for rk3328

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   9 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 +++++
 drivers/pwm/pwm-rockchip.c                         | 184 ++++++++++++++++-----
 3 files changed, 197 insertions(+), 41 deletions(-)

-- 
1.9.1
