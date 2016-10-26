From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 26 Oct 2016 09:52:15 +0200
Subject: arm/boot/dts/at91sam9260.dtsi USB clock divisors and AT91SAM9G20
In-Reply-To: <CAAkeqgVrCEAtX+Tujjqe4admkhnn1746kL4_d8Z1NjCwVwUGcA@mail.gmail.com>
References: <CAAkeqgVrCEAtX+Tujjqe4admkhnn1746kL4_d8Z1NjCwVwUGcA@mail.gmail.com>
Message-ID: <20161026075215.f5gpk6xoex6t3zco@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/10/2016 at 10:49:01 -0700, Andrey Yurovsky wrote :
> I'm working at an AT91SAM9G20 on which the USB clock divisor was wrong
> and traced the issue down to arm/boot/dts/at91sam9260.dtsi which is
> included like this:
> 
> at91sam9g20ek_common.dtsi
>     at91sam9g20.dtsi
>         at91sam9260.dtsi
> 
> This has a node:
> 
>                 usb: usbck {
>                     compatible = "atmel,at91rm9200-clk-usb";
>                     #clock-cells = <0>;
>                     atmel,clk-divisors = <1 2 4 0>;
>                     clocks = <&pllb>;
>                 };
> 
> However the G20 parts seem to need a different divisor, for me this works:
> 
>                 usb: usbck {
>                     compatible = "atmel,at91rm9200-clk-usb";
>                     #clock-cells = <0>;
>                     atmel,clk-divisors = <4 2 0 0>;
>                     clocks = <&pllb>;
>                 };
> 
> Should the USB clock node be moved to a separate .dtsi file to account
> for this difference?

I think the easiest way of doing it is to override atmel,clk-divisors in
at91sam9g20.dtsi.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
