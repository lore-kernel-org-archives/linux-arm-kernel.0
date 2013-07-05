From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 6 Jul 2013 00:12:04 +0200
Subject: [PATCHv3 08/10] clocksource: sun4i: Remove TIMER_SCAL variable
In-Reply-To: <alpine.DEB.2.02.1307052245390.32106@ionos.tec.linutronix.de>
References: <1373052877-29366-1-git-send-email-maxime.ripard@free-electrons.com>
 <1373052877-29366-9-git-send-email-maxime.ripard@free-electrons.com>
 <alpine.DEB.2.02.1307052245390.32106@ionos.tec.linutronix.de>
Message-ID: <20130705221204.GO2959@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 10:48:45PM +0200, Thomas Gleixner wrote:
> 
> 
> On Fri, 5 Jul 2013, Maxime Ripard wrote:
> 
> > The prescaler is only used when using the internal low frequency
> > oscillator (at 32kHz). Since we're using the higher frequency oscillator
> > at 24MHz, we can just remove it.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/clocksource/sun4i_timer.c | 11 +++--------
> >  1 file changed, 3 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
> > index 00e17d9..2f84075 100644
> > --- a/drivers/clocksource/sun4i_timer.c
> > +++ b/drivers/clocksource/sun4i_timer.c
> > @@ -34,8 +34,6 @@
> >  #define TIMER_INTVAL_REG(val)	(0x10 * (val) + 0x14)
> >  #define TIMER_CNTVAL_REG(val)	(0x10 * (val) + 0x18)
> >  
> > -#define TIMER_SCAL		16
> > -
> 
> I can understand this one.
> 
> >  static void __iomem *timer_base;
> >  
> >  /*
> > @@ -139,7 +137,6 @@ static u32 sun4i_timer_sched_read(void)
> >  
> >  static void __init sun4i_timer_init(struct device_node *node)
> >  {
> > -	unsigned long rate = 0;
> >  	struct clk *clk;
> >  	int ret, irq;
> >  	u32 val;
> > @@ -157,8 +154,6 @@ static void __init sun4i_timer_init(struct device_node *node)
> >  		panic("Can't get timer clock");
> >  	clk_prepare_enable(clk);
> >  
> > -	rate = clk_get_rate(clk);
> > -
> 
> But this one is bogus. Why do you want to read the clock rate five
> times in a row instead of using the single cached value?
> 
> That does not make any sense.

Right, I'll send a new version.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130706/1e21f222/attachment-0001.sig>
