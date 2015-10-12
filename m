From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Mon, 12 Oct 2015 07:48:18 +0000
Subject: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior to
 suspending
In-Reply-To: <20151012065323.GA3558@piout.net>
References: <1444612677-26178-1-git-send-email-wenyou.yang@atmel.com>
 <20151012065323.GA3558@piout.net>
Message-ID: <B256D81BAE5131468A838E5D7A243641D632111B@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexandre,

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at free-electrons.com]
> Sent: 2015?10?12? 14:53
> To: Yang, Wenyou
> Cc: Alessandro Zummo; Ferre, Nicolas; Desroches, Ludovic; rtc-
> linux at googlegroups.com; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] rtc: at91rm9200: clear RTC alarm status flag prior to
> suspending
> 
> Hi Wenyou,
> 
> On 12/10/2015 at 09:17:57 +0800, Wenyou Yang wrote :
> > This patch is to clear the RTC alarm status flag prior to suspending
> > to avoid the erroneous wake-up activity.
> >
> 
> Is this a new issue appearing with the sama5d2 or was it present from the
> beginning?
With the sama5d2 ULP1 mode, not from the beginning.

> 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> >
> >  drivers/rtc/rtc-at91rm9200.c |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/rtc/rtc-at91rm9200.c
> > b/drivers/rtc/rtc-at91rm9200.c index cb62e21..b60fd47 100644
> > --- a/drivers/rtc/rtc-at91rm9200.c
> > +++ b/drivers/rtc/rtc-at91rm9200.c
> > @@ -495,6 +495,8 @@ static int at91_rtc_suspend(struct device *dev)
> >  	/* this IRQ is shared with DBGU and other hardware which isn't
> >  	 * necessarily doing PM like we are...
> >  	 */
> > +	at91_rtc_write(AT91_RTC_SCCR, AT91_RTC_ALARM);
> > +
> >  	at91_rtc_imr = at91_rtc_read_imr()
> >  			& (AT91_RTC_ALARM|AT91_RTC_SECEV);
> >  	if (at91_rtc_imr) {
> > --
> > 1.7.9.5
> >
> 
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

Best Regards,
Wenyou Yang
