From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Sat, 10 Dec 2016 16:15:59 +0530
Subject: [PATCH v2 0/3] Add enable method support for Exynos SoCs
Message-ID: <1481366762-26413-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lets use CPU_METHOD_OF_DECLARE() for smp_ops instead of using it
via machine descriptor. To keep compatibility of older DTBs lets not 
remove smp_ops hooks from machnine_descriptor.

Changes since v1:
 - Dropped code removing smp_ops hooks from exynos.c
 - Separated patch into three patches separating change in .c, .dtsi
   and updated binding Documentation.

Pankaj Dubey (3):
  Documentation: bindings: Add binding doc for exynos enable method
  ARM: EXYNOS: dts: add enable-method property for cpus node
  ARM: EXYNOS: add CPU_METHOD_OF_DECLARE for exynos SoCs

 Documentation/devicetree/bindings/arm/cpus.txt | 1 +
 arch/arm/boot/dts/exynos3250.dtsi              | 1 +
 arch/arm/boot/dts/exynos4210.dtsi              | 1 +
 arch/arm/boot/dts/exynos4212.dtsi              | 1 +
 arch/arm/boot/dts/exynos4412.dtsi              | 1 +
 arch/arm/boot/dts/exynos5250.dtsi              | 1 +
 arch/arm/boot/dts/exynos5260.dtsi              | 1 +
 arch/arm/boot/dts/exynos5410.dtsi              | 1 +
 arch/arm/boot/dts/exynos5420-cpus.dtsi         | 1 +
 arch/arm/boot/dts/exynos5422-cpus.dtsi         | 1 +
 arch/arm/boot/dts/exynos5440.dtsi              | 1 +
 arch/arm/mach-exynos/platsmp.c                 | 2 ++
 12 files changed, 13 insertions(+)

-- 
2.7.4
