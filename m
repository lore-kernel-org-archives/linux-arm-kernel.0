From: pavel@denx.de (Pavel Machek)
Date: Fri, 26 Apr 2013 13:36:51 +0200
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <1366843482.29992.4.camel@linux-builds1>
References: <20130423105827.GA6983@amd.pavel.ucw.cz>
 <1366843482.29992.4.camel@linux-builds1>
Message-ID: <20130426113651.GA16289@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > -void __init dw_apb_timer_init(void)
> > +void __init dw_apb_timer_init(int use_as_scheduler)
> >  {
> >  	struct device_node *event_timer, *source_timer;
> > +	u32 rate;
> 
> You're not using rate anywhere in this function.
> 
> drivers/clocksource/dw_apb_timer_of.c: In function ?dw_apb_timer_init?:
> drivers/clocksource/dw_apb_timer_of.c:110:6: warning: unused variable
> ?rate?

Thanks, fixed.

> >  struct dw_apb_timer {
> > @@ -53,5 +59,5 @@ void dw_apb_clocksource_start(struct dw_apb_clocksource *dw_cs);
> >  cycle_t dw_apb_clocksource_read(struct dw_apb_clocksource *dw_cs);
> >  void dw_apb_clocksource_unregister(struct dw_apb_clocksource *dw_cs);
> >  
> > -extern void dw_apb_timer_init(void);
> > +extern void dw_apb_timer_init(int);
> >  #endif /* __DW_APB_TIMER_H__ */
> 
> On SOCFPGA:
> 
> Tested-by: Dinh Nguyen <dinguyen@altera.com>

Thanks! New patch is going out in few minutes.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
