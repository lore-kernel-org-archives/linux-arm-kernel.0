From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 17 Feb 2014 21:05:17 +0100
Subject: [PATCH v5 0/7] ARM: S3C24XX: Convert s3c2416 and s3c2443 to common
 clock framework
Message-ID: <2678040.KALsQ0bZFm@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Next try, hopefully this time the final one :-)

Tested on both non-dt and dt s3c2416.

Changes since v4:
- adapt to samsung clock pm changes
- rename include/dt-bindings header
Changes since v3:
- address comments from Tomasz Figa (binding documentation, etc)
- prevent conflicts with unconverted s3c24xx socs
Changes since v2
- address comments from Tomasz Figa
- use new pll registration mechanism
- use fixed-rate clocks for xti etc

Heiko Stuebner (7):
  clk: samsung: add pll_6552 variant for s3c2416
  clk: samsung: add plls used by the s3c2443
  dt-bindings: add binding for clock-controller of s3c2443 and following
  clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450
  ARM: S3C24XX: prevent conflicts between ccf and non-ccf s3c24xx-socs
  ARM: dt: add clock data for s3c2416
  ARM: S3C24XX: Convert s3c2416 and s3c2443 to common clock framework

 .../bindings/clock/samsung,s3c2443-clock.txt       |  56 ++
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |  13 +
 arch/arm/boot/dts/s3c2416.dtsi                     |  42 ++
 arch/arm/mach-s3c24xx/Kconfig                      |  18 +-
 arch/arm/mach-s3c24xx/Makefile                     |   5 +-
 arch/arm/mach-s3c24xx/clock-s3c2416.c              | 171 ------
 arch/arm/mach-s3c24xx/clock-s3c2443.c              | 212 -------
 arch/arm/mach-s3c24xx/common-s3c2443.c             | 675 ---------------------
 arch/arm/mach-s3c24xx/common.c                     |  18 +-
 arch/arm/mach-s3c24xx/common.h                     |   6 +
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |  39 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |   9 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |   9 +-
 drivers/clk/samsung/Makefile                       |   1 +
 drivers/clk/samsung/clk-pll.c                      |  84 ++-
 drivers/clk/samsung/clk-pll.h                      |   3 +
 drivers/clk/samsung/clk-s3c2443.c                  | 462 ++++++++++++++
 include/dt-bindings/clock/s3c2443.h                |  92 +++
 18 files changed, 801 insertions(+), 1114 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c
 create mode 100644 include/dt-bindings/clock/s3c2443.h

-- 
1.8.5.3
