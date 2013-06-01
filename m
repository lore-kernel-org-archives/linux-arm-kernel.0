From: olof@lixom.net (Olof Johansson)
Date: Fri, 31 May 2013 21:35:44 -0700
Subject: [PATCH 1/2] sh-pfc: r8a7779: Don't group USB OVC and PENC pins
In-Reply-To: <CACRpkda9tjydo038exS2a=Gsvum41LyvXd=GwKh3b0Zi4rOA9g@mail.gmail.com>
References: <1369866529-6372-1-git-send-email-horms+renesas@verge.net.au>
 <1369866529-6372-2-git-send-email-horms+renesas@verge.net.au>
 <CACRpkdZxWsJuvrtH-=VVqAGUCpdgS3W52R4tw5-_QGpggB+1uw@mail.gmail.com>
 <20130531001735.GA26684@verge.net.au>
 <CAOesGMiTXW0mVmbBbha5S4O64yu_vM=eLxM4JyctsfONCAo4qg@mail.gmail.com>
 <20130531054517.GC5009@verge.net.au>
 <CAOesGMgrdyFi3GMz52CVnhzmOYHbR5=29Ua0iS8cNbSjg6r-2A@mail.gmail.com>
 <CACRpkda9tjydo038exS2a=Gsvum41LyvXd=GwKh3b0Zi4rOA9g@mail.gmail.com>
Message-ID: <20130601043544.GA4267@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 09:21:46AM +0200, Linus Walleij wrote:
> On Fri, May 31, 2013 at 8:11 AM, Olof Johansson <olof@lixom.net> wrote:
> > [Simon]
> >> As an aside, I do expect to send some more v3.10 fixes for shmobile.
> >> There seem to be more than usual.
> >
> > A little unfortunate but it's hard to do much about.
> >
> > Please be conservative with what you pick up for 3.10 vs 3.11 -- Linus
> > has said he really wants to see things slow down.
> 
> What we might need to think about is the evolutional pace of the ARM
> kernel - compared to a few years back we have increased the change
> rate by orders of a magnitude (at least that is my feeling...)

Oh, very much so. And there's a lot of additions of new code.

Linus clarified just this week at LC Japan what ticks him off about -rc
patches too; it's an indication that people aren't sending code that's
baked and tested enough during the merge window, causing all these fixes
on top.

Given the rate of change of arm platforms, some of this is definitely
expected (i.e. proportional to amount of merge window changes). Still,
we have empirical evidence that far from all maintainers keep a close
eye on linux-next status for their platforms. :-)

I have a small board farm that I make sure boot more or less daily
with linux-next now, but my space is limited. It also shouldn't be my
responsibility to make sure that various platforms keep working; it's
up to each submaintainer to do so.

That doesn't mean there won't be corner cases still, hardware that
maintainers don't have themselves affected, etc. But by keeping an eye
on linux-next, a handful of -rc fixes can be avoided.

> There may be some point where we actually need to tell people to
> hold changes back because they are just pushing too large volumes
> through one merge window, resulting in a corresponding amount of
> fixes.

That's essentially what we did with the initial multiplatform changes for 3.10
for Exynos, where they seemed to need more bake time and got held off.

> This merge window both Samsung Exynos and SH mobile seem to
> have been a little bit trigger-happy :-/

Both of them saw a lot of changes. Exynos saw the onslaught of Linaro
engineers starting to work more on Arndale, and shmobile saw a huge
amount of changes due to their cutting over subsystems. The latter
is hard to avoid since it can be complicated to keep both old and new
infrastructure around, and the former we should just make sure to catch
with linux-next testing.

But you do bring up valid points, and it's something to keep in mind going
forward.


-Olof
