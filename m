From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 19:58:54 +0800
Subject: [RFC V1 2/4] dts/imx6q: add cpufreq property
In-Reply-To: <1323947798-25251-2-git-send-email-richard.zhao@linaro.org>
References: <1323947798-25251-1-git-send-email-richard.zhao@linaro.org>
 <1323947798-25251-2-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111215115852.GC10522@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

Whenever we invent some new device tree binding support, we need to
Cc devicetree-discuss at lists.ozlabs.org (Cc-ed).

On Thu, Dec 15, 2011 at 07:16:36PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/boot/dts/imx6q.dtsi |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 263e8f3..9e9943b 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -29,6 +29,8 @@
>  			compatible = "arm,cortex-a9";
>  			reg = <0>;
>  			next-level-cache = <&L2>;
> +			cpu_freqs = <996000000 792000000 396000000 198000000>;
> +			cpu_volts = <1225000 1100000 950000 850000>;

For dt property name, we use '-' rather than '_'.

And I'm not sure this is correct, since these data obviously does not
belong to "arm,cortex-a9".

Regards,
Shawn

>  		};
>  
>  		cpu at 1 {
> -- 
> 1.7.5.4
