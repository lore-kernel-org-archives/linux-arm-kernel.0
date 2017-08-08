From: david.wu@rock-chips.com (David Wu)
Date: Tue,  8 Aug 2017 23:38:28 +0800
Subject: [PATCH v3 0/7] Add rk3328 pwm support
Message-ID: <1502206715-24174-1-git-send-email-david.wu@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are two features of rk3328 pwm module.
 - PWM APB and function clocks are different.
 - Add pwm atomic hardware update

David Wu (7):
  pwm: rockchip: Add APB and function both clocks support
  pwm: rockchip: Remove the judge from return value of pwm_config
  pwm: rockchip: Use pwm_apply instead of the pwm_enable
  pwm: rockchip: Move the configuration of polarity from
    rockchip_pwm_set_enable() to rockchip_pwm_config()
  pwm: rockchip: Use same pwm ops for each IP
  pwm: rockchip: Add rk3328 pwm support
  arm64: dts: rockchip: Add pwm nodes for rk3328

 .../devicetree/bindings/pwm/pwm-rockchip.txt       |   8 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi           |  45 ++++
 drivers/pwm/pwm-rockchip.c                         | 281 +++++++++++----------
 3 files changed, 199 insertions(+), 135 deletions(-)

-- 
1.9.1
