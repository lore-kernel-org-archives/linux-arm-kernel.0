From: Dave.Martin@arm.com (Dave P Martin)
Date: Tue, 26 Nov 2013 11:11:15 +0000
Subject: [PATCH v4 REPOST] ARM: vexpress/TC2: Implement MCPM
 power_down_finish()
In-Reply-To: <20131125221154.GB18001@quad.lixom.net>
References: <1385396185-15291-1-git-send-email-Dave.Martin@arm.com>
 <CAOesGMjcNhqUikHhP-Jx5cHUocHQUTPW9p5ikwwQxbMSFM7hvQ@mail.gmail.com>
 <alpine.LFD.2.10.1311251259400.9667@knanqh.ubzr>
 <CAOesGMgVud7hX-wDtywt9_gkCDcuCgyXbm+CQG1kxjfCthLK2w@mail.gmail.com>
 <20131125185925.GC2293@e103592.cambridge.arm.com>
 <20131125221154.GB18001@quad.lixom.net>
Message-ID: <20131126111115.GA2342@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 10:11:54PM +0000, Olof Johansson wrote:
> On Mon, Nov 25, 2013 at 06:59:25PM +0000, Dave P Martin wrote:

[...]

> > Is there a good way to accelerate synchronisation of dependent patches
> > that must be merged through different trees?  It seemed most reliable to
> > wait for the mcpm patch to appear in Russell's public tree before posting
> > the dependent TC2 patch for merging -- the intent was to avoid grief for
> > maintainers, but this can backfire by causing delays.
> 
> I think it might be easier to work on git branches in those cases, since it's
> easy for us to share a pull request from you guys (and we'd do the vexpress
> piece on top). Without that it becomes more work for Russell to apply the patch
> on a stable branch himself, us finding out what the branch is, etc.
> 
> > If you can handle patches with a dependency that is in-flight via another
> > maintainer, then I'm happy to send such patches earlier in future, before
> > the dependency lands (with details about where to watch for it,
> > obviously).
> 
> I think doing a shared branch is by far the easiest way to do this. We want to
> avoid pulling in someone elses "main" development branch and keep shared code
> to a minimum, since it reduces the merge order dependencies upstream (not
> technical merge order, but to avoid us merging the feature from the other
> tree).

OK, I'll try and get something set up.

> > > Looks like the MCPM-side patch was posted already back in Oct 1. I'm
> > > not going to flame anyone over this, but it'd be nice if we could find
> > > out about these things sooner, ideally when breakage hits -next. Dave,
> > > next time I think I'd prefer to hear about it even if it is during the
> > > merge window. :-)
> > 
> > OK, noted.  Different people's opinions differ on that sometimes, but
> > I'll make sure you get the heads-up if a similar situation arises in
> > the future.
> 
> Sure. I think a heads up is always OK, btw -- it's just that some maintainers
> might choose not to act on it during the merge window.

Understood.

> > > Anyway, obviously it's needed and I'll apply it.
> > 
> > Thanks.  The kernel "works" without it in practice, though theoretically
> > it's not 100% safe, and I want to set the right example.
> > 
> > I'll try harder to avoid this kind of huccup another time.
> 
> No worries. MCPM+TC2 is hairy since half of it turns out to be core code, half
> board code.

I think this will always tend to happen for the "lead adopter" of a core
framework change?

Cheers
---Dave
