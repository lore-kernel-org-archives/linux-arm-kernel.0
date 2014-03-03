From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Mar 2014 09:57:25 +0000 (GMT)
Subject: [GIT PULL 6/6] Samsung clk-s3c24xx updates for v3.15
Message-ID: <31063545.260671393840643330.JavaMail.weblogic@epml16>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e11d919e4aa2009077e3e4f829ff991d37adca61:

  ARM: EXYNOS: Drop legacy Exynos4 clock suspend/resume code (2014-02-14 08:16:01 +0900)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/s3c24xx-clk

for you to fetch changes up to 315c62c750e82cb20845cbef585141cbf98aa1a0:

  ARM: S3C24XX: convert s3c2412 to common clock framework (2014-03-03 09:18:49 +0900)

----------------------------------------------------------------
Samsung S3C24XX to use the common clock framework
- S3C2412, S3C2413, S3C2416 and S3C2443 to use CCF

Heiko Stuebner (12):
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

Note:
- This branch is based on v3.15-next/s2r-pm-samsung
- clock related stuff got ack from Mike and Tomasz

----------------------------------------------------------------
Heiko Stuebner (12):
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

 .../bindings/clock/samsung,s3c2412-clock.txt       |   50 ++
 .../bindings/clock/samsung,s3c2443-clock.txt       |   56 ++
 arch/arm/boot/dts/s3c2416-smdk2416.dts             |   13 +
 arch/arm/boot/dts/s3c2416.dtsi                     |   42 ++
 arch/arm/mach-s3c24xx/Kconfig                      |   24 +-
 arch/arm/mach-s3c24xx/Makefile                     |    7 +-
 arch/arm/mach-s3c24xx/clock-s3c2412.c              |  761 --------------------
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |  171 -----
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |  212 ------
 arch/arm/mach-s3c24xx/common-s3c2443.c             |  675 -----------------
 arch/arm/mach-s3c24xx/common.c                     |   27 +-
 arch/arm/mach-s3c24xx/common.h                     |   10 +
 arch/arm/mach-s3c24xx/mach-jive.c                  |    9 +-
 arch/arm/mach-s3c24xx/mach-s3c2416-dt.c            |   39 +-
 arch/arm/mach-s3c24xx/mach-smdk2413.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2416.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-smdk2443.c              |    9 +-
 arch/arm/mach-s3c24xx/mach-vstms.c                 |    9 +-
 arch/arm/mach-s3c24xx/pm.c                         |   13 +-
 arch/arm/mach-s3c24xx/s3c2412.c                    |   43 --
 drivers/clk/samsung/Makefile                       |    2 +
 drivers/clk/samsung/clk-pll.c                      |  266 ++++++-
 drivers/clk/samsung/clk-pll.h                      |    6 +
 drivers/clk/samsung/clk-s3c2412.c                  |  269 +++++++
 drivers/clk/samsung/clk-s3c2443.c                  |  462 ++++++++++++
 include/dt-bindings/clock/s3c2412.h                |   73 ++
 include/dt-bindings/clock/s3c2443.h                |   92 +++
 27 files changed, 1428 insertions(+), 1930 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2412-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s3c2443-clock.txt
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2412.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2416.c
 delete mode 100644 arch/arm/mach-s3c24xx/clock-s3c2443.c
 delete mode 100644 arch/arm/mach-s3c24xx/common-s3c2443.c
 create mode 100644 drivers/clk/samsung/clk-s3c2412.c
 create mode 100644 drivers/clk/samsung/clk-s3c2443.c
 create mode 100644 include/dt-bindings/clock/s3c2412.h
 create mode 100644 include/dt-bindings/clock/s3c2443.h
