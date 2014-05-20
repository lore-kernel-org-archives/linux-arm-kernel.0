From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 20 May 2014 10:10:07 +0900
Subject: [GIT PULL 1/5] Samsung S3C24XX updates for 3.16
Message-ID: <014401cf73c8$3d485e00$b7d91a00$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/s3c24xx-clk

for you to fetch changes up to 34c453ce16633539a94a2e876faeb731ac1be899:

  ARM: S3C24XX: fix merge conflict (2014-05-15 05:54:38 +0900)

----------------------------------------------------------------
Samsung S3C24XX to use the common clock framework
- S3C2412, S3C2413, S3C2416 and S3C2443 to use CCF
- S3C2410, S3C2440, S3C2442 to use CCF
- Remove legacy samsung clock from mach-s3c24xx/

- Some of them are missed from previous pull-request
- Clock related sutff got ack from Mike and Tomasz
- Created the last commit due to missing changes
  during re-sorting because this branch is provided
  as a base to samsung clk tree.

----------------------------------------------------------------
Heiko Stuebner (22):
      clk: samsung: add pll_6552 variant for s3c2416
      clk: samsung: add plls used by the s3c2443
      dt-bindings: add binding for clock-controller of s3c2443 and following
      clk: samsung: add clock-driver for s3c2416, s3c2443 and s3c2450
      ARM: S3C24XX: prevent conflicts between ccf and non-ccf s3c24xx-socs
      ARM: dts: add clock data for s3c2416
      ARM: S3C24XX: Convert s3c2416 and s3c2443 to common clock framework
      ARM: S3C24XX: only store clock registers when old clock code is active
      clk: samsung: add plls used by the early s3c24xx cpus
      dt-bindings: add documentation for s3c2412 clock controller
      clk: samsung: add clock controller driver for s3c2412
      ARM: S3C24XX: convert s3c2412 to common clock framework
      ARM: S3C24XX: cpufreq-utils: don't write raw values to MPLLCON when
using ccf
      clk: samsung: add clock driver for external clock outputs
      ARM: S3C24XX: enable usage of common dclk if common clock framework is
enabled
      dt-bindings: add documentation for s3c2410 clock controller
      clk: samsung: add clock controller driver for s3c2410, s3c2440 and
s3c2442
      ARM: S3C24XX: add platform code for conversion to the common clock
framework
      ARM: S3C24XX: convert s3c2440 and s3c2442 to common clock framework
      ARM: S3C24XX: convert s3c2410 to common clock framework
      ARM: S3C24XX: remove legacy clock code
      ARM: S3C24XX: remove SAMSUNG_CLOCK remnants after ccf conversion

Kukjin Kim (1):
      ARM: S3C24XX: fix merge conflict

 .../bindings/clock/samsung,s3c2410-clock.txt       |   50 ++
 .../bindings/clock/samsung,s3c2412-clock.txt       |   50 ++
 .../bindings/clock/samsung,s3c2443-clock.txt       |   56 ++
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   13 +
 arch/arm/boot/dts/s3c2416.dtsi                     |   42 ++
 arch/arm/mach-s3c24xx/Kconfig                      |   63 +-
 arch/arm/mach-s3c24xx/Makefile                     |   13 +-
 arch/arm/mach-s3c24xx/clock-dclk.c                 |  195 -----
 arch/arm/mach-s3c24xx/clock-s3c2410.c              |  284 --------
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |  760
--------------------
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |  171 -----
 arch/arm/mach-s3c24xx/clock-s3c2440.c              |  217 ------
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |  212 ------
 arch/arm/mach-s3c24xx/clock-s3c244x.c              |  141 ----
 arch/arm/mach-s3c24xx/common-s3c2443.c             |  675 -----------------
 arch/arm/mach-s3c24xx/common.c                     |   85 ++-
 arch/arm/mach-s3c24xx/common.h                     |   21 +-
 arch/arm/mach-s3c24xx/cpufreq-utils.c              |    4 +-
 arch/arm/mach-s3c24xx/include/mach/regs-clock.h    |   18 -
 arch/arm/mach-s3c24xx/include/mach/regs-gpio.h     |    3 -
 arch/arm/mach-s3c24xx/mach-amlm5900.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-anubis.c                |   34 +-
 arch/arm/mach-s3c24xx/mach-at2440evb.c             |   10 +-
 arch/arm/mach-s3c24xx/mach-bast.c                  |   34 +-
 arch/arm/mach-s3c24xx/mach-gta02.c                 |    8 +-
 arch/arm/mach-s3c24xx/mach-h1940.c                 |   10 +-
 arch/arm/mach-s3c24xx/mach-jive.c                  |    9 +-
 arch/arm/mach-s3c24xx/mach-mini2440.c              |   10 +-
 arch/arm/mach-s3c24xx/mach-n30.c                   |   12 +-
 arch/arm/mach-s3c24xx/mach-nexcoder.c              |   10 +-
 arch/arm/mach-s3c24xx/mach-osiris.c                |   34 +-
 arch/arm/mach-s3c24xx/mach-otom.c                  |   10 +-
 arch/arm/mach-s3c24xx/mach-qt2410.c                |    9 +-
 arch/arm/mach-s3c24xx/mach-rx1950.c                |   21 +-
 arch/arm/mach-s3c24xx/mach-rx3715.c                |   10 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   38 +-
 arch/arm/mach-s3c24xx/mach-smdk2410.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2440.c              |   10 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-tct_hammer.c            |    9 +-
 arch/arm/mach-s3c24xx/mach-vr1000.c                |   34 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    9 +-
 arch/arm/mach-s3c24xx/pm.c                         |   17 -
 arch/arm/mach-s3c24xx/s3c2410.c                    |   56 --
 arch/arm/mach-s3c24xx/s3c2412.c                    |   43 --
 arch/arm/mach-s3c24xx/s3c2442.c                    |  111 ---
 arch/arm/mach-s3c24xx/s3c244x.c                    |   59 +-
 arch/arm/plat-samsung/include/plat/cpu-freq-core.h |    1 +
 drivers/clk/samsung/Makefile                       |    4 +
 drivers/clk/samsung/clk-pll.c                      |  266 ++++++-
 drivers/clk/samsung/clk-pll.h                      |    6 +
 drivers/clk/samsung/clk-s3c2410-dclk.c             |  440 ++++++++++++
 drivers/clk/samsung/clk-s3c2410.c                  |  477 ++++++++++++
 drivers/clk/samsung/clk-s3c2412.c                  |  269 +++++++
 drivers/clk/samsung/clk-s3c2443.c                  |  462 ++++++++++++
 drivers/cpufreq/s3c24xx-cpufreq.c                  |    1 +
 include/dt-bindings/clock/s3c2410.h                |   62 ++
 include/dt-bindings/clock/s3c2412.h                |   73 ++
 include/dt-bindings/clock/s3c2443.h                |   92 +++
 61 files changed, 2655 insertions(+), 3223 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/clock/samsung,s3c2410-clock.txt
 create mode 100644
Documentation/devicetree/bindings/clock/samsung,s3c2412-clock.txt
 create mode 100644
Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
 delete mode 100644 arch/arm/mach-s3c24xx/clock-dclk.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2410.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2440.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c244x.c
 delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
 create mode 100644 drivers/clk/samsung/clk-s3c2410-dclk.c
 create mode 100644 drivers/clk/samsung/clk-s3c2410.c
 create mode 100644 drivers/clk/samsung/clk-s3c2412.c
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c
 create mode 100644 include/dt-bindings/clock/s3c2410.h
 create mode 100644 include/dt-bindings/clock/s3c2412.h
 create mode 100644 include/dt-bindings/clock/s3c2443.h
