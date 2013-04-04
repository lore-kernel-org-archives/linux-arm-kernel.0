From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 4 Apr 2013 18:04:37 +0200
Subject: [PATCH] at91sam9260.dtsi: fix u(s)art pinctrl encoding
In-Reply-To: <515D7A4F.90707@interlog.com>
References: <515D7A4F.90707@interlog.com>
Message-ID: <515DA495.8030205@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/04/2013 03:04 PM, Douglas Gilbert :

> A pattern is emerging with sloppy at91 dts(i) files
> with pinctrls: the comments are correct and the
> corresponding encoding is wrong. The other example that
> I fixed was at91sam9x5.dtsi . Makes you wonder how many
> people are using this DT stuff in anger ...
> 
> This problem was found with AT91SAM9G20 SoCs (Acme's FoxG20).
> The attached is against lk 3.9.0-rc5 .


>  
>  					pinctrl_usart3_rts: usart3_rts-0 {
>  						atmel,pins =
> -							<3 8 0x2 0x0>;	/* PB8 periph B */
> +							<1 8 0x2 0x0>;	/* PB8 periph B */

Here both the comment and the encoding were wrong:
it is PC8 periph B ==> <2 8 0x2  0x0>

>  					};
>  
>  					pinctrl_usart3_cts: usart3_cts-0 {
>  						atmel,pins =
> -							<3 10 0x2 0x0>;	/* PB10 periph B */
> +							<1 10 0x2 0x0>;	/* PB10 periph B */

Same here:
it is PC10 periph B ==> <2 10 0x2  0x0>

>  					};
>  				};

I correct this in your patch and submit it right now.

Thanks, best regards,
-- 
Nicolas Ferre
