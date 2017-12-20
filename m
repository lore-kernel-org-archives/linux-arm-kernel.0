From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 20 Dec 2017 09:13:48 +0100
Subject: [PATCH 42/45] ARM: dts: at91: vinco: use TCB2 as timers
In-Reply-To: <20171219213209.13823-43-alexandre.belloni@free-electrons.com>
 (Alexandre Belloni's message of "Tue, 19 Dec 2017 22:32:06 +0100")
References: <20171219213209.13823-1-alexandre.belloni@free-electrons.com>
 <20171219213209.13823-43-alexandre.belloni@free-electrons.com>
Message-ID: <874lolhl4z.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,
 
 On mar., d?c. 19 2017, Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:

> As TCB2 doesn't have any output pins, use it for timers
>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/at91-vinco.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/at91-vinco.dts b/arch/arm/boot/dts/at91-vinco.dts
> index 9f6005708ea8..1be9889a2b3a 100644
> --- a/arch/arm/boot/dts/at91-vinco.dts
> +++ b/arch/arm/boot/dts/at91-vinco.dts
> @@ -151,6 +151,18 @@
>  				status = "okay";
>  			};
>  
> +			tcb2: timer at fc024000 {
> +				timer at 0 {
> +					compatible = "atmel,tcb-timer";
> +					reg = <0>;
> +				};
> +
> +				timer at 1 {
> +					compatible = "atmel,tcb-timer";
> +					reg = <1>;
> +				};
> +			};
> +
>  			macb1: ethernet at fc028000 {
>  				phy-mode = "rmii";
>  				status = "okay";
> -- 
> 2.15.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
