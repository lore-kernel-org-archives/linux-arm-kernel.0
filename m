From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  5 Jun 2015 19:42:43 +0100
Subject: [PATCH 0/8] regulator: pwm-regulator: Introduce continuous-mode
Message-ID: <1433529771-24496-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Continuous mode uses the PWM regulator's maximum and minimum supplied
voltages specified in the regulator-{min,max}-microvolt properties to
calculate appropriate duty-cycle values.  This allows for a much more
fine grained solution when compared with voltage-table mode, which
this driver already supports.  This solution does make an assumption
that a %50 duty-cycle value will cause the regulator voltage to run
at half way between the supplied max_uV and min_uV values.

Lee Jones (8):
  ARM: STi: STiH407: Add PWM Regulator node
  regulator: pwm-regulator: Remove unnecessary descriptor attribute from ddata
  regulator: pwm-regulator: Remove superfluous is_enabled check
  regulator: pwm-regulator: Diffientiate between dev (device) and rdev (regulator_dev)
  regulator: pwm-regulator: Don't assign structure attributes right away
  regulator: pwm-regulator: Separate voltage-table initialisation
  regulator: pwm-regulator: Add support for continuous-voltage
  regulator: pwm-regulator: Re-write bindings

 .../bindings/regulator/pwm-regulator.txt           |  66 ++++--
 arch/arm/boot/dts/stih407-family.dtsi              |  11 +
 drivers/regulator/pwm-regulator.c                  | 222 +++++++++++++++------
 3 files changed, 229 insertions(+), 70 deletions(-)

-- 
1.9.1
