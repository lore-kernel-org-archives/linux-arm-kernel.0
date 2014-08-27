From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 27 Aug 2014 10:37:04 +0100
Subject: [PATCH] ARM: dts: make arch-timer always on in rk3288 soc
In-Reply-To: <1409104060-26294-1-git-send-email-kever.yang@rock-chips.com>
References: <1409104060-26294-1-git-send-email-kever.yang@rock-chips.com>
Message-ID: <20140827093704.GA7295@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 27, 2014 at 02:47:40AM +0100, Kever Yang wrote:
> We need use the hrtimer, which need the arch-timer to be 'always-on'

Just to check: it isn't possible to place CPUs in the rk3288 SoC into
low power states where their timers lose state and/or might not fire?

Mark.

> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
>  arch/arm/boot/dts/rk3288.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
> index 5950b0a..698e6ea 100644
> --- a/arch/arm/boot/dts/rk3288.dtsi
> +++ b/arch/arm/boot/dts/rk3288.dtsi
> @@ -76,6 +76,7 @@
>  			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>  			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  		clock-frequency = <24000000>;
> +		always-on;
>  	};
>  
>  	i2c1: i2c at ff140000 {
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
