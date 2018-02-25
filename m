From: hao5781286@gmail.com (hao_zhang)
Date: Sun, 25 Feb 2018 21:49:46 +0800
Subject: [PATCH v2 0/4] pwm support for allwinner sun8i SOCs.
Message-ID: <20180225134946.GA14015@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PWM support for allwinner sun8i SOCs.

This patchset adds pwm support for allwinner sun8i SOCs.


v2 Changes:
1. change sun8i-r40 symbol to sun8i.
2. change pwm0_pin, pwm0-pin to pwm_ch0_pin, pwm-ch0-pin.
3. remove clk_disable_unprepare(), check !match and IS_ERR(pwm->regmap).




hao_zhang (4):
  dt-bindings: pwm: binding allwinner sun8i.
  ARM: dtsi: add pwm node for sun8i.
  ARM: dts: add pwm status for r40.
  ARM: PWM: add allwinner sun8i pwm support.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  18 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  13 +
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i.c                            | 401 +++++++++++++++++++++
 6 files changed, 449 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i.c

-- 
2.7.4
