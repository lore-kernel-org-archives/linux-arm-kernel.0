From: marex@denx.de (Marek Vasut)
Date: Wed, 08 Jun 2016 01:46:01 +0200
Subject: [PATCH] ARM: dts: at91: ma5d4: properly define crystals
 frequencies
In-Reply-To: <1465342279-9193-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1465342279-9193-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <57575CB9.8020808@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2016 01:31 AM, Alexandre Belloni wrote:
> The Denx MA5D4 dts doesn't properly define the slow_xtal and main_xtal
> frequencies, the PMC then has to fallback to using the RC oscillators whose
> precision is not really good.
> 
> As both crystals are populated, define their frequencies, see p17 of
> http://www.denx-cs.de/sites/all/files/MA5D4.HWM_.002.pdf
> 
> Also, remove the obsolete main_clock definition.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

That's correct, I had similar patch in my tree.

Acked-by: Marek Vasut <marex@denx.de>

Thanks!

> ---
>  arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
> index e7b2109fc85a..99d57131782f 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
> @@ -20,8 +20,11 @@
>  	};
>  
>  	clocks {
> -		main_clock: main_clock {
> -			compatible = "atmel,osc", "fixed-clock";
> +		slow_xtal {
> +			clock-frequency = <32768>;
> +		};
> +
> +		main_xtal {
>  			clock-frequency = <12000000>;
>  		};
>  
> 


-- 
Best regards,
Marek Vasut
