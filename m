From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Fri, 25 Apr 2014 20:54:12 +0900
Subject: [PATCH v2 0/5] Add PMU node for Exynos SoCs
In-Reply-To: <1396425778-4379-1-git-send-email-pankaj.dubey@samsung.com>
References: <1396425778-4379-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1398426857-5097-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds new property in samsung PMU binding as
"samsung,syscon-phandle" to get PMU regmap handle in PMU driver
implementation and "mach-exynos/exynos.c".
This patch also updates Exynos4210, Exynos4412 and Exynos4212 dtsi files
for adding PMU (Power Management Unit) reg node.
Updated binding document for the same.

These patches are required for converting PMU implementation free from
static mapping of PMU registers as well as it's dependency from machine
header files, thus allowing us to converting it into DT based.

Changes since v1:
 - Added new property "samsung,syscon-phandle" to get access to PMU regmap handle.
 - Updated Exynos5250, Exynos5420, Exynos4210/4412/4212 dtsi files.
 - Rebased on Kukjin Kim's for-next branch.

Pankaj Dubey (5):
  ARM: dts: Add syscon handle in pmu node for exynos5250
  ARM: dts: Add PMU node to exynos4210
  ARM: dts: Add PMU node to exynos4212 and exynos4412
  arm: dts: Add syscon handle in pmu node for exynos5420
  Documentation: update samsung pmu binding information

 Documentation/devicetree/bindings/arm/samsung/pmu.txt |    7 +++++++
 arch/arm/boot/dts/exynos4210.dtsi                     |    6 ++++++
 arch/arm/boot/dts/exynos4212.dtsi                     |    6 ++++++
 arch/arm/boot/dts/exynos4412.dtsi                     |    6 ++++++
 arch/arm/boot/dts/exynos5250.dtsi                     |    1 +
 arch/arm/boot/dts/exynos5420.dtsi                     |    1 +
 6 files changed, 27 insertions(+)

-- 
1.7.10.4
