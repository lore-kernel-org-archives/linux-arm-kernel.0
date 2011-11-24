From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 24 Nov 2011 15:16:49 +0100
Subject: BUG: sleeping function called from invalid context
In-Reply-To: <20111124102909.GO9581@n2100.arm.linux.org.uk>
References: <4ECCDAA2.4070502@prolan.hu>
 <CAOMZO5DSvLU0ACJPZ69tzY0PjMijibSzwCEwBhu=5=mg7ncF=g@mail.gmail.com>
 <20111123183640.GQ19986@pengutronix.de>
 <20111123225124.GK9581@n2100.arm.linux.org.uk>
 <20111124071406.GS19986@pengutronix.de>
 <20111124090141.GN9581@n2100.arm.linux.org.uk>
 <20111124090514.GW19986@pengutronix.de>
 <20111124102909.GO9581@n2100.arm.linux.org.uk>
Message-ID: <20111124141649.GY19986@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 24, 2011 at 10:29:09AM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 24, 2011 at 10:05:14AM +0100, Uwe Kleine-K?nig wrote:
> > On Thu, Nov 24, 2011 at 09:01:41AM +0000, Russell King - ARM Linux wrote:
> > > On Thu, Nov 24, 2011 at 08:14:06AM +0100, Uwe Kleine-K?nig wrote:
> > > > On Wed, Nov 23, 2011 at 10:51:24PM +0000, Russell King - ARM Linux wrote:
> > > > > So really, there's no excuse not to fix this for the imx/mxwhatever SoCs
> > > > > today - the clk framework is totally irrelevant as far as this goes.
> > > > I think doing the clk_prepare seperation and converting to the clk
> > > > framework in one step will be easier.
> > > 
> > > From a point of view of being able to separate the changes so there isn't
> > > a flag day, you're wrong.  clk_prepare() is already present in the kernel
> > > as dummy functions, and all you need to do at this point is arrange for
> > > the drivers to make the appropriate calls.  There's no need to write one
> > > line of code behind clk_prepare() at the current time.
> > Yeah, but adding clk_prepare to the serial driver doesn't help me to get
> > rid of the BUG reported in this thread without giving it some meaning in
> > the platform, right?
Note that I wrote that in reply to you saying "There's no need to write
one line of code behind clk_prepare() at the current time.".

> So, let's be honest about why this bug isn't being fixed then.  Your
> attitude to this problem is ignore it and to do nothing, rather than
> trying to fix it via a perfectly good transition path provided for
> you.
I don't think the mxs clock code needs a transition. I guess it will be
mostly reimplemented when the clk framework is settled. And I consider
it quite normal to live with code that is not optimal because there are
bigger changes in the queue that would make fixing the current code
useless. 
 
> Okay, now we can see clearly why the bug is still there.  Thanks.
> 
> Given such an attitude, remind me why I should care whether iMX breaks
> while we do the consolidation and cleanup work to core code, such as
> the recent restart changes.
There are several active contributors to i.MX that invest much time to
adapt i.MX to the current changes. Be it Shawn who does much DT stuff,
Sascha who proposed things for the clk framework or Richard who
converted i.MX5x to the the latest clk framework patches. That's why you
should care. And that is independant of me not doing much for i.MX
during the last few cycles.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
