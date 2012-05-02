From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue,  1 May 2012 22:07:39 -0700
Subject: [PATCH 0/7] mmc: dw_mmc: add support for device tree based
 instantiation
Message-ID: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds device tree support for Synopsis Designware Mobile
Storage Host Controller.

The first patch adds clock lookup in the driver and this is optional. Platforms
that do not need any clock gating and control for the dw_mmc controllers will
not be affected with this change. The second patch adds a quirk to notify the
controller about the absence of the write protect line.

The third patch adds device tree support and fourth patch adds Samsung
Exynos5250 specific controlller extentions to the driver. The rest of the
patches in the series enable support for dw_mmc support on the Samsing
Exynos5250 based platforms.

This patchset has been derived from Samsung internal patches prepared by
Abhilash Kesavan <a.kesavan@samsung.com>.

Thomas Abraham (7):
  mmc: dw_mmc: lookup for optional biu and ciu clocks
  mmc: dw_mmc: add quirk to indicate missing write protect line
  mmc: dw_mmc: add device tree support
  mmc: dw_mmc: add samsung exynos5250 specific extentions
  ARM: Samsung: Add support for MSHC controller clocks
  ARM: Exynos5: Add AUXDATA support for MSHC controllers
  ARM: dts: Add nodes for dw_mmc controllers for Samsung Exynos5250 platforms

 .../devicetree/bindings/mmc/synposis-dw-mshc.txt   |  116 +++++++++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   50 ++++-
 arch/arm/boot/dts/exynos5250.dtsi                  |   24 ++
 arch/arm/mach-exynos/clock-exynos5.c               |   45 ++---
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    8 +
 drivers/mmc/host/dw_mmc-pltfm.c                    |   32 +++
 drivers/mmc/host/dw_mmc.c                          |  252 +++++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                          |   23 ++
 include/linux/mmc/dw_mmc.h                         |   15 +-
 9 files changed, 521 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/synposis-dw-mshc.txt

-- 
1.7.5.4
