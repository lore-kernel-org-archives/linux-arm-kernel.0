From: marvin24@gmx.de (Marc Dietich)
Date: Wed, 10 Aug 2011 13:31:18 +0200
Subject: [PATCH V3] ARM: tegra: paz00: add clocks required for usb
	operation
In-Reply-To: <4E426A71.1000100@ru.mvista.com>
References: <201108092308.11580.marvin24@gmx.de>
	<4E426A71.1000100@ru.mvista.com>
Message-ID: <201108101331.19087.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

> On 10-08-2011 1:08, Marc Dietrich wrote:
> > These clocks are required for usb operation. pll_p_out4 needs to be set
> > to 24 MHz. The other clocks default to "off" in order to safe some
> > energy.
> 
>     s/safe/save/

ah yeah, my english needs some polish,

>     You didn't sign off on the patch.

and that's even worse. Time for V4 I guess.

Sorry for all the trouble.

Marc

> 
> > ---
> > 
> >   arch/arm/mach-tegra/board-paz00.c |    6 ++++++
> >   1 files changed, 6 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/mach-tegra/board-paz00.c
> > b/arch/arm/mach-tegra/board- paz00.c
> > index 45111f6..cde36dc 100644
> > --- a/arch/arm/mach-tegra/board-paz00.c
> > +++ b/arch/arm/mach-tegra/board-paz00.c
> > @@ -145,6 +145,12 @@ static __initdata struct tegra_clk_init_table
> > paz00_clk_init_table[] = {
> > 
> >   	/* name		parent		rate		enabled */
> >   	{ "uarta",	"pll_p",	216000000,	true },
> >   	{ "uartd",	"pll_p",	216000000,	true },
> > 
> > +
> > +	{ "pll_p_out4",	"pll_p",	24000000,	true },
> > +	{ "usbd",	"clk_m",	12000000,	false },
> > +	{ "usb2",	"clk_m",	12000000,	false },
> > +	{ "usb3",	"clk_m",	12000000,	false },
> > +
> > 
> >   	{ NULL,		NULL,		0,		0},
> >   
> >   };
> 
> WBR, Sergei
