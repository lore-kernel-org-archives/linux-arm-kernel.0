From: horms@verge.net.au (Simon Horman)
Date: Sat, 1 Jun 2013 09:00:18 +0900
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
Message-ID: <20130601000018.GB3673@verge.net.au>
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
> 
> There may be some point where we actually need to tell people to
> hold changes back because they are just pushing too large volumes
> through one merge window, resulting in a corresponding amount of
> fixes.
> 
> This merge window both Samsung Exynos and SH mobile seem to
> have been a little bit trigger-happy :-/

To quantify things, for shmobile I am currently aware of 4 problems that
seem to be worthy of fixing for v3.10. A patche for one has been
accepted into arm-soc, Patches for two are this pull request. And one more
has a patch in the pipeline.

These known problems seem to fall into two categories:

1. Problems that have been in linux-next for a while but only recently
   appeared in the renesas tree. These were observed when boot testing kernels
   during the course of rebasing the renesas tree on v3.10-rcX.

   I believe that these problems could and should have been
   spotted earlier by boot testing linux-next more often,
   allowing them to be resolved in the merge-window rather than
   at -rc time.

   I intend to make this happen.

2. Problems that have been present in the renesas tree and
   thus linux-next for a while but were not observed as
   early as they might have been.

   Statistically the rate of these problems could have
   been reduced by accepting changes more slowly.
   But at this point we are talking about one or two bugs out
   of many many changes. Bugs that only affect a small
   subset of shmobile hardware support.
