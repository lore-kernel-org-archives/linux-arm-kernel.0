From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2018 16:07:02 +0100
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
In-Reply-To: <20180713145910.2mlzip5ssk72cleo@localhost>
References: <20180709200956.31158-1-labbott@redhat.com>
 <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
 <20180710093615.GA30095@arm.com>
 <20180713145910.2mlzip5ssk72cleo@localhost>
Message-ID: <20180713150701.GA3049@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On Fri, Jul 13, 2018 at 07:59:10AM -0700, Olof Johansson wrote:
> On Tue, Jul 10, 2018 at 10:36:16AM +0100, Will Deacon wrote:
> > On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
> > > On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> > > > Thanks, Laura.
> > > > 
> > > > I'll take this as a fix, and add a comment to the Makefile to justify
> > > > why we need the linux target.
> > > 
> > > So this comes down to either breaking fedora/debian toolchains (that
> > > don't support elf emulation mode) or breaking bare-metal toolchains
> > > (that don't support linux emulation mode).
> > > 
> > > Since Linux is a bare-metal project that does not technically require
> > > the linux target (who said using "Linux" for all things is confusing?),
> > > I think it should aim for the elf target in the long term.
> > > 
> > > But well, breaking Linux build in common distros isn't good either, so I
> > > guess it makes sense to revert this while distros toolchains are being
> > > fixed. Hopefully, it won't take too long.
> > > 
> > > What do you think?
> > 
> > Yes, we need to revert the change since it's a regression otherwise. I think
> > the best course of action here would be to find a way that we can either
> > tell the linker that it doesn't need the missing linker scripts because
> > we're providing our own, or find a way to pass different LD flags depending
> > on whether or not we have a linux toolchain.
> > 
> > For now, I've pushed the revert to for-next/fixes.
> 
> Hi Will,
> 
> This is regressed in mainline as well. But I think we can just use a (slightly
> improved) ld-option here? I checked it for x86 regression since it uses the
> one-argument version. Patch is here, can you pick that up instead and get it in
> for 4.18-rc?

I already sent the revert to Linus, but I can certainly queue the ld-option
for 4.19 if we pick up some more tested-bys. Could you send it out as its
own patch please?

Cheers,

Will
