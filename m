From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 5 Apr 2010 12:59:57 +0200
Subject: Memory corruption with 2.6.32.10, but not with 2.6.34-rc3
In-Reply-To: <20100401165857.GN30801@buzzloop.caiaq.de>
References: <20100401132156.GJ30807@buzzloop.caiaq.de>
	<20100401165144.GB1138@suse.de>
	<20100401165857.GN30801@buzzloop.caiaq.de>
Message-ID: <20100405105957.GA2302@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 01, 2010 at 06:58:57PM +0200, Daniel Mack wrote:
> On Thu, Apr 01, 2010 at 09:51:44AM -0700, Greg KH wrote:
> > On Thu, Apr 01, 2010 at 03:21:56PM +0200, Daniel Mack wrote:
> > > 
> > > I can cherry-pick things if anyone pin-points something and run
> > > lont-time tests again. Any pointer appreciated.
> > 
> > Oh, how about running 'git bisect' to try to find the solution?  Just
> > remember to reverse 'good' and 'bad' for when you tell git bisect what
> > the results are.
> 
> Jep, I thought about that of course. But unfortunately, the platform
> got merged mainline in the middle of that time window which makes
> bisecting tricky. And worse than that - every test run take around half
> a day at least :(
What you can do is backport the platform-support on top of rev initially
marked good (in a branch named say foo) and when asked for testing do:

	git merge --no-commit foo
	<test>
	git reset --hard
	git bisect {good|bad}

Assuming the platform-support got in in one go (and you shouldn't test
in the middle, which you can simply skip), the merge should always work
just fine.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
