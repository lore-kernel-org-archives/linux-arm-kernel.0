From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 06 Jan 2014 19:35:04 +0100
Subject: [PATCH 0/5] ARM: S3C24XX: unify restart functions
Message-ID: <3105326.uFdOVLyXH8@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This unifies the restart functions of s3c24xx socs into one single
function and also removes the need for the SWRST register to be
statically mapped in the dt case.

As a result the mach-s3c2416-dt boardfile can also support
other s3c24xx boards in the future.

Because of the clock-reparenting in the s3c2412-swrst it depends
on the conversion of s3c2412 to the common clock framework.

Heiko Stuebner (5):
  dt-bindings: document the s3c24xx software-reset register
  ARM: S3C24XX: add generic handler for swrst resets
  ARM: S3C24XX: add common reset function
  ARM: S3C24XX: convert boards to use common restart function
  ARM: S3C24XX: remove obsolete SoC-specific restart functions

 .../bindings/arm/samsung/s3c24xx-swrst.txt         |   16 ++
 arch/arm/boot/dts/s3c2416.dtsi                     |    5 +
 arch/arm/mach-s3c24xx/Kconfig                      |    8 +
 arch/arm/mach-s3c24xx/Makefile                     |    1 +
 arch/arm/mach-s3c24xx/common.c                     |   31 ++++
 arch/arm/mach-s3c24xx/common.h                     |   23 ++-
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |    2 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |    2 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    2 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |    2 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |    2 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |    4 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |    2 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   11 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    6 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    2 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    2 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |    2 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    2 +-
 arch/arm/mach-s3c24xx/s3c2410.c                    |   12 --
 arch/arm/mach-s3c24xx/s3c2412.c                    |   20 ---
 arch/arm/mach-s3c24xx/s3c2416.c                    |    8 -
 arch/arm/mach-s3c24xx/s3c2443.c                    |    8 -
 arch/arm/mach-s3c24xx/s3c244x.c                    |   11 --
 arch/arm/mach-s3c24xx/swrst-reset.c                |  160 ++++++++++++++++++++
 36 files changed, 275 insertions(+), 91 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/s3c24xx-swrst.txt
 create mode 100644 arch/arm/mach-s3c24xx/swrst-reset.c

-- 
1.7.10.4
