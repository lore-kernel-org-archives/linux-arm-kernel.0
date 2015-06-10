From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 10 Jun 2015 08:57:48 +0100
Subject: [REBASED 0/5] regulator: pwm-regulator: Introduce continuous-mode
Message-ID: <1433923073-907-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Continuous mode uses the PWM regulator's maximum and minimum supplied
voltages specified in the regulator-{min,max}-microvolt properties to
calculate appropriate duty-cycle values.  This allows for a much more
fine grained solution when compared with voltage-table mode, which
this driver already supports.  This solution does make an assumption
that a %50 duty-cycle value will cause the regulator voltage to run
at half way between the supplied max_uV and min_uV values.

Lee Jones (5):
  ARM: STi: STiH407: Add PWM Regulator node
  regulator: pwm-regulator: Separate voltage-table initialisation
  regulator: pwm-regulator: Add support for continuous-voltage
  dt: regulator: pwm-regulator: Re-write bindings
  regulator: pwm-regulator: Don't assign structure attributes right away

 .../bindings/regulator/pwm-regulator.txt           |  66 ++++++--
 arch/arm/boot/dts/stih407-family.dtsi              |  11 ++
 drivers/mfd/mfd-child.c                            |  47 ++++++
 drivers/regulator/pwm-regulator.c                  | 185 +++++++++++++++++----
 4 files changed, 261 insertions(+), 48 deletions(-)
 create mode 100644 drivers/mfd/mfd-child.c

-- 
1.9.1
