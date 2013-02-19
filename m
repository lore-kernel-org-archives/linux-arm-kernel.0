From: olof@lixom.net (Olof Johansson)
Date: Mon, 18 Feb 2013 21:11:26 -0800
Subject: [PATCH v6 16/16] ARM: dts: add board specific fixed rate clock
 nodes for Exynos based platforms
In-Reply-To: <1361175686-19400-17-git-send-email-thomas.abraham@linaro.org>
References: <1361175686-19400-1-git-send-email-thomas.abraham@linaro.org>
 <1361175686-19400-17-git-send-email-thomas.abraham@linaro.org>
Message-ID: <CAOesGMjXv6DnGKx3=Xvgae_z=Jj5dZ5ncXyRNQ7wmmpSNkh==g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Feb 18, 2013 at 12:21 AM, Thomas Abraham
<thomas.abraham@linaro.org> wrote:
> The clock frequency of xxti and xusbxti clocks is dependent on the frequency of the
> on-board oscillator that is used to generate these clocks. So allow the frequency
> of these clocks to be specfied from device tree.
>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts   |   12 ++++++++++++
>  arch/arm/boot/dts/exynos4210-smdkv310.dts |   12 ++++++++++++
>  arch/arm/boot/dts/exynos4210-trats.dts    |   12 ++++++++++++
>  arch/arm/boot/dts/exynos4412-odroidx.dts  |   12 ++++++++++++
>  arch/arm/boot/dts/exynos4412-origen.dts   |   12 ++++++++++++
>  arch/arm/boot/dts/exynos4412-smdk4412.dts |   12 ++++++++++++
>  arch/arm/boot/dts/exynos5250-arndale.dts  |    7 +++++++
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |    7 +++++++
>  arch/arm/boot/dts/exynos5250-snow.dts     |    7 +++++++
>  arch/arm/boot/dts/exynos5440-ssdk5440.dts |    7 +++++++
>  10 files changed, 100 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 052606b..1b30bc8 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -127,4 +127,16 @@
>                         linux,default-trigger = "heartbeat";
>                 };
>         };
> +
> +       fixed-rate-clocks {
> +               xxti {
> +                       compatible = "samsung,clock-xxti";
> +                       clock-frequency = <0>;
> +               };
> +
> +               xusbxti {
> +                       compatible = "samsung,clock-xusbxti";
> +                       clock-frequency = <24000000>;
> +               };
> +       };

Looks like xxti = 0 and xusbxti = 24MHz is the common frequencies on
nearly all boards. It probably makes sense to add that to the defaults
in dtsi, and override on the boards where it isn't the case. Saves
some boilerplate code in the .dts files.


-Olof
