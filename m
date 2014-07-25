From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Fri, 25 Jul 2014 11:10:33 +0200
Subject: [PATCH] ARM: at91: at91sam9x5: sets NPCS0 (PA14) back to GPIO
In-Reply-To: <53D21C57.3010805@aksignal.cz>
References: <1405074175-22444-1-git-send-email-voice.shen@atmel.com>
 <53D10C50.50305@aksignal.cz> <20140724162645.4e19c26c@bbrezillon>
 <53D12103.3020103@aksignal.cz> <20140724175848.44f5da10@bbrezillon>
 <53D1F5D0.1080006@aksignal.cz> <20140725083053.GD9532@piout.net>
 <53D2174B.4020403@aksignal.cz> <20140725085436.GF9532@piout.net>
 <53D21C57.3010805@aksignal.cz>
Message-ID: <20140725111033.49a0e7e8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Jul 2014 10:59:03 +0200
Ji?? Prchal <jiri.prchal@aksignal.cz> wrote:

> 
> 
> Dne 25.7.2014 v 10:54 Alexandre Belloni napsal(a):
> > On 25/07/2014 at 10:37:31 +0200, Ji?? Prchal wrote :
> >>
> >>
> >> Dne 25.7.2014 v 10:30 Alexandre Belloni napsal(a):
> >>> Hi,
> >>>
> >>> On 25/07/2014 at 08:14:40 +0200, Ji?? Prchal wrote :
> >>>> I'm using custom board. My spi node:
> >>>> 			spi0: spi at f0000000 {
> >>>
> >>> You should override the pinctrl here as you are using gpios for the cs.
> >>> 				pinctrl-0 = <&pinctrl_spi0_custom>;
> >>>
> >>>> 				status = "okay";
> >>>> 				cs-gpios = <&pioA 23 0
> >>>> 					    &pioA 22 0
> >>>> 					    &pioC 29 0
> >>>> 					    &pioA 14 0>;
> >>>>
> >>>
> >>> 		pinctrl at fffff400 {
> >>> 				spi0 {
> >>> 					 pinctrl_spi0_custom: spi0-custom {
> >>> 							 atmel,pins =
> >>> 									 <AT91_PIOA 23 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>,
> >>> 									 <AT91_PIOA 22 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>,
> >>> 									 <AT91_PIOC 29 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>,
> >>> 									 <AT91_PIOA 14 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
> >>> 					 };
> >>> 				};
> >>> 		};
> >>>
> >> Of course, it's the way, but in all other drivers, for example LEDS,
> >> it's not needed. And in other way, if I will not use PA14 at all,
> >> the pin will goes down every spi transfer.
> >
> > You must not assumed that the pins are muxed to their default state
> > which is gpio and you should set the pinctrl accordingly for each
> > device.
> >
> > If you don't use PA14 at all, then you don't really care about its
> > state...
> Yes and no, what about on board is populated some chip on PA14, but for some reason at this time I don't need it and not 
> defined in DT?

As long as it's populated you should define it in the DT (the DT should
represent your hardware) and if you don't want to use the populated
device, just set the status property to "disabled" (I'm not sure it
works for spi subdevices though).




-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
