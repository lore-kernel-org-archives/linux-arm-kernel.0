From: wxt@rock-chips.com (Caesar Wang)
Date: Tue,  1 Dec 2015 17:13:23 +0800
Subject: [PATCH 0/3] Add the rk3368 evb board with the act8846 pmic
Message-ID: <1448961206-23769-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series pacthes try to add the evb dts for rk3368 SoCs,
This's similar with the rj3288 evb board.

On the moment, pwm/backlight/usb/thermal/emmc stuff can work for this
board, I add the base version for the future firstly.

PATCH [1/3]: Force rk3368 PWM clock (and its parents) On
That's similar HACK way to work.

PATCH [2/3]: Add the RK3368 EVB board for with the act8846 pmic for dtsi

PATCH [3/3]: Add the PWM node info for rk3368 core.



Caesar Wang (3):
  clk: rockchip: Force rk3368 PWM clock (and its parents) on
  arm64: dts: rockchip: add rk3368 evaluation board
  arm64: dts: rockchip: add the pwm node info for RK3368 SoCs

 arch/arm64/boot/dts/rockchip/Makefile              |   2 +-
 .../arm64/boot/dts/rockchip/rk3368-evb-act8846.dts | 173 +++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi       | 286 +++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  60 +++++
 drivers/clk/rockchip/clk-rk3368.c                  |   9 +
 5 files changed, 529 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-evb-act8846.dts
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3368-evb.dtsi

-- 
1.9.1
