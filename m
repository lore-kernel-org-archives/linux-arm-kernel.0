From: mark.rutland@arm.com (Mark Rutland)
Date: Sun, 1 Feb 2015 13:07:55 +0000
Subject: [PATCH 5/5] ARM: dts: pxa: add pxa-timer to pxa27x
In-Reply-To: <1422744510-3179-5-git-send-email-robert.jarzmik@free.fr>
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
 <1422744510-3179-5-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20150201130755.GA25767@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 31, 2015 at 10:48:30PM +0000, Robert Jarzmik wrote:
> Each pxa has an embedded OS Timers IP. The kernel cannot work without a
> valid clocksource, and this adds the OS Timers to the pxa device-tree
> description.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/boot/dts/pxa27x.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
> index 7f93828..9e6bf60 100644
> --- a/arch/arm/boot/dts/pxa27x.dtsi
> +++ b/arch/arm/boot/dts/pxa27x.dtsi
> @@ -97,5 +97,18 @@
>  			status = "okay";
>  		};
>  	};
> +
> +	clocksources {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +

There is absolutely no need for this container node.

Please get rid of it and place the node below directly under the parent
node.

Mark.

> +		pxa-timer at 40a00000 {
> +			compatible = "marvell,pxa-timer";
> +			reg = <0x40a00000 0x20>;
> +			interrupts = <26>;
> +			clocks = <&pxa2xx_clks CLK_OSTIMER>;
> +			status = "okay";
> +		};
>  	};
>  };
> -- 
> 2.1.0
> 
> 
