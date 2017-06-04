From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Jun 2017 11:49:03 +0800
Subject: [PATCH RFC 5/5] ARM: dts: vf-colibri-eval: use IRQ_TYPE_* to
 specify irq flags
In-Reply-To: <20170526180609.2699-5-uwe@kleine-koenig.org>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
 <20170526180609.2699-5-uwe@kleine-koenig.org>
Message-ID: <20170604034902.GC4094@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 08:06:09PM +0200, Uwe Kleine-K?nig wrote:
> According to the binding documentation and the source code the
> vf610-gpio controller takes IRQ_TYPE_* as its flags values, not
> GPIO_ACTIVE_*.
> 
> This patch uses the right variable type which yields the same result
> when compiled. Note that this might be wrong and actually
> IRQ_TYPE_LEVEL_LOW is intended by the dt author.
> 
> Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
> ---
> Hello,
> 
> can somebody with the hardware or it's documentation please check which
> flag is the right one?

@Stefan, can you help to confirm?

Shawn

> 
> Best regards
> Uwe
> 
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> index 091b738041a0..3e0c84d79c43 100644
> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> @@ -117,7 +117,7 @@
>  		clocks = <&clk16m>;
>  		spi-max-frequency = <10000000>;
>  		interrupt-parent = <&gpio1>;
> -		interrupts = <11 GPIO_ACTIVE_LOW>;
> +		interrupts = <11 IRQ_TYPE_EDGE_RISING>;
>  	};
>  };
>  
> -- 
> 2.11.0
> 
