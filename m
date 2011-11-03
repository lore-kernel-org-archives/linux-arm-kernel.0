From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 3 Nov 2011 16:08:18 +0100
Subject: [PATCH v2 1/5] ARM: SPMP8000: Add machine base files
In-Reply-To: <CAGVye5OD3uBuBSKVEYMWNABo7ofuYzCmMP3NcDJR8gAAxxAYXQ@mail.gmail.com>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<20111024110015.GA5212@totoro>
	<CAGVye5OD3uBuBSKVEYMWNABo7ofuYzCmMP3NcDJR8gAAxxAYXQ@mail.gmail.com>
Message-ID: <201111031608.18371.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 November 2011, Zoltan Devai wrote:
> 2011/10/24 Jamie Iles <jamie@jamieiles.com>:
> > On Mon, Oct 24, 2011 at 11:13:21AM +0200, Arnd Bergmann wrote:
> >> On Sunday 23 October 2011, Zoltan Devai wrote:
> >> > 2011/10/19 Arnd Bergmann <arnd@arndb.de>:
> >> We talked about it at the ARM subarchitecture maintainer summit, and I think
> >> I'll just merge your platform code for 3.2 if you send the fixed version
> >> in time. I'm not going to merge your clk support patch (2/5) though, since
> >
> > Zoltan uses my device tree bindings and multi IRQ handler for the VIC
> > which hasn't yet been merged (and I haven't had any
> > Tested-by/Acked-by's) from anyone other than Zoltan yet.
> >
> > I suppose the device tree binding and multi IRQ handler patches could
> > go in without the other platform conversions though they haven't had any
> > time in -next.
> Arnd, Russell,
> 
> What about Jamie's VIC patches ?
> Should I wait for those to get in somehow, or rebase SPMP8000
> to not depend on those ?

Sorry I didn't get back to you on this any more. As you may have noticed,
Linus merged a large number of patches through my tree today and yours were
not a part of that.

It's too late for 3.2 now, but everything looks good for 3.3. I'll wait for
Jamie's patches to get stable first and then put your code into the arm-soc
tree.

There are other problems with the process in your series: you should never
cherry-pick a kernel from another branch if you depend on them. Instead,
make sure that the patches are queued up for the next merge window and not
changing any more (they are now obviously, as Linus merged them).

	Arnd
