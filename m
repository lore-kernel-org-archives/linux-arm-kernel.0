From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 20 Jun 2013 15:57:44 +0100
Subject: [GIT PULL] picoxcell cleanups for 3.11
In-Reply-To: <201306201624.09841.arnd@arndb.de>
References: <20130611122621.GA9967@page> <20130619100224.GB8641@page>
 <201306201624.09841.arnd@arndb.de>
Message-ID: <20130620145744.GC8641@page>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Jun 20, 2013 at 04:24:09PM +0200, Arnd Bergmann wrote:
> On Wednesday 19 June 2013, Jamie Iles wrote:
> > Fixing Arnd's mail address (sorry!).
> 
> you did forget to fix up Olof's address though.

Gah, fat fingers!

> > > ----------------------------------------------------------------
> > > Jamie Iles (1):
> > >       picoxcell: remove redundant common.h
> > > 
> > > Maxime Ripard (1):
> > >       ARM: picoxcell: Remove init_irq declaration in machine description
> 
> I got a regression since NR_IRQS_LEGACY is not defined with the headers
> removed.
> 
> I think we can just remove this line as well, since NR_IRQS_LEGACY is
> the default anyway.
> 
> Does that work?

I can't reproduce the failure here with my config, I guess it's getting 
included through one of the other includes.  Either way, your fix looks 
good to me.

Thanks,

Jamie

> diff --git a/arch/arm/mach-picoxcell/common.c b/arch/arm/mach-picoxcell/common.c
> index 8267c5d..b13f51b 100644
> --- a/arch/arm/mach-picoxcell/common.c
> +++ b/arch/arm/mach-picoxcell/common.c
> @@ -79,7 +79,6 @@ static void picoxcell_wdt_restart(char mode, const char *cmd)
>  
>  DT_MACHINE_START(PICOXCELL, "Picochip picoXcell")
>  	.map_io		= picoxcell_map_io,
> -	.nr_irqs	= NR_IRQS_LEGACY,
>  	.init_machine	= picoxcell_init_machine,
>  	.dt_compat	= picoxcell_dt_match,
>  	.restart	= picoxcell_wdt_restart,
