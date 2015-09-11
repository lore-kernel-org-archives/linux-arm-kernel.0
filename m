From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 11 Sep 2015 21:08:24 +0100
Subject: [PATCH 0/6] hwrng: Add support for STMicroelectronics' RNG IP
Message-ID: <1442002110-28733-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The main aim of this set is to allow users to access ST's hardware
random number generator.  It's a simple device, which only requires
a simple driver.

We're also taking the liberty to update some out of date HWRNG
documentation and making the sysfs interface a little easier to
use by ignoring any '\n' which may have been inadvertently passed.

Lee Jones (6):
  Documentation: hw_random: Fix device node name /dev/hw_random =>
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
 drivers/char/hw_random/Kconfig                   |  10 ++
 drivers/char/hw_random/Makefile                  |   1 +
 drivers/char/hw_random/core.c                    |   7 +-
 drivers/char/hw_random/st-rng.c                  | 142 +++++++++++++++++++++++
 8 files changed, 193 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/st,rng.txt
 create mode 100644 drivers/char/hw_random/st-rng.c

-- 
1.9.1
