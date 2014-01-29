From: mporter@linaro.org (Matt Porter)
Date: Wed, 29 Jan 2014 15:59:54 -0500
Subject: [PATCH 0/5] IIO pulse capture support for TI ECAP
Message-ID: <1391029199-3670-1-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for PWM capture devices within IIO and
adds a TI ECAP IIO driver.

PWM capture devices are supported using a new IIO "pulse" channel type.

The IIO ECAP driver implements interrupt driven triggered buffer capture
only as raw sample reads are not applicable to this hardware.
Initially, the driver supports a single pulse width measurement with
configurable polarity. The ECAP hardware can support measurement of a
complete period and duty cycle but this is not yet implemented.

Matt Porter (5):
  iio: add support for pulse width capture devices
  iio: pulse: add TI ECAP driver
  iio: enable selection and build of pulse drivers
  pwm: enable TI PWMSS if the IIO tiecap driver is selected
  ARM: dts: AM33XX: Add ecap interrupt properties

 arch/arm/boot/dts/am33xx.dtsi   |   6 +
 drivers/iio/Kconfig             |   1 +
 drivers/iio/Makefile            |   1 +
 drivers/iio/industrialio-core.c |   1 +
 drivers/iio/pulse/Kconfig       |  20 ++
 drivers/iio/pulse/Makefile      |   6 +
 drivers/iio/pulse/tiecap.c      | 493 ++++++++++++++++++++++++++++++++++++++++
 drivers/pwm/Kconfig             |   2 +-
 include/linux/iio/types.h       |   1 +
 9 files changed, 530 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iio/pulse/Kconfig
 create mode 100644 drivers/iio/pulse/Makefile
 create mode 100644 drivers/iio/pulse/tiecap.c

-- 
1.8.4
