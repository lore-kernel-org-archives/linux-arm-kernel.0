From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 28 Oct 2015 13:34:38 +0000
Subject: [PATCH] MAINTAINERS: Start using the 'reviewer' (R) tag
In-Reply-To: <CABxcv=kCuYaYWgnvEUuTGv1RXdS6_3DR=6fnzHhAh7V-KFfCrQ@mail.gmail.com>
References: <CAJKOXPc_w2Dc8LvkCu_d+kjZZmYScXboQrpNWdicT2yfL_5D7Q@mail.gmail.com>
 <20151028082446.GF5828@x1>
 <CABxcv=mGZstqyrkB95hjDCYCvhDJDVD=ga-Fg_5yPtXETuWe=g@mail.gmail.com>
 <20151028102832.GR5828@x1>
 <CABxcv=mzzcx3o0m3hYzcn0DyM2pEFDZ-ZgVCjChWGf+y4Xy78A@mail.gmail.com>
 <1446030399.2757.83.camel@perches.com>
 <CABxcv=m+aMgtKPA-WBX9rTW8c3pnMmZgNG=NvnbaeOchdZ87hg@mail.gmail.com>
 <20151028113932.GS5828@x1> <20151028121454.GA4058@x1>
 <CABxcv=kCuYaYWgnvEUuTGv1RXdS6_3DR=6fnzHhAh7V-KFfCrQ@mail.gmail.com>
Message-ID: <20151028133438.GC4058@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 28 Oct 2015, Javier Martinez Canillas wrote:
> On Wed, Oct 28, 2015 at 1:14 PM, Lee Jones <lee.jones@linaro.org> wrote:
> > On Wed, 28 Oct 2015, Lee Jones wrote:
> >
> >> On Wed, 28 Oct 2015, Javier Martinez Canillas wrote:
> >>
> >> > Hello Joe,
> >> >
> >> > On Wed, Oct 28, 2015 at 12:06 PM, Joe Perches <joe@perches.com> wrote:
> >> > > On Wed, 2015-10-28 at 11:53 +0100, Javier Martinez Canillas wrote:
> >> > >> (Lee) think(s) that the difference between a maintainer and
> >> > >> a reviewer is if a branch with fixes / new features are kept and pull
> >> > >> requests sent while I think that the difference is the level of
> >> > >> involvement someone has with a driver regardless of how patches ends
> >> > >> in the subsystem tree (picked directly by subsystem maintainers or
> >> > >> sent through pull requests).
> >> > >>
> >> > >> Is the first time I heard your definition but maybe I'm the one that
> >> > >> is wrong so it would be great to get a consensus on that and get it
> >> > >> documented somewhere.
> >> > >
> >> > > I think Lee is over-analyzing.
> >> > >
> >> > > From MAINTAINERS:
> >> > >         M: Mail patches to: FullName <address@domain>
> >> > >         R: Designated reviewer: FullName <address@domain>
> >> > >            These reviewers should be CCed on patches.
> >> > >         S: Status, one of the following:
> >> > >            Supported:   Someone is actually paid to look after this.
> >> > >            Maintained:  Someone actually looks after it.
> >> > >
> >> > > "looking after" doesn't mean upstreaming.
> >> > >
> >> >
> >> > Agreed and upstreaming doesn't mean sending pull request, you can for
> >> > example upstream the downstream changes for a driver you maintain by
> >> > posting patches or ack patches others post and let the subsystem
> >> > maintainer to pick those (even if you are listed as the driver
> >> > maintainer in MAINTAINERS).
> >> >
> >> > So by following Lee's definition, then most drivers' maintainers
> >> > should not be called maintainers since keeping a tree with patches for
> >> > both fixes and new features, sending pull requests, etc is only
> >> > justified for drivers that have a lot of changes per release. Is not
> >> > worth it for drivers that are in "maintenance mode" where only bugs
> >> > are fixed every once in a while or features are seldom added.
> >>
> >> Exactly right.
> >>
> >> Although, it looks like M: doesn't even mean Maintainer.  If it did, I
> >> would have made these points over and over until death (or until I got
> >> bored).  However, as M: actually means "Mail patches to", there seems
> >> to be very little difference between that and "Designated reviewer"
> >> and makes me wonder why the R: tag was ever even introduced.  I guess
> >> all of the other guys in the threads below also thought M: meant
> >> Maintainer, or else they would have just added poor old Josh as a
> >> "Mail patches to" recipient and been done with it.
> >
> > Ah, but wait.  get_maintainer.pl *does* assume M means Maintainer
> > doesn't it?  Which is why this came about.  So if we have a "Mail
> > patches to" entry, get_maintainer.pl tells the user that this is a
> 
> Joe already answered but I'll elaborate a little bit:
> 
> "M:" means "Mail patches to" and "S:" means "Status" so what
> get_maintainers.pl is reports the person in "M:" printing the status
> of the file(s).
> 
> So for example if the file has "S: Supported" then the person listed
> in "M:" is shown as "supporter" while if the status is "S:
> Maintained", the person is listed as "maintainer".
> 
> There isn't a "Reviewed" status to specify files that are looked by
> "Designated reviewers", it can be added but I don't see the reason of
> it.

Not sure why you wrote all of this.  We know *why* get_maintainer.pl
does what it does.  What I'm saying is, that I personally believe this
is the wrong behaviour in what I'm *guessing* is the majority of the
time.

> > Maintainer, which (given that there are over 1000 unique M: entries
> > and I know that there are no where near that many actual Maintainers)
> > means that it's printing out incorrect information most of the time.
> 
> Well, that's correct according to your definition of maintainer
> (people with a tree that sends pull requests) but I can believe that
> there are 1K unique maintainers for different small components
> (without taking into account what components may be obsolete / not
> used anymore) even if these maintainers don't send pull request
> because the patch load is low and rely on subsystem maintainers to
> pick directly from the list with their Acks.

Then they are not Maintainers.  They are Reviewers who rely on
Maintainers.  In your example above it's the Maintainers that are
Maintainers and the people who review the code are Reviewers.  The
clues are in the words. ;)

> For me the maintainer is that a) cares about the file and makes sure
> that things remain working, fix issues, reviews patches from others,
> etc b) is someone that actually understand the code in the files. A
> subsystem maintainer has the last word of what gets merged into the
> subsystem but may not be familiar with code under the subsystem and
> relies on the file / driver maintainer to Ack the patch as correct
> since that person is the one that knows the code.

Then what is a Reviewer?

> > So back to my original thought then, what can we do to rectify this
> > situation and make the information printed more meaningful.  Again,
> > I'm back to using the R: tag appropriately.
> >
> > Any (technical, which aren't based on "but I really want to be listed
> > as a Maintainer") thoughts?
> >
> 
> I haven't read a "but I really want to be listed as a maintainer"
> thought in this thread.

If you had no vested interest in this, you would be able to see the
logic in what I'm saying.  Again I'm *guess*, but I think there is
some emotional reasons for you pushing back so hard.  I could always
be wrong though.

> I think the problem is the definition of what a maintainer in Linux
> really means. For you is someone that keeps a tree and sends pull
> request (for me that is what I call a subsystem maintainer)

Right.  A Level 3 Maintainer sends pull-requests to a Level 2
Maintainer, who sends pull-requests to a Level 1 Maintainer, who sends
pull-requests to Linus.  Maintainers at *all* levels collect patches
and Maintain them before sending on.

reiterate:

Reviewers care about particular driver(s)/domain(s) that they know
well.  They provide solid reviews and possible testing (because they
are likely to have the h/w).  They then provide Acked-by:s so that a
Maintainer can collect the patch. 

> while for
> others it seems that maintainer means someone who care about a set of
> files, knows the code, makes sure that things keep working and Ack
> patches to those files when posted.

        goto reiterate;   ;)

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
