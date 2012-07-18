From: stigge@antcom.de (Roland Stigge)
Date: Wed, 18 Jul 2012 14:23:15 +0200
Subject: [PATCH 4/4] ARM: LPC32xx: Add PWM to base dts file
In-Reply-To: <1342613211-13190-5-git-send-email-stigge@antcom.de>
References: <1342613211-13190-1-git-send-email-stigge@antcom.de>
 <1342613211-13190-5-git-send-email-stigge@antcom.de>
Message-ID: <5006AAB3.4040307@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/18/2012 02:06 PM, Roland Stigge wrote:
> From: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> 
> Signed-off-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> ---
>  arch/arm/boot/dts/lpc32xx.dtsi |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> --- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
> +++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -278,6 +278,17 @@
>  				status = "disabled";
>  			};
>  
> +			pwm1: pwm at 0x4005C000 {
> +				compatible = "nxp,lpc3220-pwm";
> +				reg = <0x4005C000 0x4>;
> +				status = "disabled";
> +			};
> +
> +			pwm2: pwm at 0x4005C004 {
> +				compatible = "nxp,lpc3220-pwm";
> +				reg = <0x4005C004 0x4>;
> +				status = "disabled";
> +			};
>  		};
>  	};
>  };

Sorry, grabbed old version of patch. Should have been:


			pwm: pwm at 4005C000 {
				compatible = "nxp,lpc3220-pwm";
				reg = <0x4005C000 0x8>;
				status = "disabled";
			};

... because the driver now always registers the two channels together.

Will push it this way.

Roland
