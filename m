From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Feb 2013 10:44:19 -0800
Subject: [GIT PULL] i.MX clock fixes for v3.8
In-Reply-To: <20130205132759.GA17833@n2100.arm.linux.org.uk>
References: <20130205095844.GZ1906@pengutronix.de>
 <20130205110804.GI17786@n2100.arm.linux.org.uk>
 <20130205112558.GA1906@pengutronix.de>
 <201302051312.11434.arnd@arndb.de>
 <20130205132759.GA17833@n2100.arm.linux.org.uk>
Message-ID: <20130205184419.GA21776@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 01:27:59PM +0000, Russell King - ARM Linux wrote:
> On Tue, Feb 05, 2013 at 01:12:11PM +0000, Arnd Bergmann wrote:
> > On Tuesday 05 February 2013, Sascha Hauer wrote:
> > > >        So think twice - or thrice - before sending me patches or a pull
> > > >        request for -rc7. You need to have some seriously good reasons for
> > > >        doing so, and you need to state those reasons very clearly. And I
> > > >        don't just mean for the pull request in general, I mean for every
> > > >        single patch in it.
> > > > ...
> > > >        In other words, "It fixes a bug" just isn't good enough. The bug needs
> > > >        to be something that actually matters.
> > > 
> > > At least 'ARM: i.MX25: clk: parent per5_clk to AHB clock' is a
> > > regression that causes nasty oopses. Admittedly, it wasn't introduced in
> > > the last merge window and the board requiring the fix needs out of tree
> > > patches.
> > > 
> > > I'm fine with these going into v3.9 and waiting for the first stable
> > > patch to get the fix for the above.
> > 
> > My rules is usually: if it's important enough to have it backported
> > into a stable kernel, then it's also important enough to get sent
> > at any time during the bug fix phase.
> > 
> > The patch you  mentioned certainly fits that category. The other one
> > might as well, but the patch description does not actually say what
> > the impact of the bug is, so it is hard to tell.
> 
> Look at what Linus is saying.  Too much stuff went into -rc6.  He doesn't
> want that happening for -rc7.  He wants -rc7 to be really tiny, like
> almost _no_ changes.  Look at the description about what he wants to
> see: he doesn't want to see user visible regressions.  He wants to see
> _big_ user visible regressions only.
> 
> Also look at what he's saying wrt describing _every_ _single_ _patch_ in
> your pull request with a justification why it's there.  Can you do this
> for every patch you have planned to push?  Do you have sufficient
> information from those sending you these pull requests for fixes to v3.8
> to do that?  If not, you probably shouldn't be pulling them with a view
> to sending them to Linus (unless you wish to be flamed.)
> 
> I certainly can't with the three patches I had queued for fixes before
> -rc6.  They may be fixing problems which cause a few platforms not to
> boot or oops at boot, but I can't justify them against what Linus has
> said.  So I'm going to wait for the next merge window and put them in
> with a stable CC.  There's more patches like that post-rc6: there's one
> which fixes an obscure problem with 'make' which occurs with 2G:2G VM
> split.  But I'm not pushing that one either because it's not a _big_
> enough problem (it's only had _one_ user report it.)  One user is not
> sufficient justification.

Yeah, I was just looking at my queue here (and then came upon this thread).
>From what we have queued up right now in arm-soc fixes, I don't see anything
that _truly_ needs to go in for 3.8.

If someone feels differently, let me know (with a very solid motivation) and
I will consider sending it up. But right now I am likely going to fold the
'fixes' branch into 'fixes-non-critical' for 3.9 instead.


-Olof
