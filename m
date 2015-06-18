From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu, 18 Jun 2015 09:33:44 +0200
Subject: [PATCH] clk: at91: add generated clock driver
In-Reply-To: <1434611556.2385.8.camel@x220>
References: <1434547409-12232-1-git-send-email-nicolas.ferre@atmel.com>
 <1434611556.2385.8.camel@x220>
Message-ID: <20150618093344.7d486e97@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Thu, 18 Jun 2015 09:12:36 +0200
Paul Bolle <pebolle@tiscali.nl> wrote:

> On Wed, 2015-06-17 at 15:23 +0200, Nicolas Ferre wrote:
> 
> > --- a/arch/arm/mach-at91/Kconfig
> > +++ b/arch/arm/mach-at91/Kconfig
>  
> > +config HAVE_AT91_GENERATED
> > +	bool
> 
> This will always be 'n'.  
> 
> > --- a/drivers/clk/at91/Makefile
> > +++ b/drivers/clk/at91/Makefile
> 
> > +obj-$(CONFIG_HAVE_AT91_GENERATED)	+= clk-generated.o
> 
> And clk-generated.o will never be built.
> 
> I think your options are to use
> 	config HAVE_AT91_GENERATED
> 		def_bool y
> 
> or
> 	config HAVE_AT91_GENERATED
> 		bool "Yadda yadda yadda"
> 
> or add
> 	select HAVE_AT91_GENERATED
> 
> somewhere (possibly even in a second patch). But as it stands the patch
> looks like an elaborate NOP.

I guess it will be selected by platforms embedding such clks. We just
have to wait for those platform to reach mainline ;-). 

Best Regards,

Boris
-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
