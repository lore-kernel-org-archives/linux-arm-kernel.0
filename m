From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 17 Mar 2014 19:53:10 +0530
Subject: [PATCH v2 1/3] ARM: EXYNOS: Map PMU address through DT
In-Reply-To: <1395061795-17777-2-git-send-email-vikas.sajjan@samsung.com>
References: <1395061795-17777-1-git-send-email-vikas.sajjan@samsung.com>
 <1395061795-17777-2-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <CAK9yfHyF9t0fsO86cqHvAzaWKa17=2MkFq6mhoL0-mwjw6OXQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas,

On 17 March 2014 18:39, Vikas Sajjan <vikas.sajjan@samsung.com> wrote:
> Instead of hardcoding the PMU details for each SoC, pass this information
> through device tree (DT).
>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/pmu.txt        |    5 +-
>  arch/arm/boot/dts/exynos4.dtsi                     |    5 ++
>  arch/arm/boot/dts/exynos5260.dtsi                  |    5 ++
>  arch/arm/mach-exynos/common.c                      |   51 +++++++++++++-------
>  arch/arm/mach-exynos/include/mach/map.h            |    3 --
>  5 files changed, 47 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/arm/samsung/pmu.txt b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> index f1f1552..667a7f0 100644
> --- a/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> +++ b/Documentation/devicetree/bindings/arm/samsung/pmu.txt
> @@ -2,14 +2,15 @@ SAMSUNG Exynos SoC series PMU Registers
>
>  Properties:
>   - compatible : should contain two values. First value must be one from following list:
> +                  - "samsung,exynos4210-pmu" - for Exynos4210 and Exynos4x12 SoC,
>                    - "samsung,exynos5250-pmu" - for Exynos5250 SoC,
> -                  - "samsung,exynos5420-pmu" - for Exynos5420 SoC.
> +                  - "samsung,exynos5420-pmu" - for Exynos5420 and Exynos5260 SoC.
>                 second value must be always "syscon".
>
>   - reg : offset and length of the register set.
>
>  Example :
>  pmu_system_controller: system-controller at 10040000 {
> -       compatible = "samsung,exynos5250-pmu", "syscon";
> +       compatible = "samsung,exynos5250-pmu";

If you have removed "syscon" deliberately above, then you should also
remove the same in the
binding description which says "second value must be always "syscon".".

-- 
With warm regards,
Sachin
