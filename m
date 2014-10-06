From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 06 Oct 2014 18:39:33 +0200
Subject: [PATCH] ARM: dts: Specify Odroid X2/U3 audio clock parents and
 rates
In-Reply-To: <1410360223-18363-1-git-send-email-s.nawrocki@samsung.com>
References: <1410360223-18363-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <5432C5C5.7020206@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/14 16:43, Sylwester Nawrocki wrote:
> This ensures the core and the audio subsystem clocks are configured
> properly, as expected by the sound machine driver. These bits are
> missing to obtain proper audio sample rates in kernel v3.17, where
> audio support for Odroid X2/U3 was first added.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> It would be good to have it applied as a fix for v3.17.

Anything happened to this patch ? I can't see it neither in Linus' nor
-next tree. And we are already at 3.18 merge window.

>  arch/arm/boot/dts/exynos4412-odroid-common.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> index adadaf9..b40f766 100644
> --- a/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> +++ b/arch/arm/boot/dts/exynos4412-odroid-common.dtsi
> @@ -45,6 +45,16 @@
>  		compatible = "samsung,odroidx2-audio";
>  		samsung,i2s-controller = <&i2s0>;
>  		samsung,audio-codec = <&max98090>;
> +		assigned-clocks = <&clock_audss EXYNOS_MOUT_AUDSS>,
> +				<&clock_audss EXYNOS_MOUT_I2S>,
> +				<&clock_audss EXYNOS_DOUT_SRP>,
> +				<&clock_audss EXYNOS_DOUT_AUD_BUS>;
> +		assigned-clock-parents = <&clock CLK_FOUT_EPLL>,
> +				<&clock_audss EXYNOS_MOUT_AUDSS>;
> +		assigned-clock-rates = <0>,
> +				<0>,
> +				<192000000>,
> +				<19200000>;
>  	};
> 
>  	mmc at 12550000 {
> --
> 1.7.9.5
