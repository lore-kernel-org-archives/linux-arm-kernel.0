From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 20 Jan 2010 16:30:27 +0100
Subject: git pre-commit hook running checkpatch.pl
In-Reply-To: <20100120100155.GA851@sirena.org.uk>
References: <20100120020202.GE26562@trinity.fluff.org>
	<20100120100155.GA851@sirena.org.uk>
Message-ID: <20100120153027.GB20271@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 20, 2010 at 10:01:55AM +0000, Mark Brown wrote:
> On Wed, Jan 20, 2010 at 02:02:02AM +0000, Ben Dooks wrote:
> 
> > I've written a git pre-commit[1] hook which stops any commits happening if
> > checkpatch.pl reports problems with the patch. Any comments?
> 
> > [1] http://www.fluff.org/ben/linux/githooks/pre-commit
> 
> Checkpatch does sometimes generate the occasional false positive which
> can be annoying when they trigger.  It can also be a problem when doing
> bugfixes IME - if an existing file has lots of checkpatch issues then a
> fix which maintains the same coding style as the surrounding code can
> trigger checkpatch issues which would if fixed make the code not fit in
> with the rest of the file.  Obviously it'd be desirable to fix the file
> but that's a bit unreasonable for people submitting bug fixes,
> especially when pushing fixes to Linus and stable.
> 
> That said, monitoring for checkpatch issues is useful.
Maybe only print the warnings instead of stopping a commit?  I'd not
like me stopping here not only for the reasons pointed out by Mark and
Russell, but also as I frequently do wip-commits that not necessarily
are checkpatch-clean.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
