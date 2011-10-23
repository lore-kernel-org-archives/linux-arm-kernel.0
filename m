From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 23 Oct 2011 11:43:09 +0200
Subject: [RFC][PATCH] uncompress.h cleanup and DT support
In-Reply-To: <20111023092059.GB12814@n2100.arm.linux.org.uk>
References: <CAGVye5MSqdxh0DzCMt79sKk+Z0Trfro0RNDr-4zccMh7O7vGiA@mail.gmail.com>
	<20111023084132.GA12814@n2100.arm.linux.org.uk>
	<CAGVye5NQa857oNPEgQBWE0twQHL6U3BTeSOaR2aTiJzUxMvFSg@mail.gmail.com>
	<20111023092059.GB12814@n2100.arm.linux.org.uk>
Message-ID: <20111023094309.GM15299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 23, 2011 at 10:20:59AM +0100, Russell King - ARM Linux wrote:
> On Sun, Oct 23, 2011 at 11:12:50AM +0200, Zoltan Devai wrote:
> > 2011/10/23 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> > > On Sun, Oct 23, 2011 at 10:18:29AM +0200, Zoltan Devai wrote:
> > >> Plase consider all this as RFC, it's mostly not even compile-tested.
> > >> If you think it's worth to follow-up, I'm happy to do it.
> > >
> > > Is the patch available?
> > git://github.com/zdevai/linux.git uncompress-h
> 
> I'd rather not pull your tree just to look at the patch.  Is it
> available somewhere else?
It's not hard to look at it and no need to pull, just do:

	git fetch git://github.com/zdevai/linux.git uncompress-h
	git log -p ..FETCH_HEAD

(Of course you get the objects of the branch into your object-db but
that shouldn't matter much.)

Obviously this doesn't give a good opportunity to comment the patch.
It's just to satisfy your curiosity.

Just from a quick glance commit 77bf042c54650ecb39a0e6d79de827d3157cf817
is not OK. For example it changes the license terms
of arch/arm/mach-at91/include/mach/uncompress.h from GPLv2+ to GPLv2 and
removes a copyright. Ditto for some other files.

In commit dbd13d823641694c633c01e8e33e21eb76a1aad2 git played tricks on
you and removed a line like
	#define ARCH_HAVE_DECOMP_SETUP
because it thought it's a comment that shouldn't go into the log.
Note that this isn't very multi-SoC friendly.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
