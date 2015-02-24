From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 14:34:06 +0100
Subject: [PATCH] spi: sirf: add reset controller dependency
In-Reply-To: <CAGb2v64hgW39c+gQXp-btpOu2_ddEnGBQk7udMGatCG8We+dBQ@mail.gmail.com>
References: <4553005.HBquOfbqXe@wuerfel> <5840299.CR2H70RAJi@wuerfel>
 <CAGb2v64hgW39c+gQXp-btpOu2_ddEnGBQk7udMGatCG8We+dBQ@mail.gmail.com>
Message-ID: <11771349.MCSxFTdomh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 18:56:44 Chen-Yu Tsai wrote:
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -1,11 +1,11 @@
> >  config STMMAC_ETH
> >         tristate "STMicroelectronics 10/100/1000 Ethernet driver"
> >         depends on HAS_IOMEM && HAS_DMA
> > +       depends on RESET_CONTROLLER
> >         select MII
> >         select PHYLIB
> >         select CRC32
> >         select PTP_1588_CLOCK
> > -       select RESET_CONTROLLER
> 
> I was the one that introduced this. At the time a generic binding for the
> stmmac core was requested, which supported an optional reset control. There
> wasn't an *_optional stub available, so I went with this. See
> 
>     http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/224684.html
> b424080a9e08
> With commit b424080a9e08 ("reset: Add optional resets and stubs") in, I
> think using devm_reset_control_get() in the driver is the proper solution.
> The hardware is found in quite a few platforms, and not all of them have
> reset controllers.

I suppose you mean devm_reset_control_get_option() instead of
devm_reset_control_get()?

Yes, that sounds right.

	Arnd
