From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Sep 2013 15:57:56 +0100
Subject: [PATCH 4/4] Add arch count timer node in dts for Allwinner
 A20(sunxi 7i).
In-Reply-To: <1378968687-8200-5-git-send-email-cinifr@gmail.com>
References: <1378968687-8200-1-git-send-email-cinifr@gmail.com>
 <1378968687-8200-5-git-send-email-cinifr@gmail.com>
Message-ID: <20130912145756.GD22013@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 12, 2013 at 07:51:27AM +0100, Fan Rong wrote:
> Signed-off-by: Fan Rong <cinifr@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index bfedcb2..ce138f7 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -312,5 +312,14 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <1 9 0xf04>;
>  		};
> +
> +		timer {
> +			compatible ="arm,armv7-timer";

Space after the '=' please.

> +			interrupts = <1 13 0x308>,
> +				     <1 14 0x308>,
> +				     <1 11 0x308>,
> +				     <1 10 0x308>;
> +			clock-frequency = <24000000>;

If at all possible, your bootloader should set CNTFREQ, and
clock-frequency should only be used as a last resort when it's
impossible to get it to set CNTFREQ. It's not possible to set CNTFREQ
from the non-secure side, so guests (which might not be Linux, and might
not handle DT in the same way) may see a completely wrong frequency
value.

Thanks,
Mark.

> +		};
>  	};
>  };
> -- 
> 1.7.9.5
> 
> 
