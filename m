From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  6 Jul 2015 09:58:22 +0100
Subject: [RESEND 00/10] regulator: pwm-regulator: Introduce continuous-mode
Message-ID: <1436173112-21397-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch-set has been rebased on to v4.2-rc1.
 
Continuous mode uses the PWM regulator's maximum and minimum supplied
voltages specified in the regulator-{min,max}-microvolt properties to
calculate appropriate duty-cycle values.  This allows for a much more
fine grained solution when compared with voltage-table mode, which
this driver already supports.  This solution does make an assumption
that a %50 duty-cycle value will cause the regulator voltage to run
at half way between the supplied max_uV and min_uV values.

Lee Jones (10):
  ARM: multi_v7_defconfig: Enable ST's PWM driver
  ARM: multi_v7_defconfig: Enable ST's Power Reset driver
  ARM: multi_v7_defconfig: Enable support for PWM Regulators
  ARM: STi: STiH407: Move PWM nodes STiH407 => STiH407-family
  ARM: STi: STiH407: Add PWM Regulator node
  dt: regulator: pwm-regulator: Re-write bindings
  regulator: pwm-regulator: Separate voltage-table initialisation
  regulator: pwm-regulator: Add support for continuous-voltage
  regulator: pwm-regulator: Simplify voltage to duty-cycle call
  regulator: pwm-regulator: Don't assign structure attributes right away

 .../bindings/regulator/pwm-regulator.txt           |  66 ++++++--
 arch/arm/boot/dts/stih407-family.dtsi              |  41 +++++
 arch/arm/boot/dts/stih407.dtsi                     |  28 ----
 arch/arm/configs/multi_v7_defconfig                |   3 +
 drivers/regulator/pwm-regulator.c                  | 172 ++++++++++++++++-----
 5 files changed, 234 insertions(+), 76 deletions(-)

-- 
1.9.1
