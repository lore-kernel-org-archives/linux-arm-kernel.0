From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 19:25:19 +0200
Subject: [PATCH v2 0/8] watchdog: s3c2410: Fixes and improvements
Message-ID: <20170311172527.16368-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Minor cleanup and some fixes for the watchdog used on all
Samsung SoCs.

The DTS patches should through samsung-soc tree but they depend
on introducing new compatible. The patches waiting for new compatible will be
deferred to next release.


Changes since v1:
=================
1. Add Guenter's review and Rob's ack.
2. Change compatible in patch 6/8 instead 3/8.


Best regards,
Krzysztof


Krzysztof Kozlowski (8):
  watchdog: s3c2410: Remove confusing CONFIG prefix from local defines
  watchdog: s3c2410: Fix infinite interrupt in soft mode
  ARM: dts: exynos: Fix watchdog reset on Exynos4412
  ARM: dts: s3c64xx: Enable watchdog on all S3C64xx boards
  ARM: dts: exynos: Enable watchdog on all Exynos4 boards
  ARM: dts: exynos: Fix infinite interrupt in soft mode on Exynos4210
    and Exynos5440
  ARM: dts: s3c64xx: Fix infinite interrupt in soft mode
  ARM: dts: s5pv210: Fix infinite interrupt in soft mode

 .../devicetree/bindings/watchdog/samsung-wdt.txt   |  9 +++---
 arch/arm/boot/dts/exynos4.dtsi                     |  9 ------
 arch/arm/boot/dts/exynos4210-origen.dts            |  4 ---
 arch/arm/boot/dts/exynos4210.dtsi                  |  8 +++++
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    |  4 ---
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  4 ---
 arch/arm/boot/dts/exynos4412-origen.dts            |  4 ---
 arch/arm/boot/dts/exynos4412.dtsi                  |  9 ++++++
 arch/arm/boot/dts/exynos5440.dtsi                  |  2 +-
 arch/arm/boot/dts/s3c64xx.dtsi                     |  3 +-
 arch/arm/boot/dts/s5pv210.dtsi                     |  2 +-
 drivers/watchdog/s3c2410_wdt.c                     | 37 +++++++++++++++-------
 12 files changed, 51 insertions(+), 44 deletions(-)

-- 
2.9.3
