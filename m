From: kgene@kernel.org (Kukjin Kim)
Date: Tue, 03 Mar 2015 04:00:14 +0900
Subject: [GIT PULL 2/2] Samsung fixes-2 for v4.0
Message-ID: <54F4B33E.3070803@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please pull Samsung tmu and hdmi regression fixes for v4.0 and I know
this is quite big for fixes but I couldn't handle this series for
previous merge window because of dependency with driver side...sorry for
that and please pull so that we could support them in v4.0 on exynos
platforms.

Thanks,
Kukjin

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes-dt

for you to fetch changes up to 2d2c9a8d0a4f90e298315d2f4a282d8bd5d45e5c:

  ARM: dts: add display power domain for exynos5250 (2015-02-27 05:29:32
+0900)

----------------------------------------------------------------
Samsung tmu and hdmi regression fixes for v4.0

- The thermal management unit and HDMI (drm mixer driver) related
reworks have been merged in v4.0 merge window. So if this DT changes
are missed for v4.0, we regressions in v4.0 release for exynos
platforms such as exynos5250, exynos5420, exynos4 SoCs.

- Note since there was a dependency with driver side, this cannot
be sent to upstream during preivous merge window and now it has been
resolved.

----------------------------------------------------------------
Andrzej Hajda (1):
      ARM: dts: add display power domain for exynos5250

Lukasz Majewski (9):
      ARM: dts: Enable TMU for exynos4210-trats
      ARM: dts: Add LDO10 for TMU for exynos4412-odroid-common
      ARM: dts: Enable TMU for exynos4412-odriod-common
      ARM: dts: Adding CPU cooling binding for Exynos SoCs
      ARM: dts: add TMU default definitions for exynos4412
      ARM: dts: default trip points definition for exynos5420
      ARM: dts: define default thermal-zones for exynos4
      ARM: dts: Trip points and sensor configuration data for exynos5440
      ARM: dts: Provide dt bindings identical for Exynos TMU

Marek Szyprowski (6):
      dt-bindings: document a note about power domain subdomains
      ARM: EXYNOS: add support for sub-power domains
      ARM: dts: add hdmi related nodes for exynos4 SoCs
      ARM: dts: add dependency between TV and LCD0 power domains for exynos4
      ARM: dts: enable hdmi support for exynos4412-odroid-common
      ARM: dts: add 'hdmi' clock to mixer nodes for exynos5250 and
exynos5420

Tomasz Stanislawski (1):
      ARM: dts: enable hdmi support for exynos4210-universal_c210

 .../bindings/arm/exynos/power_domain.txt           |  2 +
 .../devicetree/bindings/power/power_domain.txt     | 29 ++++++++++
 arch/arm/boot/dts/exynos3250.dtsi                  |  2 +
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         | 52 ++++++++++++++++++
 arch/arm/boot/dts/exynos4.dtsi                     | 45 +++++++++++++++
 arch/arm/boot/dts/exynos4210-trats.dts             | 19 +++++++
 arch/arm/boot/dts/exynos4210-universal_c210.dts    | 57 +++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi                  | 38 ++++++++++++-
 arch/arm/boot/dts/exynos4212.dtsi                  |  5 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 64
++++++++++++++++++++++
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  | 24 ++++++++
 arch/arm/boot/dts/exynos4412-trats2.dts            | 15 +++++
 arch/arm/boot/dts/exynos4412.dtsi                  |  5 +-
 arch/arm/boot/dts/exynos4x12.dtsi                  | 12 ++++
 arch/arm/boot/dts/exynos5250.dtsi                  | 44 +++++++++++++--
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      | 35 ++++++++++++
 arch/arm/boot/dts/exynos5420.dtsi                  | 33 ++++++++++-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  | 24 ++++++++
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      | 25 +++++++++
 arch/arm/boot/dts/exynos5440.dtsi                  | 18 ++++++
 arch/arm/mach-exynos/pm_domains.c                  | 28 ++++++++++
 21 files changed, 565 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5420-trip-points.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5440-trip-points.dtsi
