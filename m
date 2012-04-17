From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Tue, 17 Apr 2012 11:16:23 +0530
Subject: [PATCH 00/12] Updates for Exynos5250 Rev1.0 and device tree support
Message-ID: <1334641595-25301-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series includes modifications to support Rev1.0 of Exynos5250 SoC
and overrides the existing support for Rev0. It also includes basic device
tree support (tested for UART, WDT, RTC, GPIO, I2C, GIC and DMA PL330).

Changhwan Youn (2):
  ARM: Exynos5: Modify the GIC physical address for static io-mapping
  ARM: Exynos: Redefine IRQ_MCT_L0,1 definition

Heiko Stuebner (1):
  rtc-s3c: Fix breakage introduced by S3C2443/S3C2416 support

Kisoo Yu (1):
  ARM: Exynos5: Add pre-divider and fout mux clocks for bpll and mpll

Sangsu Park (1):
  gpio/samsung: add GPC4 bank instance

Thomas Abraham (7):
  ARM: Exynos: Remove a new bus_type instance for Exynos5
  ARM: Exynos5: Fix incorrect initialization of GIC
  ARM: Exynos5: Add watchdog timer clock instance
  ARM: Exynos5: Remove duplicated instantiation of pdma clock
  ARM: Exynos5: Add MDMA0 clock instance
  ARM: Exynos5: Update device tree source files
  ARM: Exynos5: Update device tree enabled machine file

 arch/arm/boot/dts/exynos5250-smdk5250.dts      |   52 +++++++++++++
 arch/arm/boot/dts/exynos5250.dtsi              |   44 +++--------
 arch/arm/mach-exynos/clock-exynos5.c           |   98 +++++++++++++++++++++---
 arch/arm/mach-exynos/common.c                  |   27 ++-----
 arch/arm/mach-exynos/include/mach/gpio.h       |    9 ++-
 arch/arm/mach-exynos/include/mach/irqs.h       |    4 +-
 arch/arm/mach-exynos/include/mach/map.h        |    4 +-
 arch/arm/mach-exynos/include/mach/regs-clock.h |    2 +
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    7 ++-
 arch/arm/mach-exynos/mct.c                     |   17 +++--
 arch/arm/plat-s5p/clock.c                      |   11 ---
 drivers/gpio/gpio-samsung.c                    |    8 ++
 drivers/rtc/rtc-s3c.c                          |   18 ++--
 13 files changed, 204 insertions(+), 97 deletions(-)
