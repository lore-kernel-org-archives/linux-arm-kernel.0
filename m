From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jul 2018 10:36:16 +0100
Subject: [PATCH] Revert "arm64: Use aarch64elf and aarch64elfb emulation
 mode variants"
In-Reply-To: <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
References: <20180709200956.31158-1-labbott@redhat.com>
 <20180710090125.GA28924@arm.com>
 <fcd8d97b6714d787297f1b362558e7a68855a1da.camel@paulk.fr>
Message-ID: <20180710093615.GA30095@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 11:30:39AM +0200, Paul Kocialkowski wrote:
> On Tue, 2018-07-10 at 10:01 +0100, Will Deacon wrote:
> > Thanks, Laura.
> > 
> > I'll take this as a fix, and add a comment to the Makefile to justify
> > why we need the linux target.
> 
> So this comes down to either breaking fedora/debian toolchains (that
> don't support elf emulation mode) or breaking bare-metal toolchains
> (that don't support linux emulation mode).
> 
> Since Linux is a bare-metal project that does not technically require
> the linux target (who said using "Linux" for all things is confusing?),
> I think it should aim for the elf target in the long term.
> 
> But well, breaking Linux build in common distros isn't good either, so I
> guess it makes sense to revert this while distros toolchains are being
> fixed. Hopefully, it won't take too long.
> 
> What do you think?

Yes, we need to revert the change since it's a regression otherwise. I think
the best course of action here would be to find a way that we can either
tell the linker that it doesn't need the missing linker scripts because
we're providing our own, or find a way to pass different LD flags depending
on whether or not we have a linux toolchain.

For now, I've pushed the revert to for-next/fixes.

Will
