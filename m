From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 08 Feb 2018 14:46:32 +0100
Subject: [PATCH v2 0/4] ARM/arm64: exynos: Fix missing missing reg
 warning for syscon restart nodes
In-Reply-To: <20180130211819.17139-1-krzk@kernel.org>
References: <CGME20180130211855epcas1p25cce42a195d8b407f4267309f9b5ccb9@epcas1p2.samsung.com>
 <20180130211819.17139-1-krzk@kernel.org>
Message-ID: <4642d2d0-61c9-33b6-0289-76f487aa45ab@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,

On 2018-01-30 22:18, Krzysztof Kozlowski wrote:
> Hi,
>
> Changes since v1:
> 1. New patch (1/4) calling devm_of_platform_populate() in PMU driver,
>     following Rob's advice.
> 2. The DTS patches moving reboot/poweroff nodes (3/4 and 4/4) now depend
>     on this.

Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Tested following boards and reboot works fine:
Exynos3250 (artik5-eval)
Exynos4412 (trats2)
Exynos5410 (odroid xu)
Exynos5422 (odroid xu3/xu4)
Exynos5433 (tm2)

> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (4):
>    soc: samsung: pmu: Populate children syscon nodes
>    ARM: dts: exynos: Remove duplicated inclusion of syscon restart nodes
>      on Exynos5410
>    ARM: dts: exynos: Fix missing missing reg warning for syscon restart
>      nodes
>    arm64: dts: exynos: Fix missing missing reg warning for syscon restart
>      nodes
>
>   .../devicetree/bindings/arm/samsung/pmu.txt        |  6 +++++
>   arch/arm/boot/dts/exynos-syscon-restart.dtsi       | 28 ++++++++++------------
>   arch/arm/boot/dts/exynos3250.dtsi                  |  2 +-
>   arch/arm/boot/dts/exynos4.dtsi                     |  3 ++-
>   arch/arm/boot/dts/exynos5.dtsi                     |  1 -
>   arch/arm/boot/dts/exynos5250.dtsi                  |  1 +
>   arch/arm/boot/dts/exynos5410.dtsi                  |  2 +-
>   arch/arm/boot/dts/exynos5420.dtsi                  |  1 +
>   arch/arm64/boot/dts/exynos/exynos5433.dtsi         | 14 +++++------
>   arch/arm64/boot/dts/exynos/exynos7.dtsi            | 12 +++++-----
>   drivers/soc/samsung/exynos-pmu.c                   |  3 +++
>   11 files changed, 40 insertions(+), 33 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
