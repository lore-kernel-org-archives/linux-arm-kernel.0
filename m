From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Tue, 23 Sep 2014 12:11:44 +0200
Subject: [PATCH v7 06/10] rtc: at91sam9: rework the Kconfig description
In-Reply-To: <542146AF.3060807@atmel.com>
References: <1411465130-29011-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411465130-29011-7-git-send-email-boris.brezillon@free-electrons.com>
 <542146AF.3060807@atmel.com>
Message-ID: <20140923121144.0fd5d3c8@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Sep 2014 12:08:47 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> On 23/09/2014 11:38, Boris BREZILLON :
> > Remove all references to AT91CAP9 SoC which has been removed.
> > Rework the help message to remove any specific references to AT91SAM9 SoCs.
> > 
> > Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
> > ---
> >  drivers/rtc/Kconfig | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> > index 7d76da8..455f2c3 100644
> > --- a/drivers/rtc/Kconfig
> > +++ b/drivers/rtc/Kconfig
> > @@ -1079,17 +1079,18 @@ config RTC_DRV_AT91RM9200
> >  	  this is powered by the backup power supply.
> >  
> >  config RTC_DRV_AT91SAM9
> > -	tristate "AT91SAM9x/AT91CAP9 RTT as RTC"
> > +	tristate "AT91SAM9 RTT as RTC"
> >  	depends on ARCH_AT91 && !(ARCH_AT91RM9200 || ARCH_AT91X40)
> >  	select MFD_SYSCON
> >  	help
> > -	  RTC driver for the Atmel AT91SAM9x and AT91CAP9 internal RTT
> > -	  (Real Time Timer). These timers are powered by the backup power
> > -	  supply (such as a small coin cell battery), but do not need to
> > -	  be used as RTCs.
> > -
> > -	  (On AT91SAM9rl and AT91SAM9G45 chips you probably want to use the
> > -	  dedicated RTC module and leave the RTT available for other uses.)
> > +	  Some AT91SAM9 SoCs provide an RTT (Real Time Timer) block which
> > +	  can be used as an RTC thanks to the backup power supply (e.g. a
> > +	  small coin cell battery) which keeps this block and the GPBR
> > +	  (General Purpose Backup Registers) block powered when the device
> > +	  is shutdown.
> > +	  Some AT91SAM9 SoCs provide a real RTC block, on those ones you'd
> > +	  probably want to use the real RTC block instead of the RTT as an
> > +	  RTT driver.
> 
> You mean:
> "instead of the RTT as an RTC"

Yep, that's what I meant.

> 
> With that, good description: thanks!
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> So, now we can think of what to do with the series:
> 
> - Johan, do you want to "Ack" it?
> - may I take it through the arm-soc git tree (likely for the 3.19 dev.
> phase).
> 
> Your thoughts?
> 
> Bye,
> 
> >  
> >  config RTC_DRV_AT91SAM9_RTT
> >  	int
> > 
> 
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
