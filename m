From: vapier@gentoo.org (Mike Frysinger)
Date: Thu, 3 Nov 2011 19:07:42 -0400
Subject: [PATCH 0/3] Change ARCH_NR_GPIO into a Kconfig variable
In-Reply-To: <20111103224452.GS12913@n2100.arm.linux.org.uk>
References: <1320339647-30255-1-git-send-email-pdeschrijver@nvidia.com>
	<201111031816.37427.vapier@gentoo.org>
	<20111103224452.GS12913@n2100.arm.linux.org.uk>
Message-ID: <201111031907.46434.vapier@gentoo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 November 2011 18:44:52 Russell King - ARM Linux wrote:
> On Thu, Nov 03, 2011 at 06:16:33PM -0400, Mike Frysinger wrote:
> > On Thursday 03 November 2011 13:00:44 Peter De Schrijver wrote:
> > > This patchset converts ARCH_NR_GPIO to a Kconfig variable as suggested
> > > by Russel King. It also converts some platforms to the new model.
> > > 
> > > Peter De Schrijver (3):
> > >   ARM: ARCH_NR_GPIO: Make ARCH_NR_GPIO a Kconfig variable
> > >   ARM: mach-shmobile: Use CONFIG_ARCH_NR_GPIO
> > >   ARM: mach-ux500 Use CONFIG_ARCH_NR_GPIO
> > >  
> > >  arch/arm/Kconfig                           |   10 ++++++++++
> > >  arch/arm/include/asm/gpio.h                |    4 ++++
> > >  arch/arm/mach-shmobile/include/mach/gpio.h |    2 --
> > >  arch/arm/mach-ux500/include/mach/gpio.h    |    5 -----
> > >  4 files changed, 14 insertions(+), 7 deletions(-)
> > 
> > i'm not sure how this is an improvement.  we go from declaring the define
> > in the right mach-specific subdir
> > (arch/arm/mach-xxx/include/mach/gpio.h) to an arm-global file
> > (arm/Kconfig).  i'd think the ideal would be to keep all the mach cruft
> > in the mach-xxx/ subdir.
> 
> It most certainly is an improvement.
> 
> One of the things that we (the ARM community as a whole) is focused on to
> is to reduce the amount of code in arch/arm through consolidation, removing
> as much duplication as practical between the various SoCs.
> 
> One of the other factors that we're also focused on is:
> (a) reducing the number of configurations which have to be built to
> properly build-test ARM
> (b) reducing the number of kernels which have to be built to support a
>     range of ARM platforms

i'm aware of these efforts, but i don't see how this Kconfig solution gets you 
there.  it's still a single define depending on arch-specific knobs.  now, if 
this were treated as a max value that was based on all the arch needs, it's 
now useful across SoCs.

> It's one reason why I won't be acking your patch which pushes new stuff
> into the mach/gpio.h headers at a time when we're trying to get rid of
> them.

i already described in the patch that it was an improvement, and that it makes 
things even easier to move away from mach gpio.h.
-mike
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111103/7c327d5b/attachment-0001.sig>
