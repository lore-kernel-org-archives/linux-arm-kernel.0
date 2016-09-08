From: vz@mleia.com (Vladimir Zapolskiy)
Date: Thu, 8 Sep 2016 21:21:17 +0300
Subject: [PATCH v2] ARM: dts: lpc32xx: set default parent clock for pwm1 &
 pwm2
In-Reply-To: <1473356873-10610-1-git-send-email-slemieux.tyco@gmail.com>
References: <1473356873-10610-1-git-send-email-slemieux.tyco@gmail.com>
Message-ID: <427912e4-a67a-898c-1736-8958f1b42296@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylvain,

On 08.09.2016 20:47, Sylvain Lemieux wrote:
> From: Sylvain Lemieux <slemieux@tycoint.com>
> 
> The change setup the peripheral clock (PERIPH_CLK) as the default
> parent clock for PWM1 & PWM2.
> 
> Signed-off-by: Sylvain Lemieux <slemieux@tycoint.com>
> ---
> Changes from v1 to v2:
> * Only assigned the PWM clock.
> 
>  arch/arm/boot/dts/lpc32xx.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
> index e295e1e..218d9fa 100644
> --- a/arch/arm/boot/dts/lpc32xx.dtsi
> +++ b/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -469,6 +469,8 @@
>  				compatible = "nxp,lpc3220-pwm";
>  				reg = <0x4005C000 0x4>;
>  				clocks = <&clk LPC32XX_CLK_PWM1>;
> +				assigned-clocks = <&clk LPC32XX_CLK_PWM1>;
> +				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
>  				status = "disabled";
>  			};
>  
> @@ -476,6 +478,8 @@
>  				compatible = "nxp,lpc3220-pwm";
>  				reg = <0x4005C004 0x4>;
>  				clocks = <&clk LPC32XX_CLK_PWM2>;
> +				assigned-clocks = <&clk LPC32XX_CLK_PWM2>;
> +				assigned-clock-parents = <&clk LPC32XX_CLK_PERIPH>;
>  				status = "disabled";
>  			};
>  
> 

the change is applied, thank you!

--
With best wishes,
Vladimir
