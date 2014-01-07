From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Jan 2014 12:11:47 +0000
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <20140106181201.GE1096@mudshark.cambridge.arm.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <20140106181201.GE1096@mudshark.cambridge.arm.com>
Message-ID: <20140107121147.GE29456@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 06:12:01PM +0000, Will Deacon wrote:
> On Thu, Dec 19, 2013 at 11:50:48AM +0000, vijay.kilari at gmail.com wrote:
> > From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> > 
> > Based on the step-handler and break-handler hooks patch from
> > Sandeepa, KGDB debugging support is added for EL1
> > debug in AArch64 mode. Any updates that come for Patch 1 from
> > Sandeepa will be rebased in next version
> > 
> > With second patch,register layout is updated to be inline with GDB tool.
> > Basic GDB connection, break point set/clear and info commands
> > are supported except step/next debugging
> > 
> > With third patch, step/next debugging support is added, where in
> > pc is updated to point to the instruction to be stepped and
> > stopped.
> > 
> > With fourth patch, the compile time breakpoint instruction
> > reordering is fixed by making kgbd_breakpoint() as noinline
> > 
> > Tested with ARM64 simulator
> > 
> > v6:
> >  - Change pstate register to 8 bytes to make endian nuetral.
> >    Use GDB below GDB patch to display pstate in Big endian mode.
> >    https://sourceware.org/ml/gdb-patches/2013-12/msg00720.html
> >    Thanks to Andrew.
> 
> Thanks for getting this new version out. Just a few things before it can be
> applied:
> 
>   1. Can you please use "arm64:" instead of "AArch64:" in the patch
>      subjects?
> 
>   2. Can you get an ack from somebody like Jason on the final patch please?
> 
>   3. Can you rebase onto the for-next/core branch at the arm64 repo:
> 
>        git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> 
>      you'll get a trivial conflict against arch/arm64/kernel/Makefile.

Just to be clear here, I would only recommend rebasing on top of this
branch if there are patches queued for upstream which are required by
the rebased patches and there isn't a topic branch already elsewhere. I
do *not* recommend this branch for any kind of development (though
testing is fine and we can fix the trivial Makefile conflicts
ourselves).

>   4. Can you make sure that the gdb patch you linked to actually gets
>      merged? There is still some discussion by the looks of it.

I guess the kernel patches will have to wait for the binutils patch to
go in. BTW, does this mean that kgdb on arm64 will only work with a
future version of gdb?

-- 
Catalin
