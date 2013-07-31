From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 31 Jul 2013 14:52:21 +0900
Subject: [PATCH 3/3] ARM: EXYNOS: Add G2D support to exynos5250
In-Reply-To: <1373013749-14530-3-git-send-email-sachin.kamat@linaro.org>
References: <1373013749-14530-1-git-send-email-sachin.kamat@linaro.org>
 <1373013749-14530-3-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1bb701ce8db2$1f96e180$5ec4a480$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Adds G2D node to exynos5250 DT file.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250.dtsi |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi
> b/arch/arm/boot/dts/exynos5250.dtsi
> index ef57277..6f356ce 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -163,6 +163,14 @@
>  		clock-names = "watchdog";
>  	};
> 
> +	g2d at 10850000 {
> +		compatible = "samsung,exynos5250-g2d";
> +		reg = <0x10850000 0x1000>;
> +		interrupts = <0 91 0>;
> +		clocks = <&clock 345>;
> +		clock-names = "fimg2d";
> +	};
> +
>  	codec at 11000000 {
>  		compatible = "samsung,mfc-v6";
>  		reg = <0x11000000 0x10000>;
> --
> 1.7.9.5

Looks ok to me, applied.

Thanks,
Kukjin
