From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 26 Jan 2012 23:34:14 +0000
Subject: at91: pm.h cleanup (was: [PATCH 1/4] at91 : coding style fixes)
In-Reply-To: <20120126203350.GD11941@n2100.arm.linux.org.uk>
References: <1327449368-29917-1-git-send-email-daniel.lezcano@linaro.org>
 <4F217CCD.5000104@atmel.com> <20120126203350.GD11941@n2100.arm.linux.org.uk>
Message-ID: <20120126233414.GF11941@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2012 at 08:33:50PM +0000, Russell King - ARM Linux wrote:
> On Thu, Jan 26, 2012 at 05:18:21PM +0100, Nicolas Ferre wrote:
> > Daniel,
> > 
> > I have rebased your patch series on top of:
> > 
> > - at91 late device/board patches that are planned for 3.3
> > - at91-fixes branch (should go also in 3.3)
> > * rmk/for-next branch (with a merge conflict resolved)
> > * the removal of CAP9 SoC family
> > 
> > You can find the resulting code in our git tree:
> > 
> > git://github.com/at91linux/linux-at91.git at91-pm_cleanup
> > 
> > I hope that I will be able to send this branch to arm-soc soon with a
> > minimum of future rebase (when the two first series cited above will be
> > in Linus' tree actually).
> 
> No you won't, not if you're including rmk/for-next in it.
> 
> Take a moment to think about that: rmk/for-next is NOT a topic branch.
> It is purely a branch published for the sake of SFR.  It gets torn down
> and regenerated regularly.  You can't base work off it.  It's all explained
> here:
> 
> 	http://www.arm.linux.org.uk/developer/git-arm.php

As a follow-up to this, your action has put in jeopardy two things:

1. The ability for me to publish patches in my git tree for people to be
   able to test large patch sets.

2. The ability to publish patches which are ready for mainline but have
   not yet had all the acks etc received.

The official position on the publication of git commits is that once
they're published, they can't be changed - with the exception of the
linux-next tree.

What that means is that if I followed that rule, I would not publish very
many changes until the last minute for the simple reason that people in
the ARM community absolutely suck to the back teeth giving acks and so
forth to large patch sets.  Example: had I followed that guidance, the
restart changes would not have gone in during the last merge window.

So, either *EVERYONE* understands how I run my tree and they DO NOT
EVER include any branch into their own tree without FIRST TALKING TO
ME, or I withdraw my tree from public access.  It's that simple.  It's
not something ANYONE can make a mistake over.  You make a mistake and
it causes BIG PROBLEMS.

SFR _has_ noticed and _is_ complaining about this.  It's only time
before it gets noticed elsewhere.

So, I've withdrawn the highly unstable devel-3.3 branch from public
view as of NOW.  I'm going to remove anything in for-next which isn't
100% ready.  That includes the mach-types update, because I intend
to redo it at some later time.

Congratulations.  And thanks for causing this situation through your
lack of due dilligence.
