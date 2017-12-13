From: hao5781286@gmail.com (hao_zhang)
Date: Wed, 13 Dec 2017 22:38:40 +0800
Subject: [PATCH v4 0/4] pwm support for allwinner sun8i R40/V40/T3 SOCs.
Message-ID: <20171213143840.GA17754@arx-s1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset add pwm support for allwinner sun8i R40/V40/T3 SOCs.

all has been teat on T3 board.

Some features
	8 PWM channels outputs(4 PWM pairs) 
	Supports capturing input 
	Supports three kinds of output waveforms: continuous waveform, pulse
	waveform and complementarity pair 
	Programmable deadzone generator and controllable dead-time 
	0% to 100% adjustable duty cycle 
	Up to 24/100MHz output frequency 
	Minimum resolution is 1/65536 
	Supports interrupt for PWM output and capturing input


DOC:
https://github.com/tinalinux/docs/blob/r40-v1.y/Allwinner_R40_User_Manual_V1.0.pdf
https://github.com/tinalinux/docs/blob/r40-v1.y/R40_Datasheet_V1.0.pdf

Regards;-)
Hao Zhang

hao_zhang (4):
  dt-bindings: pwm: binding allwinner R40, V40, T3
  ARM: PWM: add allwinner sun8i R40/V40/T3 pwm support.
  ARM: dts: add pwm node for r40.
  ARM: pinctrl: sunxi-pinctrl: fix pin funtion can not be match
    correctly.

 .../devicetree/bindings/pwm/pwm-sun8i.txt          |  18 +
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |   6 +
 arch/arm/boot/dts/sun8i-r40.dtsi                   |  13 +
 drivers/pinctrl/sunxi/pinctrl-sunxi.c              |   6 +-
 drivers/pwm/Kconfig                                |  10 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun8i-r40.c                        | 449 +++++++++++++++++++++
 7 files changed, 501 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
 create mode 100644 drivers/pwm/pwm-sun8i-r40.c

-- 
2.7.4
