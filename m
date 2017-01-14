From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 14 Jan 2017 14:36:38 +0200
Subject: [PATCH 0/4] Drop drivers for Exynos4415
Message-ID: <20170114123642.15581-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Support for Exynos4415 is being removed because:
1. There are no upstream users,
2. There are no known downstream users,
3. Except compile testing, you cannot build working kernel
   for Exynos4415 anymore.

Patches are rebased on current next and are independent.
Please pick up as you wish.

Best regards,
Krzysztof

Krzysztof Kozlowski (4):
  ARM: EXYNOS: Remove Exynos4415 driver (SoC not supported anymore)
  clk: samsung: Remove Exynos4415 driver (SoC not supported anymore)
  pinctrl: samsung: Remove support for Exynos4415 (SoC not supported
    anymore)
  drm: exynos: Remove support for Exynos4415 (SoC not supported anymore)

 .../devicetree/bindings/clock/exynos4415-clock.txt |   38 -
 .../bindings/display/exynos/exynos_dsim.txt        |    1 -
 .../bindings/display/exynos/samsung-fimd.txt       |    1 -
 arch/arm/mach-exynos/Kconfig                       |    5 -
 arch/arm/mach-exynos/exynos.c                      |    1 -
 arch/arm/mach-exynos/suspend.c                     |    1 -
 drivers/clk/samsung/Makefile                       |    1 -
 drivers/clk/samsung/clk-exynos4415.c               | 1022 --------------------
 drivers/gpu/drm/exynos/exynos_drm_dsi.c            |   15 +-
 drivers/gpu/drm/exynos/exynos_drm_fimd.c           |   18 +-
 drivers/pinctrl/samsung/pinctrl-exynos.c           |   75 --
 drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 -
 drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 -
 include/dt-bindings/clock/exynos4415.h             |  360 -------
 14 files changed, 3 insertions(+), 1538 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/exynos4415-clock.txt
 delete mode 100644 drivers/clk/samsung/clk-exynos4415.c
 delete mode 100644 include/dt-bindings/clock/exynos4415.h

-- 
2.9.3
