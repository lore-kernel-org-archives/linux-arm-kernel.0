From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 18 Feb 2016 23:10:42 +0800
Subject: [PATCH] ARM: dts: vf610: add performance monitoring unit
In-Reply-To: <1455755820-31442-1-git-send-email-stefan@agner.ch>
References: <1455755820-31442-1-git-send-email-stefan@agner.ch>
Message-ID: <20160218151042.GE6756@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 04:37:00PM -0800, Stefan Agner wrote:
> All Freescale Vybrid SoC include a Cortex-A5 core which supports
> ARM's standard PMU (performance monitoring unit). Include the
> monitoring unit into the Cortex-A5 base device tree vf500.dtsi.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/boot/dts/vf500.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf500.dtsi b/arch/arm/boot/dts/vf500.dtsi
> index b94b992..9cd1ac5 100644
> --- a/arch/arm/boot/dts/vf500.dtsi
> +++ b/arch/arm/boot/dts/vf500.dtsi
> @@ -75,6 +75,16 @@
>  				clocks = <&clks VF610_CLK_PLATFORM_BUS>;
>  			};
>  		};
> +
> +		aips-bus at 40080000 {
> +

This new line is not really necessary.  I applied the patch with it
dropped.

Shawn

> +			pmu at 40089000 {
> +				compatible = "arm,cortex-a5-pmu";
> +				interrupts = <7 IRQ_TYPE_LEVEL_HIGH>;
> +				interrupt-affinity = <&a5_cpu>;
> +			};
> +		};
> +
>  	};
>  };
>  
> -- 
> 2.7.1
> 
> 
