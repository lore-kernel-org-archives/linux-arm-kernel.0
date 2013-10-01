From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 1 Oct 2013 11:11:01 +0200
Subject: [PATCH] clocksource: dw_apb_timer_of: Mark a few more functions
 as __init
In-Reply-To: <20131001090108.GL6918@tarshish>
References: <1380616692-10253-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131001090108.GL6918@tarshish>
Message-ID: <20131001091101.GK2548@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Tue, Oct 01, 2013 at 12:01:08PM +0300, Baruch Siach wrote:
> On Tue, Oct 01, 2013 at 10:38:12AM +0200, Uwe Kleine-K?nig wrote:
> > These are all only called by dw_apb_timer_init which is an __init
> > function, too
> > 
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/clocksource/dw_apb_timer_of.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
> > index 4cbae4f..993cdde 100644
> > --- a/drivers/clocksource/dw_apb_timer_of.c
> > +++ b/drivers/clocksource/dw_apb_timer_of.c
> > @@ -23,7 +23,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/sched_clock.h>
> >  
> > -static void timer_get_base_and_rate(struct device_node *np,
> > +static void __init timer_get_base_and_rate(struct device_node *np,
> >  				    void __iomem **base, u32 *rate)
> >  {
> >  	struct clk *timer_clk;
> > @@ -55,11 +55,11 @@ static void timer_get_base_and_rate(struct device_node *np,
> >  
> >  try_clock_freq:
> >  	if (of_property_read_u32(np, "clock-freq", rate) &&
> > -		of_property_read_u32(np, "clock-frequency", rate))
> > +	    of_property_read_u32(np, "clock-frequency", rate))
> 
> Unintended whitespace change?
Well no, it was intended and I wanted to mention it in the commit log,
but forgot about it. It read:

	if (something &&
		somethingelse)
		dosomething;

which is hard to read.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
