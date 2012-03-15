From: richard.zhao@linaro.org (Richard Zhao)
Date: Thu, 15 Mar 2012 23:15:23 +0800
Subject: [PATCH 1/2] ARM: imx6q: add pll round_rate support
In-Reply-To: <20120315150048.GC3852@pengutronix.de>
References: <1331713379-8437-1-git-send-email-richard.zhao@linaro.org>
 <1331713379-8437-2-git-send-email-richard.zhao@linaro.org>
 <20120314085228.GM3852@pengutronix.de>
 <20120315144601.GA5701@richard-laptop>
 <20120315150048.GC3852@pengutronix.de>
Message-ID: <20120315151521.GB5701@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 04:00:48PM +0100, Sascha Hauer wrote:
> On Thu, Mar 15, 2012 at 10:46:04PM +0800, Richard Zhao wrote:
> > On Wed, Mar 14, 2012 at 09:52:28AM +0100, Sascha Hauer wrote:
> > > On Wed, Mar 14, 2012 at 04:22:58PM +0800, Richard Zhao wrote:
> > > > Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> > > > ---
> > > >  
> > > >  #define DEF_PLL(name)					\
> > > >  	static struct clk name = {			\
> > > > @@ -681,6 +741,7 @@ static int pll_set_rate(struct clk *clk, unsigned long rate)
> > > >  		.disable	= pll_disable,		\
> > > >  		.get_rate	= name##_get_rate,	\
> > > >  		.set_rate	= name##_set_rate,	\
> > > > +		.round_rate	= name##_round_rate,	\
> > > 
> > > I hope this ## stuff is gone soon with the generic clock framework. It
> > > is so ugly and inefficient.
> > I hope this doesn't prevent this two patches go in.
> 
> Given that we are short from getting a generic clock framework (and I
> think this time it's for real) and that you are not mention in any words
> what these patches fix I don't see a reason for merging them.
I think the cpu clock is a great challenge for generic clock framework.
When it set_rate, it includes reparent, and change parent's parent's rate.
I don't see any upstream code like that till now. and it's really what
we need.

And it also block cpufreq from upstreaming.


Thanks
Richard
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
