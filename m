From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 30 Jan 2018 22:18:15 +0100
Subject: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg warning for
 syscon restart nodes
Message-ID: <20180130211819.17139-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Changes since v1:
1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
   following Rob's advice.
2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
   on this.

Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  soc: samsung: pmu: Populate children syscon nodes
  ARM: dts: exynos: Remove duplicated inclusion of syscon restart nodes
    on Exynos5410
  ARM: dts: exynos: Fix missing missing reg warning for syscon restart
    nodes
  arm64: dts: exynos: Fix missing missing reg warning for syscon restart
    nodes

 .../devicetree/bindings/arm/samsung/pmu.txt        |  6 +++++
 arch/arm/boot/dts/exynos-syscon-restart.dtsi       | 28 ++++++++++------------
 arch/arm/boot/dts/exynos3250.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |  3 ++-
 arch/arm/boot/dts/exynos5.dtsi                     |  1 -
 arch/arm/boot/dts/exynos5250.dtsi                  |  1 +
 arch/arm/boot/dts/exynos5410.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5420.dtsi                  |  1 +
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 14 +++++------
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 12 +++++-----
 drivers/soc/samsung/exynos-pmu.c                   |  3 +++
 11 files changed, 40 insertions(+), 33 deletions(-)

-- 
2.11.0
