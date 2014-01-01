From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 01 Jan 2014 14:41:54 +0100
Subject: [PATCH 0/3] ARM: S3C24XX: convert s3c2412 to common clock framework
Message-ID: <1418190.fUL06mDNi6@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series concludes the move of s3c24xx to the common clock framework
by converting the only remaining cpu-type s3c2412/s3c2413.

The plls are the same as on the s3c2440/s3c2442 so no new types need to
be introduced.

As before the conversion is done by a mix of datasheet data and the
pre-existing clock code and as this time I have no hardware of this type,
it is compile-tested only. So hopefully somebody with s3c2412 hw
will be able to test it for real.

The only thing left now is to grab a broom and remove the now unused
remnants of the legacy clock from s3c24xx.

Heiko Stuebner (3):
  dt-bindings: add documentation for s3c2412 clock controller
  clk: samsung: add clock controller driver for s3c2412
  ARM: S3C24XX: convert s3c2412 to common clock framework

 .../bindings/clock/samsung,s3c2412-clock.txt       |   51 ++
 arch/arm/mach-s3c24xx/Kconfig                      |    8 +-
 arch/arm/mach-s3c24xx/Makefile                     |    2 +-
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |  761 --------------------
 arch/arm/mach-s3c24xx/common.c                     |    9 +-
 arch/arm/mach-s3c24xx/common.h                     |    4 +
 arch/arm/mach-s3c24xx/mach-jive.c                  |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    9 +-
 arch/arm/mach-s3c24xx/s3c2412.c                    |   43 --
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-s3c2412.c                  |  221 ++++++
 include/dt-bindings/clock/samsung,s3c2412-clock.h  |   73 ++
 13 files changed, 386 insertions(+), 814 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2412-clock.txt
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2412.c
 create mode 100644 drivers/clk/samsung/clk-s3c2412.c
 create mode 100644 include/dt-bindings/clock/samsung,s3c2412-clock.h

-- 
1.7.10.4
