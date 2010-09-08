From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 10:14:44 +0100
Subject: [PATCH 4/5] [ARM] Auto calculate ZRELADDR and provide option
	for exceptions
In-Reply-To: <20100905185254.GA24014@pengutronix.de>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-5-git-send-email-eric.miao@canonical.com>
	<20100902212145.GA15264@n2100.arm.linux.org.uk>
	<20100902212723.GC26319@n2100.arm.linux.org.uk>
	<20100903074806.GX14214@pengutronix.de>
	<20100903095504.GC13643@pengutronix.de>
	<20100905185254.GA24014@pengutronix.de>
Message-ID: <20100908091444.GD29914@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 05, 2010 at 08:52:54PM +0200, Uwe Kleine-K?nig wrote:
> Hello Russell,
> 
> On Fri, Sep 03, 2010 at 11:55:04AM +0200, Uwe Kleine-K?nig wrote:
> > On Fri, Sep 03, 2010 at 09:48:06AM +0200, Uwe Kleine-K?nig wrote:
> > > On Thu, Sep 02, 2010 at 10:27:23PM +0100, Russell King - ARM Linux wrote:
> > > > 
> > > > And while we're here, why hasn't anyone removed the zreladdr
> > > > definitions in Makefile.boot yet?  Or do we still need them and
> > > > we now have the same information defined in two different places?
> > > > 
> > > > This all looks like a half-done job at the moment.  Please clean it up.
> > > The original series removed all the 'Makefile.boot's IIRC.  Currently
> > > the params_phys-y value is needed though.  So should I send a patch that
> > > just removes the zreladdr values?
> > I looked into that and found some more issues.  I hope I catched them
> > all now.  While doing that removing the zreladdr lines was nearly for
> > free.  So I did that, too.
> I just noticed that you already started working here on your master
> branch.  (Commit cbb288bf874f86 hides ZRELADDR.)
> 
> In a different thread you said you might revert the commit introducing
> ZRELADDR.  In case you are not satisfied by Eric's and my work on this
> series let my point out that I sent the a patch identically to
> cbb288bf874f86 in reply to the mail you link to in cbb288bf874f86's
> commit message already a month ago.
> 
> Are you OK with my series?  If yes, can you please say so, then I will
> rebase on top of your current master branch.

See one of my other replies today; I think it'll just be better in the
long run to get rid of this CONFIG_ZRELADDR idea.  Our original way
of doing this was simpler, less error prone, and less conflict prone.
