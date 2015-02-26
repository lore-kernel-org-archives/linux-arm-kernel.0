From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Thu, 26 Feb 2015 20:35:18 +0900
Subject: [PATCH 0/3] thermal: exynos: Add support for Exynos5433 TMU
Message-ID: <1424950521-6236-1-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the support for Exynos5433 TMU (Thermal Management Unit).
Exynos5433 TMU includes five sensors as following and each sensor support the
eight rising/falling interrupt according to threshold value. Exynos5433 TMU has
a little difference register map from Exynos4/Exynos7.
- two temperature sensor for Cortex-A57 (ATLAS)
- one temperature sensor for Cortex-A53 (APOLLO)
- one temperature sensor for G3D IP
- one temperature sensor for ISP IP

Depends on:
[1] [PATCH v4 0/8] arm64: Add the support for new Exynos5433 SoC
    - https://lkml.org/lkml/2015/2/24/2
[2] [PATCH v2 0/2] thermal: exynos: Fix NULL pointer error and bug of PD_DET_EN of Exynos7
    - https://lkml.org/lkml/2015/2/23/778

Chanwoo Choi (3):
  thermal: exynos: Add the support for Exynos5433 TMU
  arm64: dts: exynos: Add TMU sensor dt node for Exynos5433 SoC
  arm64: dts: exynos: Add thermal-zones dt node for Exynos5433 SoC

 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  22 ++
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 231 +++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  56 +++++
 drivers/thermal/samsung/exynos_tmu.c               | 161 +++++++++++++-
 drivers/thermal/samsung/exynos_tmu.h               |   1 +
 5 files changed, 466 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi

-- 
1.8.5.5
