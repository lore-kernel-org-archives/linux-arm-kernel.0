From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Wed, 9 Jan 2013 09:25:28 -0800
Subject: [PATCH 1/3] ARM: dts: exynos5: Add power domain clocks to pd node
 of Gscaler and MFC
In-Reply-To: <1357736081-19390-2-git-send-email-prasanna.ps@samsung.com>
References: <1357736081-19390-1-git-send-email-prasanna.ps@samsung.com>
 <1357736081-19390-2-git-send-email-prasanna.ps@samsung.com>
Message-ID: <CAJuYYwTv-YCQnOXA8sFOipvnd4+jE_WqmdsAphteofumSdYF4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 January 2013 04:54, Prasanna Kumar <prasanna.ps@samsung.com> wrote:
> Power domain clks are added to Gscaler and MFC pd nodes.
> These clocks are saved during power off.
>
> Signed-off-by: Prasanna Kumar <prasanna.ps@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 6d0e87c..8043be3 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -558,11 +558,13 @@
>         pd_gsc: gsc-power-domain at 0x10044000 {
>                 compatible = "samsung,exynos4210-pd";
>                 reg = <0x10044000 0x20>;
> +               samsung,exynos-pd-clks ="aclk_266_gscl","aclk_300_gscl";

Passing clock names from dts is generally discouraged. These clock
names are linux specific. dts/dtsi files should only describe the
hardware and not have any linux specific entries in them. Common clock
framework can be used here to specify the clock.

>         };
>
>         pd_mfc: mfc-power-domain at 0x10044040 {
>                 compatible = "samsung,exynos4210-pd";
>                 reg = <0x10044040 0x20>;
> +               samsung,exynos-pd-clks ="aclk_333";

same as above comment.

Thanks,
Thomas.

>         };
>
>         gsc_0:  gsc at 0x13e00000 {
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
