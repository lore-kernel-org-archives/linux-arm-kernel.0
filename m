From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 29 Aug 2012 16:55:09 +0530
Subject: [PATCH v3 4/4] ARM: EXYNOS: Add arm-pmu DT binding for exynos5250
In-Reply-To: <1346202897-27306-5-git-send-email-chanho61.park@samsung.com>
References: <1346202897-27306-1-git-send-email-chanho61.park@samsung.com>
 <1346202897-27306-5-git-send-email-chanho61.park@samsung.com>
Message-ID: <CAJuYYwTs=9Wx6+v46Dt+peEe3w3ytJqxXgkxBwKLq7zF5ynjnw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 August 2012 06:44, Chanho Park <chanho61.park@samsung.com> wrote:
> This patch enables arm-pmu to bind device tree for exynos5250. The exynos5250
> has two pmus which have combiner irq type.
>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 004aaa8..45746cbf 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -52,6 +52,12 @@
>                              <0 28 0>, <0 29 0>, <0 30 0>, <0 31 0>;
>         };
>
> +       pmu {
> +               compatible = "arm,cortex-a15-pmu";
> +               interrupt-parent = <&combiner>;
> +               interrupts = <1 2>, <22 4>;
> +       };
> +
>         watchdog {
>                 compatible = "samsung,s3c2410-wdt";
>                 reg = <0x101D0000 0x100>;
> --
> 1.7.9.5
>

Reviewed-by: Thomas Abraham <thomas.abraham@linaro.org>

Probably, this should be doable for Exynos4 as well.
