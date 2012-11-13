From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 13 Nov 2012 08:48:03 +0000
Subject: [GIT PULL v3] Renesas ARM-based SoC boards for v3.8 #2
In-Reply-To: <20121113053651.GB18224@opensource.wolfsonmicro.com>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <201211122111.03440.arnd@arndb.de>
 <20121113053651.GB18224@opensource.wolfsonmicro.com>
Message-ID: <201211130848.03800.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 13 November 2012, Mark Brown wrote:
>   Show Details
>   On Mon, Nov 12, 2012 at 09:11:03PM +0000, Arnd Bergmann wrote:
> 
> > * Always let the person that owns the dependency know that the changes in
> >   their tree are also included elsewhere and that things go bad if those
> >   changes get rebased after all, or won't make it into the merge window
> >   for some reason.
> 
> Please never pull anything from me unless there's a signed tag for it,
> anything else I won't know about and may be rebased or vanish or
> something.

Ok, thanks for the reminder. Do you have a signed tag containing ab6f6d8521?

> > I have taken Mark on Cc to let him know about the dependency now, and I've
> > merged ab6f6d85210c4d0265cf48e9958c04e08595055a (which has only shmobile
> > specific ASoC patches) into the next/boards2 branch before merging your
> > branch. This is still not perfect because it breaks bisection, but it's
> > the best I could do aside from forcing you do do another round-trip.
> 
> What's the bisection problem?

I merged ab6f6d8521 first, and then Simon's branch, which means that the
linear (first-parent) history is ok, but bisecting the entire state of
the tree may end up in a commit in his branch in a state before it was
merged into mine, where it doesn't contain the patches it depends on,
and as Simon mentioned in his pull request, that will cause a build
failure.

	Arnd
