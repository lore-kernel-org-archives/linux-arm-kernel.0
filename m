From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 10 Jan 2011 13:33:34 +0000
Subject: [PATCH] watchdog: add support for the Synopsys DesignWare WDT
In-Reply-To: <20110110132115.GM3801@infomag.iguana.be>
References: <1294656906-24239-1-git-send-email-jamie@jamieiles.com>
	<20110110132115.GM3801@infomag.iguana.be>
Message-ID: <20110110133333.GC2860@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 02:21:15PM +0100, Wim Van Sebroeck wrote:
> Hi Jamie,
> 
> > diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> > index 8a3aa2f..0981aae 100644
> > --- a/drivers/watchdog/Kconfig
> > +++ b/drivers/watchdog/Kconfig
> > @@ -331,6 +331,15 @@ config IMX2_WDT
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called imx2_wdt.
> >  
> > +config DW_WATCHDOG
> > +	tristate "Synopsys DesignWare watchdog"
> > +        select WATCHDOG_NOWAYOUT
> > +	help
> > +	  Say Y here if to include support for the Synopsys DesignWare
> > +	  watchdog timer found in many ARM chips.
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called dw_wdt.
> > +
> >  # AVR32 Architecture
> >  
> >  config AT32AP700X_WDT
> 
> Could you add the correct dependancy also in Kconfig?

Sure, updated patch below with a dependency on ARM.

Jamie

8<----------------------------------------------------------------------
