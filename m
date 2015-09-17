From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Sep 2015 14:45:50 +0100
Subject: [PATCH v2 0/7] hwrng: Add support for STMicroelectronics' RNG IP
Message-ID: <1442497557-9271-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v1 => v2:
 - New patch: Also fixing /dev/hw_random => /dev/hwrng in Kconfig
 - Fix 2099 => 2009 typo in commit log
 - Fix 'number of random numbers sourced' return value
 - Treat devm_clk_get()'s return value correctly
 - Check return value of clk_prepare_enable()
 - Use sysfs_streq() instead of manually stripping '\n' from sysfs

The main aim of this set is to allow users to access ST's hardware
random number generator.  It's a simple device, which only requires
a simple driver.

We're also taking the liberty to update some out of date HWRNG
documentation and making the sysfs interface a little easier to
use by ignoring any '\n' which may have been inadvertently passed.

Lee Jones (7):
  Documentation: hw_random: Fix device node name reference
    /dev/hw_random => /dev/hwrng
  hwrng: Kconfig: Fix device node name reference /dev/hw_random =>
    /dev/hwrng
  hwrng: core: Simplify RNG switching from sysfs
  hwrng: st: Provide DT bindings for ST's Random Number Generator
  hwrng: st: Add support for ST's HW Random Number Generator
  ARM: STi: STiH407: Enable the 2 HW Random Number Generators for
    STiH4{07,10}
  MAINTAINERS: Add ST's Random Number Generator to the ST entry

 Documentation/devicetree/bindings/rng/st,rng.txt |  15 +++
 Documentation/hw_random.txt                      |   8 +-
 MAINTAINERS                                      |   1 +
 arch/arm/boot/dts/stih407-family.dtsi            |  14 +++
 drivers/char/hw_random/Kconfig                   |  12 +-
 drivers/char/hw_random/Makefile                  |   1 +
 drivers/char/hw_random/core.c                    |   2 +-
 drivers/char/hw_random/st-rng.c                  | 144 +++++++++++++++++++++++
 8 files changed, 191 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/st,rng.txt
 create mode 100644 drivers/char/hw_random/st-rng.c

-- 
1.9.1
