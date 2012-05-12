From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sat, 12 May 2012 08:37:24 +0200 (CEST)
Subject: [GIT PULL] Urgent fixes (for v3.4 if possible) for Renesas
 ARM-based platforms
In-Reply-To: <CAOesGMieNxya9w=2a0Lv06qbVb2SOtiLTYeWW=kQ9sbkSzbtvg@mail.gmail.com>
References: <201205112025.13478.rjw@sisk.pl>
 <CAOesGMh3g-7oTNBoj2ZWGw+9P1Sf7V89etLb-iZiVoKDEvhO8w@mail.gmail.com>
 <CANqRtoSDN+vYet+9qiNZQq73BdSiqPL3K+95wCbNL29wDvT4EA@mail.gmail.com>
 <CAOesGMieNxya9w=2a0Lv06qbVb2SOtiLTYeWW=kQ9sbkSzbtvg@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.1205120832290.7233@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 11 May 2012, Olof Johansson wrote:

> Hej Magnus,
> 
> On Fri, May 11, 2012 at 9:28 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> >>> ?git://git.kernel.org/pub/scm/linux/kernel/git/rafael/renesas.git fixes
> >>
> >> No such branch (nor tag).
> >
> > I believe Rafael will get back to you about that when he gets to his computer.
> 
> Yep, good.
> 
> >>> Guennadi Liakhovetski (2):
> >>> ? ? ?ARM: mach-shmobile: convert ag5evm to use the generic MMC GPIO hotplug helper
> >>> ? ? ?ARM: mach-shmobile: convert mackerel to use the generic MMC GPIO hotplug helper
> >>
> >> These seem to fix the long-standing build errors on the two platforms,
> >> but that's impossible to tell from reading the commit messages (they
> >> are empty). Care to add one describing why they're important to go in?
> >
> > I only know that a) some boards don't build without these fixes and b)
> > they used to build just fine.
> >
> > Perhaps Guennadi [CC:ed] could be so kind to fill us in with the blanks?
> 
> It was pretty obvious once I tried applying them and building that
> they did indeed resolve the build errors. However, the reason I'm
> asking for a better description is that when looking at just the pull
> request, or even the patch full commit description, it was impossible
> to tell why the patch was urgent as a fix. So, while I am not
> questioning that the patch should be included, I'm just requesting to
> make sure it's properly described. That's also good for historical
> purposes when someone is reading the git logs a year from now, etc.

Ok, sorry, I wasn't sure from the previous mail - would you prefer to 
actually extend their commit messages? As described here

http://thread.gmane.org/gmane.linux.kernel.mmc/12744/focus=12748

These patches are a part of a patch-series, so, when they were submitted 
in that context, it was pretty obvious how they relate to the rest. 
However, unfortunately, they are now applied later than the main patches 
in that series, so, their purpose has become much less obvious, and their 
main feature now seems to be not the conversion of the affected platforms, 
but fixing the build. So, I think, we could use something like this in the 
patch descriptions:

This also fixes modular mmc build on this platform by eliminating the use 
of an inline function, which calls into the mmc core.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
