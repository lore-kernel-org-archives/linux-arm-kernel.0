From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 30 Dec 2016 13:14:17 +0900
Subject: [PATCH v2 0/4] Use Exynos macros for pinctrl settings
References: <CGME20161230041426epcas1p1a8564e969a8f6a1746a3af9b26aac99f@epcas1p1.samsung.com>
Message-ID: <20161230041421.24448-1-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

This patchset fixes the width and offsets of the PINCFG_TYPE_DRV
bitfields for the Exynos5433 SoC.

Moreover it refactors the pinctrl definitions by using the
dt-bindings/pinctrl/samsung.h definitions introduced by Krzysztof
in 5db7e3bb87df ("pinctrl: dt-bindings: samsung: Add header with
values used for configuration").

It would be nice to see in the future all the PIN related macros
in the same file, as they more or less do the same thing.

Changelog v1 -> v2
==================
V1: https://lkml.org/lkml/2016/12/29/40

- Added Chanwoo's patch for fixing the slew rate register width.
- Patch 4 is squashed with the patch3 and 4 of v1.

Thanks,
Andi

Andi Shyti (3):
  pinctrl: dt-bindings: samsung: add drive strength macros for
    Exynos5433
  ARM64: dts: exynos5433: use macros for pinctrl configuration on
    Exynos5433
  ARM64: dts: TM2: comply to the samsung pinctrl naming convention

Chanwoo Choi (1):
  pinctrl: samsung: Fix the width of PINCFG_TYPE_DRV bitfields for
    Exynos5433

 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi | 373 ++++++++++-----------
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 254 +++++++-------
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  91 ++---
 drivers/pinctrl/samsung/pinctrl-exynos.h           |  31 ++
 include/dt-bindings/pinctrl/samsung.h              |  14 +
 5 files changed, 404 insertions(+), 359 deletions(-)

-- 
2.11.0
