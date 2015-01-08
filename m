From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 8 Jan 2015 10:59:18 +0100
Subject: [PATCH 1/1] ARM: at91/dt: sam9263: Add missing clocks to lcdc node
In-Reply-To: <1417786299-14026-1-git-send-email-alexanders83@web.de>
References: <1417786299-14026-1-git-send-email-alexanders83@web.de>
Message-ID: <20150108095918.GE2447@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2014 at 14:31:39 +0100, Alexander Stein wrote :
> atmel_lcdfb needs also uses hclk clock, but AT91SAM9263 doesn't have that
> specific clock, so use lcd_clk twice. The same is done in

I would say "was done" ;)

> arch/arm/mach-at91/at91sam9263.c
> 
> Signed-off-by: Alexander Stein <alexanders83@web.de>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/boot/dts/at91sam9263.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91sam9263.dtsi
> index 635f871..7989756 100644
> --- a/arch/arm/boot/dts/at91sam9263.dtsi
> +++ b/arch/arm/boot/dts/at91sam9263.dtsi
> @@ -932,6 +932,8 @@
>  			interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
>  			pinctrl-names = "default";
>  			pinctrl-0 = <&pinctrl_fb>;
> +			clocks = <&lcd_clk>, <&lcd_clk>;
> +			clock-names = "lcdc_clk", "hclk";
>  			status = "disabled";
>  		};
>  
> -- 
> 2.2.0
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
