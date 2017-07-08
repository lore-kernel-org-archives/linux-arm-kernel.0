From: david.wu@rock-chips.com (David Wu)
Date: Sat,  8 Jul 2017 12:03:42 +0800
Subject: [PATCH v2 0/7] Add rk3328 pwm support
Message-ID: <1499486629-9659-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two features of rk3328 pwm module.
 - PWM APB and function clocks are different.
 - Add pwm atomic hardware update

David Wu (7):
  pwm: rockchip: Add APB and function both clocks support
  pwm: rockchip: Remove the judge from return value of pwm_config
  pwm: rockchip: Remove the dumplicate rockchip_pwm_ops ops
  pwm: rockchip: Use pwm_apply instead of the pwm_enable
  pwm: rockchip: Move the configuration of polarity from
    rockchip_pwm_set_enable() to rockchip_pwm_config()
  pwm: rockchip: Add rk3328 pwm support
  arm64: dts: rockchip: Add pwm nodes for rk3328

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   9 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
 drivers/pwm/pwm-rockchip.c                         | 275 ++++++++++++++-------
 3 files changed, 236 insertions(+), 93 deletions(-)

-- 
1.9.1
