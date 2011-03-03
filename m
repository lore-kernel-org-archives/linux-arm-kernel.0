From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 3 Mar 2011 12:02:15 +0100 (CET)
Subject: [PATCHv1] ARM: imx: Add support for low power suspend on MX51.
In-Reply-To: <20110303093532.GO22310@pengutronix.de>
References: <1299086278-12131-1-git-send-email-Dinh.Nguyen@freescale.com>
	<20110302215238.GK22310@pengutronix.de>
	<alpine.LFD.2.00.1103022343410.2701@localhost6.localdomain6>
	<20110303093532.GO22310@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1103031140330.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 3 Mar 2011, Uwe Kleine-K?nig wrote:
> On Thu, Mar 03, 2011 at 12:51:32AM +0100, Thomas Gleixner wrote:
> > > > +static int __init mx5_pm_init(void)
> > > I'd prefer to have that called by imx51_init_early.
> > 
> > And the reason is? 
> > 
> >     1) your personal preference
> >     2) there is some useful technical reason
> > 
> > If #1, then this comment was just waste of electrons
> > If #2, you failed to provide some reasonable explanation
> Actually it's #2, and to quote a different review[1]:
> 
> 	Reviewers hint to a correct solution and you are supposed to
> 	lookup what that solution means and act accordingly. If you do
> 	not understand the hint or its implications please ask [...]

I said the above when I hinted to use DEFINE_SPINLOCK(lock) instead of
static spinlock_t lock. And that requires to lookup what
DEFINE_SPINLOCK() actually does, which is a reasonable request.

How is the author of that code supposed to figure out what the merit
of s/mx5_pm_init/imx51_init_early/ is? By looking up your preferences
in google or what?

Using random quotes and failing to see why they don't apply is just
another proof of my assumption #1

Thanks,

	tglx
