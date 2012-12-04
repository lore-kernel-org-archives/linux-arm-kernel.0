From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Tue, 4 Dec 2012 03:13:09 +0000
Subject: [PATCH 03/11] watchdog/at91sam9_wdt: change the wdt_read and
 wdt_write macro to the inline function
In-Reply-To: <20121116134901.GH4398@game.jcrosoft.org>
References: <1352877369-19740-1-git-send-email-wenyou.yang@atmel.com>
 <1352877369-19740-4-git-send-email-wenyou.yang@atmel.com>
 <20121116134901.GH4398@game.jcrosoft.org>
Message-ID: <B256D81BAE5131468A838E5D7A2436413A01CE7D@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi JC,

> -----Original Message-----
> From: Jean-Christophe PLAGNIOL-VILLARD [mailto:plagnioj at jcrosoft.com]
> Sent: 2012?11?16? 21:49
> To: Yang, Wenyou
> Cc: linux-arm-kernel at lists.infradead.org; wim at iguana.be;
> linux-watchdog at vger.kernel.org; linux-kernel at vger.kernel.org; Ferre, Nicolas; Lin,
> JM
> Subject: Re: [PATCH 03/11] watchdog/at91sam9_wdt: change the wdt_read and
> wdt_write macro to the inline function
> 
> On 15:16 Wed 14 Nov     , Wenyou Yang wrote:
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >  drivers/watchdog/at91sam9_wdt.c |   28 ++++++++++++++++++----------
> >  1 file changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/watchdog/at91sam9_wdt.c b/drivers/watchdog/at91sam9_wdt.c
> > index 31c914a..98e7d5a 100644
> > --- a/drivers/watchdog/at91sam9_wdt.c
> > +++ b/drivers/watchdog/at91sam9_wdt.c
> > @@ -34,11 +34,6 @@
> >
> >  #define DRV_NAME "AT91SAM9 Watchdog"
> >
> > -#define wdt_read(field) \
> > -	__raw_readl(at91wdt_private.base + field)
> > -#define wdt_write(field, val) \
> > -	__raw_writel((val), at91wdt_private.base + field)
> > -
> >  /* AT91SAM9 watchdog runs a 12bit counter @ 256Hz,
> >   * use this to convert a watchdog
> >   * value from/to milliseconds.
> > @@ -75,13 +70,24 @@ struct at91wdt_drvdata {
> >
> >  /* ......................................................................... */
> >
> > +static inline unsigned int wdt_read(struct at91wdt_drvdata *driver_data,
> > +					unsigned int field)
> > +{
> > +	return __raw_readl(driver_data->base + field);
> > +}
> > +
> > +static inline void wdt_write(struct at91wdt_drvdata *driver_data,
> > +				unsigned int field, unsigned int val)
> > +{
> > +	__raw_writel((val), driver_data->base + field);
> > +}
> use relaxed version

Thanks, I will change it.
> 
> Best Regrds,
> J.

Best Regards,
Wenyou Yang
